Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131293AbRBUDCv>; Tue, 20 Feb 2001 22:02:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131440AbRBUDCl>; Tue, 20 Feb 2001 22:02:41 -0500
Received: from asbestos.linuxcare.com.au ([203.17.0.30]:52220 "EHLO halfway")
	by vger.kernel.org with ESMTP id <S131275AbRBUDC0>;
	Tue, 20 Feb 2001 22:02:26 -0500
From: Rusty Russell <rusty@linuxcare.com.au>
To: Philipp Rumpf <prumpf@mandrakesoft.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.1-ac15 
In-Reply-To: Your message of "Mon, 19 Feb 2001 05:54:11 CDT."
             <Pine.LNX.3.96.1010219054120.16489F-100000@mandrakesoft.mandrakesoft.com> 
Date: Wed, 21 Feb 2001 14:02:04 +1100
Message-Id: <E14VPXZ-0007HS-00@halfway>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.3.96.1010219054120.16489F-100000@mandrakesoft.mandrakesoft
.com> you write:
> > We unlink the module
> > We free the memory
> > 
> > At the same time another cpu may be walking the exception table that we fre
e.
> 
> True.
> 
> Rusty had a patch that locked the module list properly IIRC.

This is a while back, but I thought the solution Philipp and I came up
with was to simply used a rw semaphore for this, which was taken (read
only) on page fault if we have to scan the exception table.

Rusty.
--
Premature optmztion is rt of all evl. --DK
