Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318766AbSIKN1H>; Wed, 11 Sep 2002 09:27:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318767AbSIKN1H>; Wed, 11 Sep 2002 09:27:07 -0400
Received: from pizda.ninka.net ([216.101.162.242]:48306 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S318766AbSIKN1G>;
	Wed, 11 Sep 2002 09:27:06 -0400
Date: Wed, 11 Sep 2002 06:23:52 -0700 (PDT)
Message-Id: <20020911.062352.96263092.davem@redhat.com>
To: steve@neptune.ca
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.20-pre6 tg3 compile errors
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0209102218460.3875-100000@triton.neptune.on.ca>
References: <20020910.142646.97775138.davem@redhat.com>
	<Pine.LNX.4.44.0209102218460.3875-100000@triton.neptune.on.ca>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Steve Mickeler <steve@neptune.ca>
   Date: Tue, 10 Sep 2002 22:20:34 -0400 (EDT)
   
   gcc -D__KERNEL__ -I/usr/src/test/linux-2.4.20-pre6/include -Wall
   -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
   -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686
   -nostdinc -iwithprefix include -DKBUILD_BASENAME=tg3  -c -o tg3.o tg3.c
   
   tg3.c: In function `__tg3_set_rx_mode':
   tg3.c:4881: structure has no member named `vlgrp'
   make[3]: *** [tg3.o] Error 1
   make[3]: Leaving directory `/usr/src/test/linux-2.4.20-pre6/drivers/net'
   make[2]: *** [first_rule] Error 2
   make[2]: Leaving directory `/usr/src/test/linux-2.4.20-pre6/drivers/net'
   make[1]: *** [_subdir_net] Error 2
   make[1]: Leaving directory `/usr/src/test/linux-2.4.20-pre6/drivers'
   make: *** [_dir_drivers] Error 2

Sorry, I'll fix that.  Enable CONFIG_VLAN_8021Q as a workaround for
now.
