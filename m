Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261582AbVCDGVX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261582AbVCDGVX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 01:21:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262149AbVCDGVX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 01:21:23 -0500
Received: from fire.osdl.org ([65.172.181.4]:20901 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261582AbVCDGUr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 01:20:47 -0500
Date: Thu, 3 Mar 2005 22:20:15 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: chrisw@osdl.org, olof@austin.ibm.com, paulus@samba.org, rene@exactcode.de,
       torvalds@osdl.org, linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: [PATCH] trivial fix for 2.6.11 raid6 compilation on ppc w/
 Altivec
Message-Id: <20050303222015.6a7b05ad.akpm@osdl.org>
In-Reply-To: <4227FC5C.60707@pobox.com>
References: <422751D9.2060603@exactcode.de>
	<422756DC.6000405@pobox.com>
	<16935.36862.137151.499468@cargo.ozlabs.ibm.com>
	<20050303225542.GB16886@austin.ibm.com>
	<20050303175951.41cda7a4.akpm@osdl.org>
	<20050304022424.GA26769@austin.ibm.com>
	<20050304055451.GN5389@shell0.pdx.osdl.net>
	<20050303220631.79a4be7b.akpm@osdl.org>
	<4227FC5C.60707@pobox.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> wrote:
>
> > Neither solution is acceptable, really.  I suspect the idea of pulling
>  > linux-release into mainline won't work very well, and that making it a
>  > backport tree would be more practical.
> 
>  Maybe you're right, but I tend to think that "quick, get that fix out 
>  immediately" fixes will appear before more substantial fixes.  That is 
>  certainly the way things have worked up until now.
> 
>  For the cases that we care about, putting that into linux-release and 
>  then pulling would seem more appropriate.
> 
>  Remember, the linux-release tree for each release will slow down, and 
>  eventually die off, as we progress towards the next release (where the 
>  linux-2.6.x.y-1 tree will indeed die).

Yup.  But anyway, there's no point in overdesigning all this.  Let's suck
it and see.  If it doesn't work we can populate linux-release by some other
means.  The downstream users of linux-release won't see any change as a
result of that.

