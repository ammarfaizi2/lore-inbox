Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267488AbTAQLCc>; Fri, 17 Jan 2003 06:02:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267490AbTAQLCc>; Fri, 17 Jan 2003 06:02:32 -0500
Received: from [66.70.28.20] ([66.70.28.20]:61959 "EHLO
	maggie.piensasolutions.com") by vger.kernel.org with ESMTP
	id <S267488AbTAQLCa>; Fri, 17 Jan 2003 06:02:30 -0500
Date: Fri, 17 Jan 2003 11:58:54 +0100
From: DervishD <raul@pleyades.net>
To: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: argv0 revisited...
Message-ID: <20030117105854.GG47@DervishD>
References: <20030116112745.GE87@DervishD> <200301161603.h0GG3DX0001895@eeyore.valparaiso.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200301161603.h0GG3DX0001895@eeyore.valparaiso.cl>
User-Agent: Mutt/1.4i
Organization: Pleyades
User-Agent: Mutt/1.4i <http://www.mutt.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Horst :)

> > some instances of a process called 'init'. The first is an init,
> > true, but the second is the klogd emulator, the third is the slogd
> > emulator and all other are the gettylogin emulator.
> Something like nash that RH uses on their initrd (it is sh, and modprobe,
> and mount, and ...; so they save on libc and random boilerplate code which
> is only once on the disk), or like a package called swish (or something
> like that), that is a shell which has ls, rm, ... builtin?

    I'm afraid that those use symlinks or hardlinks to run every
different personality. What my init does is more or less (no real
code):

    pid=fork();
    if (!pid) do_klog();
    ...
    pid=fork();
    if (!pid) do_slog();

    So, in function do_klog() we would like to change argv[0]. Things
like busybox and the like uses symlinks or mechanisms like 'command
subcommand'.

    I'll give a look at the microdistros, anyway :)) Thanks :)
    Raúl
