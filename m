Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271126AbRHTIYy>; Mon, 20 Aug 2001 04:24:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271130AbRHTIYo>; Mon, 20 Aug 2001 04:24:44 -0400
Received: from pf107.gdansk.sdi.tpnet.pl ([213.77.129.107]:14096 "EHLO
	alf.amelek.gda.pl") by vger.kernel.org with ESMTP
	id <S271126AbRHTIYc>; Mon, 20 Aug 2001 04:24:32 -0400
Subject: Compaq Notebook 100 + yenta_socket problem
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Mon, 20 Aug 2001 10:22:43 +0200 (CEST)
X-Mailer: ELM [version 2.4ME+ PL89 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <E15YkKa-0000pw-00@mm.amelek.gda.pl>
From: Marek Michalkiewicz <marekm@amelek.gda.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Following up my earlier bug report sent to linux-kernel...

I can confirm that the standalone PCMCIA drivers (pcmcia-cs-3.1.28)
work fine for me under 2.4.x too, the problem is specific to the
yenta_socket driver in the kernel.  After it is loaded (even if
later unloaded), any BIOS-related functions cause immediate power-off
of the machine, or a hard lockup, or hard lockup with backlight off
but HDD still spinning, sometimes changing the RTC by a few hours.
After such lockup (if it doesn't power off), the power button must
be held for a few seconds (the machine has no reset button).

By "any BIOS-related functions" I mean rebooting, suspending by
closing the lid, loading apm.o module, running "apm" if the driver
was compiled in, or even simply changing brightness or contrast
with Fn-key combinations.  Sometimes it just happens without me
doing anything.  Could be that yenta_socket driver initialization
overwrites some memory containing SMM code?

On an unrelated note, there seems to be some APM BIOS bug, where
remaining battery life is reported as 150 seconds when it should
be 150 minutes.  This is the case under both 2.2.x and 2.4.x.

Thanks,
Marek

