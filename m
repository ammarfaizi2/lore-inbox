Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261159AbUC1LHU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 06:07:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261160AbUC1LHU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 06:07:20 -0500
Received: from madrid10.amenworld.com ([62.193.203.32]:34566 "EHLO
	madrid10.amenworld.com") by vger.kernel.org with ESMTP
	id S261159AbUC1LHT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 06:07:19 -0500
Date: Thu, 25 Mar 2004 12:51:31 +0100
From: DervishD <raul@pleyades.net>
To: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Problems with my parport (and printer)
Message-ID: <20040325115131.GA12195@DervishD>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4.2.1i
Organization: Pleyades
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi all :)

    I have a printer connected thru my parallel port, supported in
the kernel by parport+parport_pc+lp:

kernel: parport0: PC-style at 0x378 (0x778), irq 7 [PCSPP,TRISTATE]
kernel: parport0: Printer, Lexmark International Lexmark Optra E312
kernel: lp0: using parport0 (interrupt-driven).
kernel: lp0: console ready

    It works ok, BTW... The problem is that, when the printer is
switched of and I try to print something, the print command just
blocks, no error, no messages, nothing. I use a shell function to
print, which sends a control command to the printer and after that
sends the file I want to print. It stops (forever) at the reset
command, something like "echo -n '\eE' > /dev/printer".

    Why this operation doesn't fail? IMHO, it should fail with
ENODEV, because parport can work (the parallel port is there...), but
lp shouldn't (the printer is switched off...).

    BTW, I would swear I have the parallel port configured as EPP+ECP
with DMA3 and irq 7 :??? Why is it detected as PCSPP?

    Any help? Thanks in advance :)

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736
http://www.pleyades.net & http://raul.pleyades.net/
