Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267266AbRGKKD4>; Wed, 11 Jul 2001 06:03:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267271AbRGKKDn>; Wed, 11 Jul 2001 06:03:43 -0400
Received: from rhenium.btinternet.com ([194.73.73.93]:50423 "EHLO rhenium")
	by vger.kernel.org with ESMTP id <S267266AbRGKKD2>;
	Wed, 11 Jul 2001 06:03:28 -0400
Reply-To: <lar@cs.york.ac.uk>
From: "Laramie Leavitt" <laramie.leavitt@btinternet.com>
To: "David Balazic" <david.balazic@uni-mb.si>, <cslater@wcnet.org>,
        <linux-kernel@vger.kernel.org>
Subject: RE: Switching Kernels without Rebooting?
Date: Wed, 11 Jul 2001 11:08:02 +0100
Message-ID: <JKEGJJAJPOLNIFPAEDHLGEEFDFAA.laramie.leavitt@btinternet.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
In-Reply-To: <3B4C21DA.5FFCBE2@uni-mb.si>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> This is not a problem at all, because UNIX does not guarantee that
> a process will get at least one CPU slice every X seconds.
> ( read : UNIX is not a real time system )
>
> soft-suspend "freezes" processes for several hours anyway ...
>
> Note that there is a patch for hot replacing a kernel, which is equivalent
> to rebooting, but much faster :
> Two Kernel Monte (Linux loading Linux on x86)
> http://www.scyld.com/products/beowulf/software/monte.html
>

So if the Two Kernel Monte patch was combined with the
system suspend/resume in swap patch then you add some
transitions so that the code path does this:

1-  Suspend->Monte
2-  Monte->Load new Kernel
3-  Load->Resume.

If it was just for very similar kernels, i.e. most
-pre and -ac kernels it would probably work fine.
If not, then you could just do the Monte route.

Laramie

