Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266837AbUJNS3a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266837AbUJNS3a (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 14:29:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266805AbUJNS3B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 14:29:01 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:8579 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266837AbUJNRgj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 13:36:39 -0400
Date: Thu, 14 Oct 2004 18:36:37 +0100
From: Matthew Wilcox <matthew@wil.cx>
To: Brian Gerst <bgerst@didntduck.org>
Cc: "Martin K. Petersen" <mkp@wildopensource.com>,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org, akpm@osdl.org,
       tony.luck@intel.com
Subject: Re: [PATCH] General purpose zeroed page slab
Message-ID: <20041014173637.GQ16153@parcelfarce.linux.theplanet.co.uk>
References: <yq1oej5s0po.fsf@wilson.mkp.net> <416EB7AD.4040302@didntduck.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <416EB7AD.4040302@didntduck.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2004 at 01:30:21PM -0400, Brian Gerst wrote:
> This doesn't work as you expect it does.  The constructor is only called 
> when a new slab is created, for each new object on the slab.  It is 
> _not_ run again when an object is freed.  So if a page is freed then 
> immediately reallocated it will contain garbage.

The user is responsible for zeroing the page before handing it back to
the slab allocator.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
