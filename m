Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266516AbUFQOh4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266516AbUFQOh4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 10:37:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266514AbUFQOh4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 10:37:56 -0400
Received: from smtp4.wanadoo.fr ([193.252.22.27]:27340 "EHLO
	mwinf0401.wanadoo.fr") by vger.kernel.org with ESMTP
	id S266515AbUFQOhq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 10:37:46 -0400
Message-ID: <40D1AC9E.8030602@reolight.net>
Date: Thu, 17 Jun 2004 16:37:18 +0200
From: Auzanneau Gregory <greg@reolight.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.6) Gecko/20040528 Debian/1.6-7
X-Accept-Language: fr, fr-fr, en, en-gb, en-us
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: ACPI Sleep doesn't work in 2.6.7
X-Enigmail-Version: 0.83.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


An echo "3" >/proc/acpi/sleep entered my laptop in sleep mode only for a
couple of seconds (I see it with a del) before return an error in dmesg:

Jun 17 16:02:06 greg-port kernel: PM: Preparing system for suspend
Jun 17 16:02:06 greg-port kernel: Stopping tasks:
====================================|
Jun 17 16:02:06 greg-port kernel: Could not suspend device 0000:00:03.3:
error -5
Jun 17 16:02:06 greg-port kernel: eth0: link up, 100Mbps, full-duplex,
lpa 0xFFFF
Jun 17 16:02:06 greg-port kernel: Restarting tasks... done

After that, I lost network connection until I shutdown my computer.

0000:00:03.3 USB Controller: Silicon Integrated Systems [SiS] USB 2.0
Controller


There are a lot of message concerning network in syslog before rebooting:

Jun 17 16:03:16 greg-port kernel: NETDEV WATCHDOG: eth0: transmit timed out
Jun 17 16:03:16 greg-port kernel: eth0: Transmit timeout, status ff ffff
ffff media ff.
Jun 17 16:03:16 greg-port kernel: eth0: Tx queue start entry 4  dirty
entry 0.
Jun 17 16:03:16 greg-port kernel: eth0:  Tx descriptor 0 is ffffffff.
(queue head)
Jun 17 16:03:16 greg-port kernel: eth0:  Tx descriptor 1 is ffffffff.
Jun 17 16:03:16 greg-port kernel: eth0:  Tx descriptor 2 is ffffffff.
Jun 17 16:03:16 greg-port kernel: eth0:  Tx descriptor 3 is ffffffff.

Same errors appeared every 12 seconds.

Thank you all for the good work with linux, keep up with it ! :)

-- 
Auzanneau Grégory
GPG 0x99137BEE
