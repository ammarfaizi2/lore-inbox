Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268387AbRGXRjW>; Tue, 24 Jul 2001 13:39:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268388AbRGXRjM>; Tue, 24 Jul 2001 13:39:12 -0400
Received: from zenith102.desy.de ([131.169.43.185]:45574 "EHLO
	zenith102.desy.de") by vger.kernel.org with ESMTP
	id <S268387AbRGXRjD>; Tue, 24 Jul 2001 13:39:03 -0400
Date: Tue, 24 Jul 2001 19:39:04 +0200 (CEST)
From: Stefan Stonjek <stefan@zenith102.desy.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: variable dumpable changed place in sched.h 
Message-ID: <Pine.LNX.4.33.0107241933060.32445-100000@zenith102.desy.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Today I tried to compile arla 0.35.5 for the new 2.4.7 Linux kernel.
I figured out that linux/include/linux/sched.h changed in a way which
blocks arla.

The variable "dumpable" moved from the "task_struct" to "mm_struct". Since
"task_struct" includes two pointers to "mm_struct" I do not know which
variable (mm->dumpable or active_mm->dumpable) takes over the role of the
single "dumpable" variable from the older kernels?

Maybe someone can tell me, so I can patch arla.

Tschuess
	Stefan

