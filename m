Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280494AbRKELpn>; Mon, 5 Nov 2001 06:45:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280495AbRKELpd>; Mon, 5 Nov 2001 06:45:33 -0500
Received: from [62.58.73.254] ([62.58.73.254]:20219 "EHLO
	ats-core-0.atos-group.nl") by vger.kernel.org with ESMTP
	id <S280494AbRKELpQ>; Mon, 5 Nov 2001 06:45:16 -0500
Date: Mon, 5 Nov 2001 12:47:11 +0100 (CET)
From: Ryan Sweet <rsweet@atos-group.nl>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: ip autoconfig and e100
In-Reply-To: <Pine.LNX.4.33.0111050958030.659-100000@chaos2.streamgroup.co.uk>
Message-ID: <Pine.LNX.4.33.0111051237250.5618-100000@rsweet2.atos-group.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've posted previously about my ongoing pains with a diskless cluster of
dual cpu serverworks boards that use on-board Intel eepro100 chips.

Basically the nodes randomly reboot themselves.  See previous posts by me
for  more thorough description.

After reading some more of the posts recently regarding the eepro/100 on
board nics, and the various drivers available, I think that my symptoms
are possibly consistent with the problem where the card flakes out.  We
are using the eepro100.c compiled statically.

I'd like to try the e100 module from Intel, but I can't get it to work
with nfsroot.

The Intel e100 driver is only available as a module.

IP autoconfig (which does not appear to be available as a module) attempts
to set the address before the module is loaded and the card is detected,
thus by the time the module is loaded from my initrd the system has
already given up on ip autoconfig and thus cannot mount its nfsroot
filesystem.

Is there a way to make the intel driver static?  or perhaps to make ip
autoconfig a module, or to configure the network in another way in
combination with nfsroot?

thanks,
-ryan



-- 
Ryan Sweet <ryan.sweet@atosorigin.com>
Atos Origin Engineering Services
http://www.aoes.nl

