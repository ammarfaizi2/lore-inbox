Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264800AbTFLNtL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 09:49:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264806AbTFLNtK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 09:49:10 -0400
Received: from 205-158-62-158.outblaze.com ([205.158.62.158]:59589 "HELO
	spf1.us.outblaze.com") by vger.kernel.org with SMTP id S264800AbTFLNtF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 09:49:05 -0400
Message-ID: <20030612140248.27035.qmail@graffiti.net>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Christopher Chan" <lkml@graffiti.net>
To: andreas@xss.co.at
Cc: linux-kernel@vger.kernel.org
Date: Thu, 12 Jun 2003 22:02:48 +0800
Subject: Re: Sudden instabilty of mysql boxen
X-Originating-Ip: 202.81.246.192
X-Originating-Server: ws2.hk5.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


----- Original Message -----
From: Andreas Haumer <andreas@xss.co.at>
Date: 	Thu, 12 Jun 2003 13:24:12 +0200
To: Christopher Chan <lkml@graffiti.net>
Subject: Re: Sudden instabilty of mysql boxen

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Hi!
> 
> Christopher Chan wrote:
> > Can somebody help out with pointers to why my boxes would suddenly
> > become unstable?
> >
> > I have two boxes running mysql servers. The first one is running RH
> > 7.3 with a 2.4.18-26 kernel that has the 3ware no bounce buffer patch
> > enabled (the src.rpm was downloaded, 3ware patch enabled and
> > rpmbuild) and the second one is running Rh 7.0 with a 2.4.2-ac28
> > kernel. The 3ware box handles over 600 queries per second.
> >
> > The first box runs on a linux software mirrored array but has the
> > mysql data on a 3ware stripped mirrored array while the second one
> > runs on a linux software mirrored array (got two disks only).
> >
> I assume you didn't change anything of the (previously
> working) setup?

Zippo
> 
> > They both suddenly started vomiting messages like:
> >
> > Code: 8b 42 04 83 f8 ff 0f 84 6f 01 00 00 83 f8 fc 77 07 c7 42 04
> >  <1>Unable to handle kernel NULL pointer dereference at virtual
> > address 00000004
> >
> > Code: 8b 42 04 83 f8 ff 0f 84 6f 01 00 00 83 f8 fc 77 07 c7 42 04
> >  Oops: 0000
> >
> > and any commands you run on shells (if you them in the first place)
> > would exit with a segmentation fault. All attempts to ssh into the
> > box would fail after successful authentication with the connection
> > being closed (bash segfault?)
> >
> > A reboot would cause them to run normally until they start acting up
> > again minutes later.
> >
> 
> Are both boxes located in the same room?
> Maybe they're getting too hot now for some reason (ambient air
> temperature too high, cooler and/or fan not working right)?
> Also check your mains power supply. If it's unstable (e.g. voltage
> too low), it could cause such effects, too (but this is usually
> less likely than overheating).

Nope. The non-3ware box is working perfectly fine now.

The 3ware box was taken out of production and a backup made the master instead.

I have now put some load back on the 3ware (it is now a slave) by pointing some queries its way and the problem has not resurfaced.

These two boxes are located in a data centre along with lots of other boxes. Only these two boxes had problems and they work fine now.

I am lead to believe that something else is causing the weird behaviour for they were running perfectly fine, and especially the non-3ware one since that has been running for ages and we've not done anything on them prior to their acting up. The 3ware box was the first and it kept on for a couple hours before we took it out of production. A day later, the non-3ware box (they happen to be related in the system although performing different functions) also had one case of the same funny behaviour/problem.

> 
> HTH
> 
> - - andreas

-- 
_______________________________________________
Get your free email from http://www.graffiti.net

Powered by Outblaze
