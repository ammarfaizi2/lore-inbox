Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284321AbRLMQDU>; Thu, 13 Dec 2001 11:03:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284318AbRLMQDK>; Thu, 13 Dec 2001 11:03:10 -0500
Received: from dns.logatique.fr ([213.41.101.1]:65265 "HELO
	persephone.dmz.logatique.fr") by vger.kernel.org with SMTP
	id <S284301AbRLMQCz>; Thu, 13 Dec 2001 11:02:55 -0500
Content-Type: text/plain; charset=US-ASCII
From: Thomas Capricelli <orzel@kde.org>
Organization: KDE
To: linux-kernel@vger.kernel.org
Subject: Mounting a in-ROM filesystem efficiently
Date: Thu, 13 Dec 2001 17:02:39 +0100
X-Mailer: KMail [version 1.3.6]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011213160007.D998D23CCB@persephone.dmz.logatique.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hello,

I'm looking for a way to put a filesystem into ROM.
Seems pretty trivial, isn't it ?

My understanding is (the way initrd does, and the way I do as of today)
* create a RAMDISK
* loads the data into ramdisk
* mount the ramdisk

problem is that I don't want to waste the RAM as the data in the ROM is 
already in the address space. (it's an embedded system, btw)

Speed is not an issue here. ROM access might be slower than RAM, it will 
always be so much quicker than a disk access. (wrong?)

Ideally, i would give address/length of the fs in ROM to a function, and I 
would get a ramdisk configured to read its data exactly there, and not in 
ram.

Any hint ?

I've tried to look in the different options from mainstream kernels and 
embedded-oriented kernels whithout success.


thanx,
Thomas
ps : i'm subscribed to lkml, no need to cc:

-- 
Thomas Capricelli <orzel@kde.org>
boson.eu.org, kvim, zetalinux