Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129800AbRCERVF>; Mon, 5 Mar 2001 12:21:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129797AbRCERUz>; Mon, 5 Mar 2001 12:20:55 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:55566 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129800AbRCERUo>; Mon, 5 Mar 2001 12:20:44 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Escape sequences & console
Date: 5 Mar 2001 09:20:29 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <980hst$8ln$1@cesium.transmeta.com>
In-Reply-To: <"3a9ea6fa3b646cc9@citronier.wanadoo.fr> <Pine.LNX.4.31.0103022208050.30419-100000@phobos.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.31.0103022208050.30419-100000@phobos.fachschaften.tu-muenchen.de>
By author:    Simon Richter <Simon.Richter@phobos.fachschaften.tu-muenchen.de>
In newsgroup: linux.dev.kernel
> 
> From the source of the chvt program:
> 
>     if (ioctl(fd,VT_ACTIVATE,num)) {
>         perror("chvt: VT_ACTIVATE");
>         exit(1);
>     }
>     if (ioctl(fd,VT_WAITACTIVE,num)) {
>         perror("VT_WAITACTIVE");
>         exit(1);
>     }
> 
> Where fd is /dev/tty, /dev/tty0, /dev/console or std{in,out,err} (From the
> source, I doubt this ioctl works on all of those).
> 

/dev/tty0 would be the correct device (tty0 = current virtual
console.)

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
