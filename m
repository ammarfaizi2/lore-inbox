Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261370AbSJHQTa>; Tue, 8 Oct 2002 12:19:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261371AbSJHQTa>; Tue, 8 Oct 2002 12:19:30 -0400
Received: from cibs9.sns.it ([192.167.206.29]:34319 "EHLO cibs9.sns.it")
	by vger.kernel.org with ESMTP id <S261370AbSJHQT2>;
	Tue, 8 Oct 2002 12:19:28 -0400
Date: Tue, 8 Oct 2002 18:19:53 +0200 (CEST)
From: venom@sns.it
To: "J.A. Magallon" <jamagallon@able.es>
cc: Rik van Riel <riel@conectiva.com.br>, <procps-list@redhat.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] procps 2.0.10
In-Reply-To: <20021008144328.GC1560@werewolf.able.es>
Message-ID: <Pine.LNX.4.43.0210081817260.5654-100000@cibs9.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


libgpm is present because your libncurses has been
linked with it.

you can use -lcurses -ltermcap insted (if you have old curses installed)




On Tue, 8 Oct 2002, J.A. Magallon wrote:

> Date: Tue, 8 Oct 2002 16:43:28 +0200
> From: J.A. Magallon <jamagallon@able.es>
> To: Rik van Riel <riel@conectiva.com.br>
> Cc: procps-list@redhat.com, linux-kernel@vger.kernel.org
> Subject: Re: [ANNOUNCE] procps 2.0.10
>
>
> On 2002.10.08 Rik van Riel wrote:
> >On Tue, 8 Oct 2002, J.A. Magallon wrote:
> >
> >> It also kills the 'states' part, things are beginning to spread past 80
> >> columns...is it very important ?
> >
> >Yes, things should stay within 80 lines.
> >
>
> You can also kill the commas ',', they look not so important:
>
> CPU0:   0,0% user   0,0% system   0,0% nice   0,0% iowait 100,0% idle
> CPU1:   0,4% user   0,3% system   0,0% nice   0,0% iowait  98,3% idle
>
> >> I am gettin also strange outputs sometimes, with a ton of digits in
> >> decimal parts.
> >
> >Wait... I remember fixing that bug.  On 2.4 kernels iowait
> >should always be 0.0% and it always is 0.0% here.
> >
> >I have no idea why it's displaying a wrong value on your
> >system, unless you somehow managed to run against a wrong
> >libproc.so (shouldn't happen).
> >
>
> werewolf:/lib# which top
> /usr/bin/top
> werewolf:/lib# ldd `which top`
>         libproc.so.2.0.10 => /lib/libproc.so.2.0.10 (0x1557b000)
>         libncurses.so.5 => /lib/libncurses.so.5 (0x15589000)
>         libc.so.6 => /lib/i686/libc.so.6 (0x155ce000)
>         libgpm.so.1 => /usr/lib/libgpm.so.1 (0x156ee000)
>         /lib/ld-linux.so.2 => /lib/ld-linux.so.2 (0x15556000)
>
> ???
>
> Will take a look.
>
> By.
>
> --
> J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
> werewolf.able.es                         \           It's better when it's free
> Mandrake Linux release 9.0 (dolphin) for i586
> Linux 2.4.20-pre9-jam1 (gcc 3.2 (Mandrake Linux 9.0 3.2-1mdk))
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

