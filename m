Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316088AbSGGQIz>; Sun, 7 Jul 2002 12:08:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316089AbSGGQIy>; Sun, 7 Jul 2002 12:08:54 -0400
Received: from supreme.pcug.org.au ([203.10.76.34]:9388 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S316088AbSGGQIy>;
	Sun, 7 Jul 2002 12:08:54 -0400
Date: Mon, 8 Jul 2002 02:10:27 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Dominik Geisel <devnull@geisel.info>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.25 compile error
Message-Id: <20020708021027.79932e29.sfr@canb.auug.org.au>
In-Reply-To: <Pine.LNX.4.44.0207061345080.4005-100000@pc1.geisel.info>
References: <Pine.LNX.4.44.0207061345080.4005-100000@pc1.geisel.info>
X-Mailer: Sylpheed version 0.7.8 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dominik,

On Sat, 6 Jul 2002 13:45:58 +0200 (CEST) Dominik Geisel <devnull@geisel.info> wrote:
>
> on 'make dep' with 2.5.25 I get the following error:
> 
> -----------------------------------------------------------------------------
> make[1]: Wechsel in das Verzeichnis Verzeichnis »/usr/src/linux«
> make[2]: Wechsel in das Verzeichnis Verzeichnis »/usr/src/linux/scripts«
>   gcc -Wp,-MD,./.split-include.d -Wall -Wstrict-prototypes -O2 
> -fomit-frame-pointer   -o split-include split-include.c
> In file included from /usr/include/linux/errno.h:4,
>                  from /usr/include/bits/errno.h:25,
>                  from /usr/include/errno.h:36,
>                  from split-include.c:26:
> /usr/include/asm/errno.h:4:31: asm-generic/errno.h: No such file or 
> directory
> make[2]: *** [split-include] Fehler 1
> make[2]: Verlassen des Verzeichnisses Verzeichnis »/usr/src/linux/scripts«
> make[1]: *** [scripts] Fehler 2
> make[1]: Verlassen des Verzeichnisses Verzeichnis »/usr/src/linux«
> make: *** [.hdepend] Fehler 2
> -----------------------------------------------------------------------------
> 
> Any ideas?

Remove the symlinks between /usr/include/{linux,asm} and your kernel
source tree ...

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
