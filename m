Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268157AbUIKOKR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268157AbUIKOKR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 10:10:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268155AbUIKOKR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 10:10:17 -0400
Received: from zero.aec.at ([193.170.194.10]:36357 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S268157AbUIKOJr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 10:09:47 -0400
To: SashaK <sashak@smlink.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: GPL source code for Smart USB 56 modem (includes ALSA AC97 
 patch)
References: <2DdiX-6ye-17@gated-at.bofh.it> <2Dfup-7Zv-9@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Sat, 11 Sep 2004 16:09:41 +0200
In-Reply-To: <2Dfup-7Zv-9@gated-at.bofh.it> (sashak@smlink.com's message of
 "Sat, 11 Sep 2004 14:50:09 +0200")
Message-ID: <m3k6v0lwwq.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

SashaK <sashak@smlink.com> writes:

> On Sat, 11 Sep 2004 12:26:00 +0200 (MEST)
> Mikael Pettersson <mikpe@csd.uu.se> wrote:
>
>> I hope you succeed with open-sourcing all of slmodem's driver
>> code. My Targa Athlon64 laptop has the AMR thingy and the
>> 32-bit x86 binary only slmodem driver prevents me from using
>> the modem while running a 64-bit kernel.
>
> You mean to GPL user-space program slmodemd?
> I think it is good idea, but unfortunately this code is not just my, and
> final decision was 'no'.

One way that would work is to make the binary parts of your driver run
in user space and let the kernel part just provide a kind of simple
sound card.  The later should be much easier to free.

Modern CPUs are usually fast enough that the additional latency
caused by this doesn't matter.

The 64bit kernel can run 32bit programs without problems.

-Andi

