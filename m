Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270001AbRHETYa>; Sun, 5 Aug 2001 15:24:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269997AbRHETYU>; Sun, 5 Aug 2001 15:24:20 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:61957 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S269996AbRHETYS>;
	Sun, 5 Aug 2001 15:24:18 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Rasmus Andersen <rasmus@jaquet.dk>
cc: pgmdsg@ibi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] make riscom8.c build (248p4) 
In-Reply-To: Your message of "Sun, 05 Aug 2001 18:22:08 +0200."
             <20010805182208.S821@jaquet.dk> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 06 Aug 2001 05:24:22 +1000
Message-ID: <28998.997039462@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 5 Aug 2001 18:22:08 +0200, 
Rasmus Andersen <rasmus@jaquet.dk> wrote:
>--- linux-248-pre4-clean/drivers/char/riscom8.c Sun Aug  5 14:34:54 2001
>+++ linux-248p4-kbuild/drivers/char/riscom8.c   Sun Aug  5 18:14:29 2001
>@@ -1866,10 +1866,10 @@
> __setup("riscom8=", riscom8_setup);
> #endif
> 
>-static const char banner[] __initdata =
>+static char banner[] __initdata =
>        KERN_INFO "rc: SDL RISCom/8 card driver v1.1, (c) D.Gorodchanin "
>                  "1994-1996.\n";
>-static const char no_boards_msg[] __initdata =
>+static char no_boards_msg[] __initdata =
>        KERN_INFO "rc: No RISCom/8 boards detected.\n";
> 

It is even documented in Documentation/DocBook/kernel-hacking.tmpl that
__initdata cannot be const.  Not all versions of gcc flag an error,
newer ones do.

