Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265098AbTAJOTK>; Fri, 10 Jan 2003 09:19:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265039AbTAJOTK>; Fri, 10 Jan 2003 09:19:10 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:24466
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265098AbTAJOTJ>; Fri, 10 Jan 2003 09:19:09 -0500
Subject: Re: 2.5.55: static compilation of mxser.c doesn't work
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       support@moxa.com.tw
In-Reply-To: <20030110140313.GL6626@fs.tum.de>
References: <20030110140313.GL6626@fs.tum.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1042211563.31612.0.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 10 Jan 2003 15:12:43 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-01-10 at 14:03, Adrian Bunk wrote:
> Hi Arnaldo,
> 
> the 2.5 Linux kernel contains your patch
> 
>    o mxser: add module_exit/module_init
>    This fixes the compilation problem in 2.5
> 
> This patch renames mxser_init to mxser_module_init causing a compile 
> error when trying to compile this driver statically into the kernel 
> since mxser_init is still called from drivers/char/tty_io.c.

You should be able to kill the call from tty_io.c

