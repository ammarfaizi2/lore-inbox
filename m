Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318013AbSGLVyl>; Fri, 12 Jul 2002 17:54:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318015AbSGLVyj>; Fri, 12 Jul 2002 17:54:39 -0400
Received: from [209.195.52.32] ([209.195.52.32]:50618 "HELO
	warden2.diginsite.com") by vger.kernel.org with SMTP
	id <S318013AbSGLVyg>; Fri, 12 Jul 2002 17:54:36 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Date: Fri, 12 Jul 2002 14:51:56 -0700 (PDT)
Subject: Re: [OKS] Module removal
In-Reply-To: <Pine.LNX.3.96.1020701133907.23769A-100000@gatekeeper.tmr.com>
Message-ID: <Pine.LNX.4.44.0207121448530.23382-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One oddball use of module removal.

On my tivo I have a module loaded that disables scrambling of the shows it
records (allowing me to download them to standard mpeg files) I need to
not have this module loaded to watch shows that were recorded without the
module loaded.

if module unloading is removed then I will have to reboot my tivo to
unload this module.

yes this module could probably be rewritten to have an interface that
allowed the encryption to be enabled or disabled, but that makes the
module significanlty more complicated then mearly implementing null
functions to replace the existing encryption functions.

David Lang


 On Mon, 1 Jul 2002, Bill Davidsen wrote:

> Date: Mon, 1 Jul 2002 13:48:55 -0400 (EDT)
> From: Bill Davidsen <davidsen@tmr.com>
> To: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
> Subject: [OKS] Module removal
>
> Having read some notes on the Ottawa Kernel Summit, I'd like to offer some
> comments on points raied.
>
> The suggestion was made that kernel module removal be depreciated or
> removed. I'd like to note that there are two common uses for this
> capability, and the problems addressed by module removal should be kept in
> mind. These are in addition to the PCMCIA issue raised.
>
> 1 - conversion between IDE-CD and IDE-SCSI. Some applications just work
> better (or usefully at all) with one or the other driver used to read CDs.
> I've noted that several programs for reading the image from an ISO CD
> (readcd and sdd) have end of data problems with the SCSI interface.
>
> 2 - restarting NICs when total reinitialization is needed. In server
> applications it's sometimes necessary to move or clear a NIC connection,
> force renegotiation because the blade on the switch was set wrong, etc.
> It's preferable to take down one NIC for a moment than suffer a full
> outage via reboot.
>
> --
> bill davidsen <davidsen@tmr.com>
>   CTO, TMR Associates, Inc
> Doing interesting things with little computers since 1979.
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
