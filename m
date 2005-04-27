Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261700AbVD0P5O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261700AbVD0P5O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 11:57:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261772AbVD0P5O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 11:57:14 -0400
Received: from filip.math.uni.lodz.pl ([212.191.65.243]:524 "EHLO
	filip.math.uni.lodz.pl") by vger.kernel.org with ESMTP
	id S261700AbVD0P4z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 11:56:55 -0400
Message-ID: <426FB641.2070802@filip.math.uni.lodz.pl>
Date: Wed, 27 Apr 2005 17:56:49 +0200
From: Filip Zyzniewski <lkml@filip.math.uni.lodz.pl>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050420)
X-Accept-Language: pl, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Panic on a BIOSless machine.
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I managed to boot kernel on a biosless box (Compaq T1000 Windows
based terminal). It has 32MB of ram.


But it panics (sometimes it even launches bash and allows me to run some
stuff).

kernel log gathered from serial console:
http://filip.math.uni.lodz.pl/t1000-panic/panic.log

asm code used to boot kernel:
http://filip.math.uni.lodz.pl/t1000-panic/boot.S

tool bundling boot and kernel together:
http://filip.math.uni.lodz.pl/t1000-panic/mk.c

kernel config:
http://filip.math.uni.lodz.pl/t1000-panic/kernel-config

I had to comment out: jnz 2f # New command line protocol
from arch/i386/kernel/head.S (2.6.11.7) (bootloader too old?).

Is there anything I could do to prevent it? I don't know memory map of
this computer, is this the cause? I can't see video RAM on board, so
maybe it is shared with system RAM? What do you think?

bye,
Filip Zyzniewski
Ekatalog
