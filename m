Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274061AbRIYIjX>; Tue, 25 Sep 2001 04:39:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274568AbRIYIjD>; Tue, 25 Sep 2001 04:39:03 -0400
Received: from access-35.98.rev.fr.colt.net ([213.41.98.35]:28164 "HELO
	phoenix.linuxatbusiness.com") by vger.kernel.org with SMTP
	id <S274061AbRIYIi4>; Tue, 25 Sep 2001 04:38:56 -0400
Subject: bootp ip autoconfiguration disable
From: philippe <pamelant@nerim.net>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.14.99+cvs.2001.09.24.08.08 (Preview Release)
Date: 25 Sep 2001 10:38:33 +0200
Message-Id: <1001407113.6756.35.camel@avior>
Mime-Version: 1.0
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
I have tried to compile a kernel (2.4.8) with bootp support.
i make 
dd if=bzImage of=/dev/fd0
and i boot on the floppy.
(I have found some doc who say that work)
but for me ip configuration don't work, i haven't any bootp request.

I look at the file net/ipv4/ipconfig.c
I see that
int ic_enable __initdata = 0;			/* IP config enabled? */

ic_enable is set in function  ip_auto_config_setup
with 
ic_enable = (*addrs && 
		(strcmp(addrs, "off") != 0) && 
		(strcmp(addrs, "none") != 0));

so i must pass an argument ?
how could I do that on my floppy ? there are nothing about that in doc ?
also if I change 
int ic_enable __initdata = 0;			/* IP config enabled? */
whit 
int ic_enable __initdata = 1;			/* IP config enabled? */
all seem work well, i have bootp request so why should i need this
argument ?

thank for any help




