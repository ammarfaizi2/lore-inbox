Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261742AbSKLP7Y>; Tue, 12 Nov 2002 10:59:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261839AbSKLP7Y>; Tue, 12 Nov 2002 10:59:24 -0500
Received: from chaos.analogic.com ([204.178.40.224]:38019 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S261742AbSKLP7X>; Tue, 12 Nov 2002 10:59:23 -0500
Date: Tue, 12 Nov 2002 11:08:09 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Adam Voigt <adam@cryptocomm.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: File Limit in Kernel?
In-Reply-To: <1037115535.1439.5.camel@beowulf.cryptocomm.com>
Message-ID: <Pine.LNX.3.95.1021112110028.23898A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 Nov 2002, Adam Voigt wrote:

> I have a directory with 39,000 files in it, and I'm trying to use the cp
> command to copy them into another directory, and neither the cp or the
> mv command will work, they both same "argument list too long" when I
> use:
> 
> cp -f * /usr/local/www/images
> 
> or
> 
> mv -f * /usr/local/www/images
> 
> Is this a kernel limitation? If yes, how can I get around it?
> If no, anyone know a workaround? I appreciate it.
> 

The '*' is expanded by your shell to be a command-line that has
39,000 file-names in it! It is probably way too long for a command-
line (argument list).

The easiest way is to do:

mv -f a* /usr/local/www/images
mv -f b* /usr/local/www/images
mv -f c* /usr/local/www/images

... until the remaining argument list is short enough for the '*' only.

You can also do a loop in a shell if the shell's internal buffer is
big enough for the expanded '*' ...

for x in * ; do mv -f $x /usr/local/www/images ; done


Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
   Bush : The Fourth Reich of America


