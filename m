Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281220AbRKHBIZ>; Wed, 7 Nov 2001 20:08:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281227AbRKHBIQ>; Wed, 7 Nov 2001 20:08:16 -0500
Received: from tungsten.btinternet.com ([194.73.73.81]:61634 "EHLO
	tungsten.btinternet.com") by vger.kernel.org with ESMTP
	id <S281228AbRKHBIL>; Wed, 7 Nov 2001 20:08:11 -0500
Content-Type: text/plain; charset=US-ASCII
From: Acrimon Beet <acrimon.beet@gmx.co.uk>
To: linux-kernel@vger.kernel.org
Subject: multiple identical nfs mounts allowed
Date: Thu, 8 Nov 2001 01:09:59 +0000
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01110801095902.13050@x>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I understand this has been discussed before in a limited way 
(http://www.uwsg.iu.edu/hypermail/linux/kernel/0108.1/0070.html is all I 
could find), but what is the justification for allowing multiple identical 
nfs mounts?

eg

# mount server:/export /mnt
# mount server:/export /mnt

will give this:

# mount | grep server
server:/export on /mnt type nfs (rw,addr=192.168.1.210)
server:/export on /mnt type nfs (rw,addr=192.168.1.210)

This is not possible with block devices.

Is this at all a dangerous state of affairs?

thanks
ABeet.
