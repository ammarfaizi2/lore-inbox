Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266622AbUHBQyF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266622AbUHBQyF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 12:54:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266630AbUHBQyF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 12:54:05 -0400
Received: from madrid10.amenworld.com ([62.193.203.32]:32273 "EHLO
	madrid10.amenworld.com") by vger.kernel.org with ESMTP
	id S266622AbUHBQx7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 12:53:59 -0400
Date: Mon, 2 Aug 2004 18:41:16 +0200
From: DervishD <raul@pleyades.net>
To: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: [SOLVED] parport problems, thanks to Dino Klein
Message-ID: <20040802164116.GB1102@DervishD>
Mail-Followup-To: Linux-kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4.2.1i
Organization: Pleyades
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi all :)

    Finally I got ECP working. The solution: activate
CONFIG_EXPERIMENTAL and CONFIG_PARPORT_PC_FIFO (in 2.4.26, at least),
and get rid of EPP+ECP mode in BIOS. Now I have only ECP in BIOS (I
tested more modes, anyway) and the kernel detects correctly the
parallel port as long as I provide the irq, dma, io and io_hi
settings to the module.

    My other problem was lack of IEEE1284 support, and, once ECP
detected, I went to solve this. The problem was related to cabling
and one digital printer sharing device. The device detects
automatically which input wants the printer, so you don't need to
manually turn the knob ;). That device was eating the IEEE1284
signalling, and once removed all works ok.

    The parport module still does weird things when the BIOS mode is
not EPP nor ECP, or when I want it to autodetect the parallel port,
but at least now prints correctly, fast and tells me when I'm out of
paper ;))

    I want to thank Dino Klein for his highly valuable help, trying
to solve my problem. He has helped me to find the cause of the
problem, even backporting his 2.6 ACPI patch to my 2.4.26 kernel. Is
people like him that makes free software the way it is, and really no
money could buy such a good and friendly support. Thanks a lot, Dino.

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736
http://www.pleyades.net & http://raul.pleyades.net/
