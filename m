Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291043AbSBSK0e>; Tue, 19 Feb 2002 05:26:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291044AbSBSK0Y>; Tue, 19 Feb 2002 05:26:24 -0500
Received: from E0-IBE.r.miee.ru ([194.226.0.89]:50192 "EHLO ibe.miee.ru")
	by vger.kernel.org with ESMTP id <S291043AbSBSK0O>;
	Tue, 19 Feb 2002 05:26:14 -0500
From: Samium Gromoff <root@ibe.miee.ru>
Message-Id: <200202191318.g1JDIcm12054@ibe.miee.ru>
Subject: NE2k driver issue
To: linux-kernel@vger.kernel.org
Date: Tue, 19 Feb 2002 16:18:38 +0300 (MSK)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	I`ve experienced a very strange relationship between
ISA sb card generated interrupts and network NIC perfomance.

	The situation was the next: i`ve performed a data transfer from
a remote samba share to the local box thru a 10Mbit ISA NIC.
What has been varying was the interrupt load of the sound card.
With esd started the sound card generated 500-600 interrupts/second,
with no esd, it didnt generated interrupts.

	Theoretically the sbcard interrupts should make the NIC starve
and reduce the NIC performance. But the situation i`ve experienced
was weird as hell.

	With esd started the samba transfer maxes out at 400kb/s.
	With esd stopped it immediately drops down to 30-35 kb/s.

This is also well reflected by the NIC interrupt rate cutting down
by 90% with esd stopped.

	Info: linux-2.4.17-rmap12e, NE2k ISA NIC, SB16 Vibra ISA

regards, Samium Gromoff

