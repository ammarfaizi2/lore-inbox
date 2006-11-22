Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162037AbWKVKw5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162037AbWKVKw5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 05:52:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162038AbWKVKw5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 05:52:57 -0500
Received: from ns9.hostinglmi.net ([213.194.149.146]:12220 "EHLO
	ns9.hostinglmi.net") by vger.kernel.org with ESMTP id S1162037AbWKVKw4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 05:52:56 -0500
Date: Wed, 22 Nov 2006 11:53:22 +0100
From: DervishD <lkml@dervishd.net>
To: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: usb-storage data errors
Message-ID: <20061122105322.GA17351@DervishD>
Mail-Followup-To: Linux-kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4.2.2i
Organization: DervishD
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - ns9.hostinglmi.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - dervishd.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi all :)

    I'm having a problem with usb-storage devices under:

    - Two different kernels: 2.4.31 (vanilla) and 2.6.17 (Ubuntu).
    - Two different USB 2.0 cards (ALi chipset and VIA chipset).
    - So, two different drivers (OHCI and EHCI).
    - Two different usb-storage adapters (an external USB box from an
      unknown manufacturer and Conceptronic CIDE23U). Both are
      USB-to-IDE adapters.
    - Many different hard disks.
    - Both vfat and ext2/3 filesystems.
    - Perfect RAM (at least, that's what memtest says).
    - Correctly cooled system.

    The problem is the following: whenever I copy a lot of data to
the usb-storage device (more than a few GB's), the copy goes OK,
without an error, but when I compare the copied files with the
original files, sometimes a copied file is different. This does not
happen if I copy the files one by one, and it doesn't happens all the
time, sometimes the copy is perfect.

    In addition to this, from time to time the usb-storage adapters
(any of them, with any of the USB cards and any kernel) report a read
error, telling that some sector could not be read. This is false
because if I repeat the operation, the sector is correctly retrieved.
This can be related to some kind of timing problem, I don't know.

    The fact is that I cannot reproduce the problem reliably, so I
cannot give you a "recipe", except that it happens when I copy a lot
of data at a time.

    Any suggestion about how to narrow the problem down? Any more
data that you may need? A known bug? Am I doing any stupidity?

    Thanks a lot in advance :)

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736 | http://www.dervishd.net
It's my PC and I'll cry if I want to... RAmen!
