Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263777AbTFWG1p (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 02:27:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263897AbTFWG1p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 02:27:45 -0400
Received: from [213.171.53.133] ([213.171.53.133]:29199 "EHLO gulipin.miee.ru")
	by vger.kernel.org with ESMTP id S263777AbTFWG1o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 02:27:44 -0400
Date: Mon, 23 Jun 2003 09:43:47 +0400
From: Samium Gromoff <deepfire@ibe.miee.ru>
To: linux-kernel@vger.kernel.org
Subject: auotoirq_{setup,report} unused and obsolete?
Message-Id: <20030623094347.47ccffe8.deepfire@ibe.miee.ru>
X-Mailer: Sylpheed version 0.9.0 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Given that hardware probing should now be performed with probe_irq_{on,off} and
the following:

        deepfire@betelheise:/usr/src/grp.KERNEL/72-bk1$ grep autoirq_ . -rI
        ./arch/m68k/kernel/entry.S:     movel   %a0@(autoirq_list-VECOFF(VEC_SPUR)),%a0
        ./drivers/net/eepro.c:          cards, I will do autoirq_request() to grab the next
        ./drivers/net/auto_irq.c:    To use this, first call autoirq_setup(timeout). TIMEOUT is how many
        ./drivers/net/auto_irq.c:    and can usually be zero at boot.  'autoirq_setup()' returns the
bit
        ./drivers/net/auto_irq.c:    Finally call autoirq_report(TIMEOUT) to find out which IRQ line
was
        ./drivers/net/auto_irq.c:void autoirq_setup(int waittime)
        ./drivers/net/auto_irq.c:int autoirq_report(int waittime)
        ./drivers/net/auto_irq.c:EXPORT_SYMBOL(autoirq_setup);
        ./drivers/net/auto_irq.c:EXPORT_SYMBOL(autoirq_report);
        grep: ./drivers/input/joystick/grip_mp.c: Permission denied
        grep: ./include/video/neomagic.h: Permission denied

i.e. its totally unused, shouldn`t it be finally dead?

regards, Samium Gromoff
