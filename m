Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129848AbRBYFgF>; Sun, 25 Feb 2001 00:36:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129851AbRBYFfz>; Sun, 25 Feb 2001 00:35:55 -0500
Received: from comunit.de ([195.21.213.33]:27739 "HELO comunit.de")
	by vger.kernel.org with SMTP id <S129848AbRBYFfo>;
	Sun, 25 Feb 2001 00:35:44 -0500
Date: Sun, 25 Feb 2001 06:35:42 +0100 (CET)
From: Sven Koch <haegar@sdinet.de>
X-X-Sender: <haegar@space.comunit.de>
To: <linux-kernel@vger.kernel.org>
cc: Andre Hedrick <andre@linux-ide.org>
Subject: 2.4.2-ac3 IDE-Module-Deadlock on DEC Alpha
Message-ID: <Pine.LNX.4.32.0102250626340.24260-100000@space.comunit.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi...

Machine: DEC Alpha XL300 (Alcor/XLT)
         boots from scsi, and ide is used modular
IDE-Controller: Promise ATA100 controller (PCI card)
                bios knows absolutely nothing about IDE
                (there aren't even options to set drive geometry etc)

Deadlocks on loading the ide-modules with

        modprobe ide-probe-mod  || return=$rc_failed
        modprobe ide-disk || return=$rc_failed

(Nothing in the logs, no visible output on the screen)

Applying Andre Hedrick's ide.2.4.1-p8.all.01172001.patch.gz fixes it -
with this patch ide works like a charm - thanks for your good work Andre!

more info's available on request

c'ya
sven

-- 

The Internet treats censorship as a routing problem, and routes around it.
(John Gilmore on http://www.cygnus.com/~gnu/)

