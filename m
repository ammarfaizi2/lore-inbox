Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317883AbSFSNsN>; Wed, 19 Jun 2002 09:48:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317884AbSFSNsM>; Wed, 19 Jun 2002 09:48:12 -0400
Received: from postfix2-1.free.fr ([213.228.0.9]:37055 "EHLO
	postfix2-1.free.fr") by vger.kernel.org with ESMTP
	id <S317883AbSFSNsL>; Wed, 19 Jun 2002 09:48:11 -0400
Message-ID: <001c01c21798$f100e230$3d5e06c7@slebriero2>
From: "Sylvain Le Briero" <s.lebriero@free.fr>
To: "Joshua Newton" <jpnewton@speakeasy.net>, <linux-kernel@vger.kernel.org>
References: <1024420841.2631.14.camel@claymore.corona>
Subject: Re: Incredible weirdness with eepro100?
Date: Wed, 19 Jun 2002 15:55:15 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

it seems that some older kernels do the same...

I have discovered recently I have the same problem with a HP Netserver LH
3000 wich works fine in any other case :

uname-a
Linux databaseserver 2.4.10 #1 Tue Nov 13 17:28:13 CET 2001 i686 unknown

excerpt of dmesg :
eepro100.c:v1.09j-t 9/29/99 Donald Becker
http://cesdis.gsfc.nasa.gov/linux/drivers/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin
<saw@saw.sw.com.sg> and others
eth0: OEM i82557/i82558 10/100 Ethernet, 00:30:6E:00:1A:49, IRQ 18.
  Receiver lock-up bug exists -- enabling work-around.
  Board assembly 506477-150, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
  Receiver lock-up workaround activated.

on a Slackware 8.0 running postgreSQL.

When i mount a SMB share and copy a large file to an NT Server (postgres
database files  : 2-3 GBytes) all network connections are closed and a
reboot is needed.

It seems also that this problem is related

This server has been in production state for almost 1 year and is very
stable as long as you don't transfer large files to a network mount point.

Hope this helps



