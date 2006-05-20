Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932372AbWETVWk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932372AbWETVWk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 May 2006 17:22:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932374AbWETVWj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 May 2006 17:22:39 -0400
Received: from wildsau.enemy.org ([193.170.194.34]:59546 "EHLO
	wildsau.enemy.org") by vger.kernel.org with ESMTP id S932372AbWETVWj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 May 2006 17:22:39 -0400
From: Herbert Rosmanith <kernel@wildsau.enemy.org>
Message-Id: <200605202117.k4KLHT4s007395@wildsau.enemy.org>
Subject: pktcdvd major contradicts <linux/Documentation/devices.txt>
To: linux-kernel@vger.kernel.org
Date: Sat, 20 May 2006 23:17:29 +0200 (MET DST)
CC: Herbert Rosmanith <kernel@wildsau.enemy.org>
X-Mailer: ELM [version 2.4ME+ PL100 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


good evening,

(1)
# grep -B 1 pktcdvd /usr/src/linux/Documentation/devices.txt 
 97 block       Packet writing for CD/DVD devices
                  0 = /dev/pktcdvd0     First packet-writing module
                  1 = /dev/pktcdvd1     Second packet-writing module

but:

(2)
# modprobe pktcdvd
# grep pktcdvd /proc/devices 
254 pktcdvd


so, in contrast to the documentation, pktcdvd gets a dynamic major.

kind regards,
h.rosmanith

