Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263212AbSITSE2>; Fri, 20 Sep 2002 14:04:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263218AbSITSE2>; Fri, 20 Sep 2002 14:04:28 -0400
Received: from transport.cksoft.de ([62.111.66.27]:14860 "EHLO
	transport.cksoft.de") by vger.kernel.org with ESMTP
	id <S263212AbSITSE2>; Fri, 20 Sep 2002 14:04:28 -0400
Date: Fri, 20 Sep 2002 20:10:14 +0200 (CEST)
From: "Bjoern A. Zeeb" <bzeeb-lists@lists.zabbadoz.net>
X-X-Sender: bz@e0-0.zab2.int.zabbadoz.net
To: jt@hpl.hp.com
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>, <thunder@lightweight.ods.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: FW: 2.5.34: IR __FUNCTION__ breakage
In-Reply-To: <20020920171901.GG8260@bougret.hpl.hp.com>
Message-ID: <Pine.BSF.4.44.0209202006040.13460-100000@e0-0.zab2.int.zabbadoz.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Sep 2002, Jean Tourrilhes wrote:

Hi,

> > Also, specifically relating to varargs macros as described above, you
> > can certainly have a varargs macro with zero args, just look at C99
> > varargs macros...
>
> 	I remember that it didn't work. Ok, I'll try again.

if I remember corretly with C99 if you do s.th. like this (simple
sample):

#define LOG(level, format, ...)					\
                log(level, format, ##__VA_ARGS__);

you _need_ to give an argument:

	LOG(debug, "blah", 0);

w/o the ", 0" this is an error.

There have been gcc extentions that allow(ed) zero arguments.

*searching*

See: http://gcc.gnu.org/onlinedocs/cpp/Variadic-Macros.html

-- 
Bjoern A. Zeeb				bzeeb at Zabbadoz dot NeT
56 69 73 69 74				http://www.zabbadoz.net/

