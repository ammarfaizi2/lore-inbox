Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264909AbSJVSm6>; Tue, 22 Oct 2002 14:42:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262126AbSJVSl1>; Tue, 22 Oct 2002 14:41:27 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:56283 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S264895AbSJVSlD>; Tue, 22 Oct 2002 14:41:03 -0400
Date: Tue, 22 Oct 2002 16:10:02 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Jan Kasprzak <kas@informatics.muni.cz>, <linux-kernel@vger.kernel.org>,
       <hch@infradead.org>
Subject: Re: 2.4.20-pre11 /proc/partitions read
In-Reply-To: <20021022184034.GA26585@win.tue.nl>
Message-ID: <Pine.LNX.4.44L.0210221609260.7060-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 22 Oct 2002, Andries Brouwer wrote:

> On Tue, Oct 22, 2002 at 04:19:57PM +0200, Jan Kasprzak wrote:
>
> > 	I.e. if you read the /proc/partitions in single read() call,
> > it gets read OK. However, if you read() with smaller-sized blocks,
> > you get the truncated contents.
>
> Having statistics in /proc/partitions leads to such problems.
> Make sure you do not ask for them.
>
> --- Documentation/Configure.help~       Mon Oct 14 01:12:13 2002
> +++ Documentation/Configure.help        Tue Oct 22 20:30:39 2002
> @@ -561,6 +561,8 @@
>
>    This is required for the full functionality of sar(8) and interesting
>    if you want to do performance tuning, by tweaking the elevator, e.g.
> +  On the other hand, it will cause random and mysterious failures for
> +  fdisk, mount and other programs reading /proc/partitions.
>
>    If unsure, say N.
>
>
> (this is about CONFIG_BLK_STATS).
>
> Andries
>
>
> [I still do not understand how hch can want to add this cruft to
> /proc/partitions, and how marcelo can accept it.
> If some vendor made this mistake, why force it on the rest of
> the world? It is bad for RedHat users, and worse for all others.]

Its not forced behaviour. Its a config option and its defaulted to off.

Some people want it.

