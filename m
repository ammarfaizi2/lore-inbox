Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288733AbSAQNyl>; Thu, 17 Jan 2002 08:54:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288747AbSAQNyb>; Thu, 17 Jan 2002 08:54:31 -0500
Received: from chaos.analogic.com ([204.178.40.224]:28290 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S288733AbSAQNyV>; Thu, 17 Jan 2002 08:54:21 -0500
Date: Thu, 17 Jan 2002 08:55:58 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: "Yann E. MORIN" <yann.morin.1998@anciens.enib.fr>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: modules detection
In-Reply-To: <013901c19f59$d72beb50$8a140237@rennes.si.fr.atosorigin.com>
Message-ID: <Pine.LNX.3.95.1020117084759.19203B-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jan 2002, Yann E. MORIN wrote:

> Hi!
> 
> I need to know (in a script shell for instance) if a running kernel
> is compiled with/without module support. I don't have access to the
> source tree when detecting (though I have it mounted sometime later).
> 
> Reading the source (fs/proc/proc_misc.c), I understand that the file
> /proc/modules exists only when modules are supported by the running
> kernel. Is that true? If so, can I assume that the following script
> is correct?
> 
> -=-=-=-
> #!/bin/bash
> [ -e /proc/modules ] && echo Modules supported by running kernel. \
>                      || echo Modules not supported by running kernel.
> -=-=-=-
> 
> If not, how may I detect module support?
> 
> (Yes, I could build two kernels supporting modules vs not supporting
> modules, but my machine is quite slow : 2h per compilation :-( ).
> 
> Thanks for any reply.
> 
> Regards,
> Yann E. MORIN.
> 

You could also use `lsmod`. It uses query_module() which will return
some error code if modules are not supported.

if  lsmod >/dev/null ; then
    echo "Modules are supported"
else
   echo "Modules not supported"
fi

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (797.90 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


