Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266717AbSK1Tu3>; Thu, 28 Nov 2002 14:50:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266720AbSK1Tu3>; Thu, 28 Nov 2002 14:50:29 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:16144 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S266717AbSK1Tu2>;
	Thu, 28 Nov 2002 14:50:28 -0500
Date: Thu, 28 Nov 2002 20:57:47 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Romain Lievin <rlievin@free.fr>
Cc: Roman Zippel <zippel@linux-m68k.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: kconfig (gkc): help about Makefile
Message-ID: <20021128195747.GA11043@mars.ravnborg.org>
Mail-Followup-To: Romain Lievin <rlievin@free.fr>,
	Roman Zippel <zippel@linux-m68k.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20021128191734.GA476@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021128191734.GA476@free.fr>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 28, 2002 at 08:17:34PM +0100, Romain Lievin wrote:
> Hi Roman,
> 
> I'm currently working on the kernel Makefile ($SRC & $SRC/scripts/kconfig)
> for adding gkc support but I'm encountering some difficulties...

> host-progs	:= conf mconf qconf gconf
OK.

> conf-objs	:= conf.o  libkconfig.so
> mconf-objs	:= mconf.o libkconfig.so
> 
> qconf-objs	:= kconfig_load.o
> qconf-cxxobjs	:= qconf.o
> 
> gconf-objs	:= kconfig_load.o
> gconf-cobjs	:= gconf.o
Not OK. Replace with:
gconf-objs := gconf.o kconfig_load.o

> HOSTLOADLIBES_gconf	= -L$(GTK_LIBS)
> HOSTCXXFLAGS_gconf.o	= -I$(GTK_FLAGS)
Looks OK, but I do not know the gtk package

The rest looks OK as well.

	Sam
