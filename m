Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932154AbWF3NRK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932154AbWF3NRK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 09:17:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932201AbWF3NRK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 09:17:10 -0400
Received: from ns9.hostinglmi.net ([213.194.149.146]:40615 "EHLO
	ns9.hostinglmi.net") by vger.kernel.org with ESMTP id S932154AbWF3NRJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 09:17:09 -0400
Date: Fri, 30 Jun 2006 15:17:13 +0200
From: DervishD <privado@dervishd.net>
To: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: usb-storage device wrongly seen as "write protect is on"
Message-ID: <20060630131642.GA156@DervishD>
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

    I'm having a problem with an usb-storage device (namely a Inovix
IMP65 MP3 player): when I plug it and I try to mount it, the sd_mod
driver sees it write protected, so I cannot mount it read-write.

    If I remount it as read-write (as root, of course), I have
success and I can use the device normally, being able to write to it
without problems. If, instead, I manually unload sd_mod and load it
again, then this time the device is NOT seen as write protected (the
sd_mod driver says that "write protect is off").

    All this happens using kernel 2.4.32. If using Ubuntu kernel
2.6.15, the same problem happens, but Ubuntu probes the device twice
and the second time the "write protect is off" message appears. It
mounts the device "ro", anyway. I've tested with two different USB
ports, an ALi 2.0 (driver EHCI+OHCI) and a builtin VIA686 (driver
UHCI) with the same results.

    If I plug the device with the write protect switch on (that is,
the device IS *really* write protected), the sd_mod driver sees it as
"write protect is off" and I can mount it "rw"... but I cannot write
anything!

    The same device works OK in WinXP without any driver (well, with
the default USB disk driver), so I'm not sure if the problem is on
the device (in fact, it works OK after remounting "rw" by hand or
manually reloading sd_mod) or in the kernel drivers (which I find
very unlikely, since similar Inovix players work as-is).

    If you need more information, feel free to ask, and if this is a
known issue I will very happy if you could point me to the
appropriate place. I've googled a bit with no success...

    Thanks a lot in advance.

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736 | http://www.dervishd.net
http://www.pleyades.net & http://www.gotesdelluna.net
It's my PC and I'll cry if I want to... RAmen!
