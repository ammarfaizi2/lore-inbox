Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262714AbUKXPqn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262714AbUKXPqn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 10:46:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262697AbUKXPpz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 10:45:55 -0500
Received: from zeus.kernel.org ([204.152.189.113]:42400 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262737AbUKXPnW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 10:43:22 -0500
To: linux-kernel@vger.kernel.org
From: Eric Sharkey <sharkey@netrics.com>
X-Eric-Conspiracy: There is no conspiracy
Subject: Audio problems on AMD64 with Via K8T800 chipset
Date: Wed, 24 Nov 2004 10:12:24 -0500
Message-Id: <E1CWyoi-00070L-00@mastermind.netrics.internal>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've posted about this problem earlier on the Alsa lists, but
Takashi Iwai has suggested I post here, since he thinks this is
a kernel issue.


There seems to be a problem with Alsa when running on the AMD64
architecture on motherboards with the Via K8T800 chipset.  The sound
is highly irregular, with lots of drop-outs, but also speed-ups,
slow-downs and weird volume changes.

I've got this problem on an Asus K8V SE motherboard.  Rod Smith
has the same problem on an MSI Neo-FSR.
(http://groups.google.com/groups?q=%22asus+k8v%22+alsa&hl=en&lr=&c2coff=1&selm=1et59c-90v.ln%40speaker.rodsbooks.com&rnum=4)

In that post, Rod thought the problem was the Alsa driver for the
on-board sound (VIA VT8237), but this is not the case, as I've installed
a PCI Trident 4DWave NX, and it shows exactly the same behavior.
The problem appears not to be in the low level driver code.

The degree of the problem is highly sensitive to the load on the
CPU at the time.  Games like bumprace, which use multiple threads
and never sleep (giving load values around 8), sound awful.  Most
games like tuxkart, which keep the load under 1, sound perfectly fine.

And yet, some things sound bad even when the CPU isn't loaded.
timidity++ is a good example.

This happens with both 64 and 32 bit kernels, and no amount of
twiddling with kernel parameters (ACPI/CPU frequency scaling, apic,
preemption, etc.) seems to make any difference.

Can anyone here offer a suggestion?

(Currently, I'm running 2.6 series kernels.  I haven't yet tried
older versions.)

Eric

