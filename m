Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030208AbVHJTTV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030208AbVHJTTV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 15:19:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030212AbVHJTTV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 15:19:21 -0400
Received: from ns9.hostinglmi.net ([213.194.149.146]:55744 "EHLO
	ns9.hostinglmi.net") by vger.kernel.org with ESMTP id S1030208AbVHJTTU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 15:19:20 -0400
Date: Wed, 10 Aug 2005 21:22:43 +0200
From: DervishD <lkml@dervishd.net>
To: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Problem with usb-storage and /dev/sd?
Message-ID: <20050810192243.GA620@DervishD>
Mail-Followup-To: Linux-kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4.2.1i
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

    If I plug my MP3 player (USB), the usb-storage module assigns it
device /dev/sda, which is right because I have it configured as such
in my /etc/fstab. Well, another day, another boot and I plug my USB
memory stick, and usb-storage assigns it device /dev/sda, quite cool
because I have it configured as such in my /etc/fstab, too.

    The problem is that if I plug my USB memory, unplug it and plug
my MP3 player, it gets /dev/sdb this time, not /dev/sda. The mess is
even greater if I plug my card reader, which has four LUN's...

    I'm not using hotplug currently so... how can I make the USB
subsystem to assign always the same /dev/sd? entry to my USB Mass
storage devices? For example, I will assign /dev/sda to my MP3
player, no matter if it is the first or the last USB gadget plugged,
etc. I would like fixed assignations, not the current way of 'first
item plugged gets /dev/sda and you have to remove the module if you
want the next item to be placed in /dev/sda'. I've googled a bit
without any success :(

    Thanks a lot in advance :)

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736 | http://www.dervishd.net
http://www.pleyades.net & http://www.gotesdelluna.net
It's my PC and I'll cry if I want to...
