Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267356AbUJNSzF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267356AbUJNSzF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 14:55:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267335AbUJNSyJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 14:54:09 -0400
Received: from mx1.redhat.com ([66.187.233.31]:20866 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267338AbUJNSuI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 14:50:08 -0400
Date: Thu, 14 Oct 2004 14:49:15 -0400
From: Dave Jones <davej@redhat.com>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Brian Gerst <bgerst@didntduck.org>,
       "Martin K. Petersen" <mkp@wildopensource.com>,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org, akpm@osdl.org,
       tony.luck@intel.com
Subject: Re: [PATCH] General purpose zeroed page slab
Message-ID: <20041014184915.GE18321@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Matthew Wilcox <matthew@wil.cx>, Brian Gerst <bgerst@didntduck.org>,
	"Martin K. Petersen" <mkp@wildopensource.com>,
	linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
	akpm@osdl.org, tony.luck@intel.com
References: <yq1oej5s0po.fsf@wilson.mkp.net> <416EB7AD.4040302@didntduck.org> <20041014173637.GQ16153@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041014173637.GQ16153@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2004 at 06:36:37PM +0100, Matthew Wilcox wrote:
 > On Thu, Oct 14, 2004 at 01:30:21PM -0400, Brian Gerst wrote:
 > > This doesn't work as you expect it does.  The constructor is only called 
 > > when a new slab is created, for each new object on the slab.  It is 
 > > _not_ run again when an object is freed.  So if a page is freed then 
 > > immediately reallocated it will contain garbage.
 > 
 > The user is responsible for zeroing the page before handing it back to
 > the slab allocator.

That sounds like an accident waiting to happen.
How about a CONFIG_DEBUG option to check its zeroed on free ?

		Dave

