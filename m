Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313943AbSDPXHl>; Tue, 16 Apr 2002 19:07:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313945AbSDPXHk>; Tue, 16 Apr 2002 19:07:40 -0400
Received: from surf.viawest.net ([216.87.64.26]:43939 "EHLO surf.viawest.net")
	by vger.kernel.org with ESMTP id <S313943AbSDPXHk>;
	Tue, 16 Apr 2002 19:07:40 -0400
Date: Tue, 16 Apr 2002 16:07:37 -0700
From: A Guy Called Tyketto <tyketto@wizard.com>
To: linux-kernel@vger.kernel.org
Subject: CONFIG_SOFT_WATCHDOG missing from 2.5.8-dj1
Message-ID: <20020416230737.GA6142@wizard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux/2.5.7 (i686)
X-uptime: 4:02pm  up 12:24,  2 users,  load average: 0.21, 0.08, 0.03
X-RSA-KeyID: 0xE9DF4D85
X-DSA-KeyID: 0xE319F0BF
X-GPG-Keys: see http://www.wizard.com/~tyketto/pgp.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


        Once again, subject sez it all. CONFIG_SOFT_WATCHDOG is mentioned in 
drivers/char/Config.help, but is not a configurable option in any part of make 
{old,x,menu}config. Therefore isn't compiled or even touched:

bradl@bellicha:/usr/src/linux/drivers/char> grep CONFIG_SOFT_WATCHDOG Config.in
bradl@bellicha:/usr/src/linux/drivers/char> 

        Because of this, my software watchdog program refuses to run, as 
softdog.o doesn't exist, which creates /dev/watchdog.

                                                        BL.
-- 
Brad Littlejohn                         | Email:        tyketto@wizard.com
Unix Systems Administrator,             |           tyketto@ozemail.com.au
Web + NewsMaster, BOFH.. Smeghead! :)   |   http://www.wizard.com/~tyketto
  PGP: 1024D/E319F0BF 6980 AAD6 7329 E9E6 D569  F620 C819 199A E319 F0BF

