Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262076AbRGBJbb>; Mon, 2 Jul 2001 05:31:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262288AbRGBJbR>; Mon, 2 Jul 2001 05:31:17 -0400
Received: from sunrise.pg.gda.pl ([153.19.40.230]:61659 "EHLO
	sunrise.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S262076AbRGBJbK>; Mon, 2 Jul 2001 05:31:10 -0400
From: Andrzej Krzysztofowicz <ankry@pg.gda.pl>
Message-Id: <200107020929.LAA12071@sunrise.pg.gda.pl>
Subject: Re: [PATCH] Re: 2.4.6p6: dep_{bool,tristate} $CONFIG_ARCH_xxx bugs
To: kaos@ocs.com.au (Keith Owens)
Date: Mon, 2 Jul 2001 11:29:49 +0200 (MET DST)
Cc: adam@yggdrasil.com (Adam J. Richter), alan@lxorguk.ukuu.org.uk,
        linux-kernel@vger.kernel.org, rhw@MemAlpha.CX, rmk@arm.linux.org.uk
In-Reply-To: <24426.994049492@kao2.melbourne.sgi.com> from "Keith Owens" at Jul 02, 2001 02:51:32 PM
Reply-To: ankry@green.mif.pg.gda.pl
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
> On Sun, 1 Jul 2001 21:46:04 -0700, 
> "Adam J. Richter" <adam@yggdrasil.com> wrote:
> >Can you even write a hypothetical example?
> 
> if [ "$CONFIG_foo" = "n" -a "$CONFIG_bar" = "n" ]; then
>   define_bool "$CONFIG_ALLOW_foo_bar n
> fi
> ....
> dep_tristate CONFIG_baz $CONFIG_ALLOW_foo_bar

Unfortunately this does not work as you expect (depends on history) if
any of CONFIG_foo CONFIG_bar can be changed.

When changing one of them to y, the value of CONFIG_ALLOW_foo_bar in
make menuconfig / make xconfig is not undefined...

Andrzej

-- 
=======================================================================
  Andrzej M. Krzysztofowicz               ankry@mif.pg.gda.pl
  phone (48)(58) 347 14 61
Faculty of Applied Phys. & Math.,   Technical University of Gdansk
