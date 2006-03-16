Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932686AbWCPT70@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932686AbWCPT70 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 14:59:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932690AbWCPT7Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 14:59:25 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:20115 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932686AbWCPT7Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 14:59:25 -0500
Date: Thu, 16 Mar 2006 20:59:11 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Anton Altaparmakov <aia21@cam.ac.uk>
cc: Christoph Hellwig <hch@infradead.org>,
       "Randy.Dunlap" <rdunlap@xenotime.net>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, aia21@cantab.net, len.brown@intel.com
Subject: Re: [patch 1/1] consolidate TRUE and FALSE
In-Reply-To: <Pine.LNX.4.64.0603161640230.31173@hermes-2.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.61.0603162056350.11776@yvahk01.tjqt.qr>
References: <200603161004.k2GA46Fc029649@shell0.pdx.osdl.net>
 <20060316160129.GB6407@infradead.org> <20060316082951.58592fdc.rdunlap@xenotime.net>
 <20060316163001.GA7222@infradead.org> <20060316083654.d802f3f3.rdunlap@xenotime.net>
 <20060316163621.GA7519@infradead.org> <Pine.LNX.4.64.0603161640230.31173@hermes-2.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> of course.  but that it's not used in core code implies this opinion is
>> widely shared.
>
>[...]  To me it is a simple consequence of there not 
>being a boolean type in the kernel so you cannot use it in the core code.  

	typedef bool int;

And then happily use if(EXPR) and if(!EXPR) instead of if(EXPR == TRUE) or 
if(EXPR == FALSE).  :-)

But typedeffing it to int (or unsigned char, if someone likes that 
for space optimization) does not "catch overflows" (see another lkml 
mail from me) as _Bool would.


Jan Engelhardt
-- 
