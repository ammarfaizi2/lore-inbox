Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282132AbRKWMJZ>; Fri, 23 Nov 2001 07:09:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282133AbRKWMJR>; Fri, 23 Nov 2001 07:09:17 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:7644 "EHLO e21.nc.us.ibm.com")
	by vger.kernel.org with ESMTP id <S282132AbRKWMJE>;
	Fri, 23 Nov 2001 07:09:04 -0500
Message-Id: <200111231208.fANC8t427664@eng4.beaverton.ibm.com>
To: Oliver.Neukum@lrz.uni-muenchen.de
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Remove needless BKL from release functions 
In-Reply-To: Your message of "Fri, 23 Nov 2001 11:10:25 +0100."
             <Pine.SOL.4.33.0111231106530.7403-100000@sun3.lrz-muenchen.de> 
Date: Fri, 23 Nov 2001 04:08:54 -0800
From: Rick Lindsley <ricklind@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wrote:

    If you check the web page at
    http://lse.sourceforge.net/lockhier/patches.html, you'll find
    additional information on why this patch was produced.  The most common
    "no-op" was that (BKL) locking was done during release but not during
    open. In some cases, there truly are things to guard. In some cases,
    there really isn't. In all cases, nothing was really being correctly
    guarded.

Oliver.Neukum@lrz.uni-muenchen.de replied:
    
    While this is doubtlessly true, please don't do things like removing the
    lock from interfaces like the call to open() in the input subsystem.
    People may depend on the lock being held there. Having open() under BKL
    simplifies writing USB device drivers.

The good news is, the patches addressed unnecessary BKL's in release(),
not open(), so I don't think the patches we submitted will cause you to
lose any sleep.  The better news is, Christoph has even produced a
patch to address your concerns (which it sounds like you like.)  The
best news is, the kernel is cleaner now in multiple ways.

Life is good.

Rick
