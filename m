Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288169AbSA0QRL>; Sun, 27 Jan 2002 11:17:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288124AbSA0QRC>; Sun, 27 Jan 2002 11:17:02 -0500
Received: from petasus.iil.intel.com ([192.198.152.69]:64251 "EHLO
	petasus.iil.intel.com") by vger.kernel.org with ESMTP
	id <S288114AbSA0QQt>; Sun, 27 Jan 2002 11:16:49 -0500
Message-ID: <1FA73BCBB3CFD311913100A0C9E00BE6023923CD@hasmsx43.iil.intel.com>
From: "Mendelson, Tsippy" <tsippy.mendelson@intel.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Cc: "'linux-net@vger.kernel.org'" <linux-net@vger.kernel.org>
Subject: Does bonding interfere with Raw packet binding ?
Date: Sun, 27 Jan 2002 18:16:42 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

The PF_PACKET protocol family was defined to allow root applications to bind
themselves with network devices without going through all the network stack.

What happens if an application binds itself to a device that is a slave in a
bonding team?

The skb_bond() function in dev.c changes the skb->dev from the slave device
to a master device. It seems that this will block the application from
receiving its packets.

Dying to get some input on this Q.

Thanks,

Tsippy 
