Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318387AbSGYJBM>; Thu, 25 Jul 2002 05:01:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318381AbSGYJA6>; Thu, 25 Jul 2002 05:00:58 -0400
Received: from sunny.pacific.net.au ([203.25.148.40]:8168 "EHLO
	sunny.pacific.net.au") by vger.kernel.org with ESMTP
	id <S318373AbSGYJAA>; Thu, 25 Jul 2002 05:00:00 -0400
From: "David Luyer" <david@luyer.net>
To: <linux-kernel@vger.kernel.org>
Subject: RE: Linux-2.4.18-rc3-ac3: bug with using whole disks as filesystems
Date: Thu, 25 Jul 2002 19:03:11 +1000
Message-ID: <004a01c233ba$1a764f50$638317d2@pacific.net.au>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
In-Reply-To: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to my own post:

> I attempted to mkfs and use a whole disk rather than a partition
> with reiserfs.  It failed (not a major problem, I'll just make a
> partition), but it failed with a "kernel BUG" message, so here 'tis.

[...]

> Original commands to cause failure:
>   mkfs -b 8192 /dev/sdb -f
>   mount /dev/sdb /cache

Actually looks like the -b 8192 was the problem, the same happened
on /dev/sdb1.  Had to reboot again after that as mount was hanging
in the same way as cfdisk had previously.  Similar 'kernel BUG'
message resulted.

David.

