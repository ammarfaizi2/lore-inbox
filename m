Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751373AbWHCT4e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751373AbWHCT4e (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 15:56:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751377AbWHCT4e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 15:56:34 -0400
Received: from mx1.redhat.com ([66.187.233.31]:50850 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751373AbWHCT4d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 15:56:33 -0400
Date: Thu, 3 Aug 2006 15:56:17 -0400
From: Dave Jones <davej@redhat.com>
To: Greg KH <greg@kroah.com>
Cc: Zachary Amsden <zach@vmware.com>, Arjan van de Ven <arjan@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>,
       Rusty Russell <rusty@rustcorp.com.au>, Jack Lo <jlo@vmware.com>
Subject: Re: A proposal - binary
Message-ID: <20060803195617.GD16927@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, Greg KH <greg@kroah.com>,
	Zachary Amsden <zach@vmware.com>,
	Arjan van de Ven <arjan@infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	Christoph Hellwig <hch@infradead.org>,
	Rusty Russell <rusty@rustcorp.com.au>, Jack Lo <jlo@vmware.com>
References: <44D1CC7D.4010600@vmware.com> <1154603822.2965.18.camel@laptopd505.fenrus.org> <44D23B84.6090605@vmware.com> <20060803190327.GA14237@kroah.com> <44D24B31.2080802@vmware.com> <20060803193600.GA14858@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060803193600.GA14858@kroah.com>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2006 at 12:36:00PM -0700, Greg Kroah-Hartman wrote:

 > > That is good to know.  But there is a kernel option which doesn't make 
 > > much sense in that case:
 > > 
 > > [*] Select only drivers that don't need compile-time external firmware
 > 
 > No, that is very different.  That option is present if you don't want to
 > build some firmware images from the source that is present in the kernel
 > tree, and instead, use the pre-built stuff that is also present in the
 > kernel tree.

You're describing PREVENT_FIRMWARE_BUILD.  The text Zach quoted is from
STANDALONE, which is something else completely.  That allows us to not
build drivers that pull in things from /etc and the like during compile.
(Whoever thought that was a good idea?)

		Dave

-- 
http://www.codemonkey.org.uk
