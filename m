Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271852AbTGRVqX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 17:46:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271871AbTGRVn7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 17:43:59 -0400
Received: from 5.Red-80-32-157.pooles.rima-tde.net ([80.32.157.5]:64261 "EHLO
	smtp.newipnet.com") by vger.kernel.org with ESMTP id S271852AbTGRVnH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 17:43:07 -0400
Message-ID: <200307182357260552.063FA10C@192.168.128.16>
X-Mailer: Calypso Version 3.30.00.00 (4)
Date: Fri, 18 Jul 2003 23:57:26 +0200
From: "Carlos Velasco" <carlosev@newipnet.com>
To: linux-kernel@vger.kernel.org
Subject: ARP with wrong ip?
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a problem with ARP in this machine:
Kernel 2.4.20
1 ethernet interface with IP 192.168.10.1 netmask 255.255.255.0
1 loopback interface with IP 194.147.150.10 netmask 255.255.255.255
default route to 192.168.10.190

Packets are being sent to ethernet interface 192.168.10.1 with IP dst 194.147.150.10.
After receiving these packets it tries to find out the mac address of default gateway (192.168.10.190)... but it's doing it from the wrong src IP address!!

22:49:10.875002 0:b:cd:4d:82:72 ff:ff:ff:ff:ff:ff 0806 60: arp who-has 192.168.10.190 tell 194.147.150.10
22:49:11.867673 0:b:cd:4d:82:72 ff:ff:ff:ff:ff:ff 0806 60: arp who-has 192.168.10.190 tell 194.147.150.10

Is this a bug?

Regards,
Carlos Velasco


