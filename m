Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262604AbTAVTr4>; Wed, 22 Jan 2003 14:47:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262789AbTAVTr4>; Wed, 22 Jan 2003 14:47:56 -0500
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:45578 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S262604AbTAVTrz>; Wed, 22 Jan 2003 14:47:55 -0500
Message-ID: <3E2EF3FB.4335D3F5@linux-m68k.org>
Date: Wed, 22 Jan 2003 20:41:47 +0100
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
CC: Mikael Pettersson <mikpe@csd.uu.se>,
       Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
       linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
Subject: Re: kernel param and KBUILD_MODNAME name-munging mess
References: <Pine.LNX.4.44.0301221112580.9969-100000@chaos.physics.uiowa.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Kai Germaschewski wrote:

> KBUILD_BASENAME needs to be an un-stringified symbol following
> certain conventions to make it possible to use it e.g. in
> include/linux/spinlock.h, that's why '-' and ',' are escaped to '_'.
> 
> However, for all I can tell, this is not true for KBUILD_MODNAME, since
> that seems to be only used for constructing an actual string, which of
> course can contain all kinds of characters. So I think using the first
> approach would be somewhat nicer, as it gets rid of the unintuitive
> "ide-cd" -> "ide_cd" munging on the kernel command line.

It might be useful later to build a list of builtin modules. Currently
we do nothing if a builtin module fails to initialize, but we should
disable dependent modules and remove the exported symbols.
Maybe it's better to provide the module name both as label and string.

bye, Roman

