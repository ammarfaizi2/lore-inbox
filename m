Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317540AbSGETAf>; Fri, 5 Jul 2002 15:00:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317542AbSGETAe>; Fri, 5 Jul 2002 15:00:34 -0400
Received: from mraos.ra.phy.cam.ac.uk ([131.111.48.8]:9858 "EHLO
	mraos.ra.phy.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S317540AbSGETAd>; Fri, 5 Jul 2002 15:00:33 -0400
To: Jan Harkes <jaharkes@cs.cmu.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: Thinkpad 560 suspend/hibernate requires floppy 
In-Reply-To: Your message of "Sun, 30 Jun 2002 13:55:22 EDT."
             <20020630175522.GA26454@ravel.coda.cs.cmu.edu> 
Date: Fri, 05 Jul 2002 20:03:04 +0100
From: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Message-Id: <E17QYMC-0006Se-00@coll.ra.phy.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> # CONFIG_APM_ALLOW_INTS is not set

> Enable this, the bios seems to want interrupts enabled, especially when
> suspending to disk.

I'll try that.   Though I'm running bios v1.11 on the TP560, not v1.20
(which apparently requires CONFIG_APM_ALLOW_INTS to be set).

For now, I've found that to get hibernate/suspend working again, I
don't even need to have a floppy drive attached or even use
mount/umount.  All I have to do is:

% modprobe -r floppy
% modprobe floppy

then I can suspend or hibernate with no problem.

-Sanjoy
