Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263426AbTECVXi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 May 2003 17:23:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263427AbTECVXh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 May 2003 17:23:37 -0400
Received: from 147.catv45.aar01.lan.ch ([212.60.45.147]:18957 "EHLO
	bolli.homeip.net") by vger.kernel.org with ESMTP id S263426AbTECVXf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 May 2003 17:23:35 -0400
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii; format=flowed
Date: Sat, 03 May 2003 23:35:53 +0200
From: "Beat Bolli (privat)" <bbolli@ymail.ch>
Message-ID: <3EB43639.1020705@ymail.ch>
MIME-Version: 1.0
Subject: [2.5.68-bk-current] irq event: bogus retval mask with xirc2ps_cs
To: linux-kernel@vger.kernel.org
User-Agent: Mozilla/5.0 (Windows; U; Win98; en-US; rv:1.4a) Gecko/20030401
X-Accept-Language: en-us, en, de
X-AntiVirus: OK! AntiVir MailGate Version 2.0.0.6
	 at bolli.homeip.net has not found any known virus in this email.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all!

This is what I get for a "ping -c1" from my desktop machine to my 2.5 
test system:

May  3 23:11:38 brick kernel: irq event 9: bogus retval mask 4
May  3 23:11:38 brick kernel: Call Trace: [handle_IRQ_event+119/224]
	[do_IRQ+169/336]  [default_idle+0/64]  [rest_init+0/96]
	[common_interrupt+24/32]  [default_idle+0/64]  [rest_init+0/96]
	[default_idle+40/64]  [cpu_idle+42/64]  [start_kernel+326/336]
May  3 23:11:38 brick kernel: handlers:
May  3 23:11:38 brick kernel: [__crc___lock_sock+24444/786751]
May  3 23:11:38 brick kernel: irq event 9: bogus retval mask 4
May  3 23:11:38 brick kernel: Call Trace: [handle_IRQ_event+119/224]
	[do_IRQ+169/336]  [common_interrupt+24/32]
	[fb_get_buffer_offset+112/176]  [soft_cursor+221/544]
	[mod_timer+227/416]  [schedule+436/960]  [fb_flashcursor+49/64]
	[worker_thread+457/720]  [fb_flashcursor+0/64]
	[default_wake_function+0/32]  [ret_from_fork+6/32]
	[default_wake_function+0/32]  [worker_thread+0/720]
	[kernel_thread_helper+5/16]
May  3 23:11:38 brick kernel: handlers:
May  3 23:11:38 brick kernel: [__crc___lock_sock+24444/786751]

The test system is a Toshiba 500CDT laptop with a Xircom PEM28 combined 
network/modem card using the xirc2ps_cs driver.

The card works fine, I assume this is just a warning, but I get it for 
each network packet sent or received. I can provide more info if needed.

Beat Bolli


