Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276764AbRJ0TYR>; Sat, 27 Oct 2001 15:24:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276877AbRJ0TYI>; Sat, 27 Oct 2001 15:24:08 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:25074 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S276764AbRJ0TXy>;
	Sat, 27 Oct 2001 15:23:54 -0400
Date: Sat, 27 Oct 2001 21:24:27 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200110271924.VAA07320@harpo.it.uu.se>
To: arjan@fenrus.demon.nl
Subject: Re: [PATCH] fix 2.4 SMP kernel hang on UP P4
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Oct 2001 18:18:58 +0100, arjan@fenrus.demon.nl wrote:
>> A 2.4 kernel built with SMP or UP_APIC support may hang during boot
>> if run on a UP P4 machine. The patch below fixes this, please apply.
>
>can you also try a very recent -ac kernel (smp) and pass "acpismp=force" on
>the lilo commandline ?

Tried 2.4.13-ac3 with CONFIG_SMP=y and acpismp=force.
It's a UP box, no SMP config is found, so get_smp_config()
and config_acpi_tables() are never called. Hangs like before.
