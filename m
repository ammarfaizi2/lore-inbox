Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261668AbSJDNlX>; Fri, 4 Oct 2002 09:41:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261669AbSJDNlX>; Fri, 4 Oct 2002 09:41:23 -0400
Received: from mta05ps.bigpond.com ([144.135.25.137]:36560 "EHLO
	mta05ps.bigpond.com") by vger.kernel.org with ESMTP
	id <S261668AbSJDNlW>; Fri, 4 Oct 2002 09:41:22 -0400
Message-ID: <3D9D9BE4.32421A87@bigpond.com>
Date: Fri, 04 Oct 2002 23:47:16 +1000
From: Allan Duncan <allan.d@bigpond.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.20-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.5.40 etc and IDE HDisk geometry
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've noticed that the system's idea of the IDE disk geometry seems to
have changed from 2.4.xx.
In particular, I've got my 40G HD on a Promise PDC20268 PIC, and find
that the (logical) CHS is different, while the LBA sectors remains constant
(and correct according to the HD label).

2.5.xx does have the right values in that CxHxS = LBA blocks, but fdisk and lilo
get a bit stroppy about the partition boundaries that were created from the CHS
that were generated under 2.4.xx, so I will have to patch them up.


Question is - what is determining that initial value that becomes the "logical"
CHS, and does it matter?

The fdisk and friends man pages are a bit vague on this, cfdisk says "picking
255 heads and 63 sectors/track is always a good idea", but I find 2.4.xx uses
nn/255/63, while 2.4.xx uses mm/16/63, and as I dual boot with win98, consistent
partition table behaviour is important to me.


Advice anyone?


Aside - RedHat has dropped cfdisk from util-linux in their distro versions 7.2 ff.
Given the bad words said about fdisk, what did cfdisk do to be ostracised?
