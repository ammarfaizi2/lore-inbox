Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267580AbRG2Jp4>; Sun, 29 Jul 2001 05:45:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267633AbRG2Jpq>; Sun, 29 Jul 2001 05:45:46 -0400
Received: from gateway2.ensim.com ([65.164.64.250]:15369 "EHLO
	nasdaq.ms.ensim.com") by vger.kernel.org with ESMTP
	id <S267584AbRG2Jpd>; Sun, 29 Jul 2001 05:45:33 -0400
X-mailer: xrn 8.03-beta-26
From: Paul Menage <pmenage@ensim.com>
Subject: Re: Detecting x86 SMP on a UP kernel
To: John Levon <moz@compsoc.man.ac.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <0C01A29FBAE24448A792F5C68F5EA47D142557@nasdaq.ms.ensim.com>
Message-Id: <E15Qn81-0002EK-00@pmenage-dt.ensim.com>
Date: Sun, 29 Jul 2001 02:44:53 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

>
>Hi, I need to be able to detect underlying x86 SMP hardware
>when running a UP kernel, from a module.
>

A simple and AFAIK reasonably reliable user-space approach is to use
the mptable program, and grep the output for the string "AP,"
(additional processor). If you're looking for SMP support in the
motherboard, rather than the existence of the additional processor(s),
then you might want to parse the output in other ways.

You could probably do this more directly from within the kernel, but
mptable may provide a useful starting point.

You can find mptable at http://www.ima.umn.edu/~klee/linux/mptable.c

Paul
