Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288149AbSBEEpj>; Mon, 4 Feb 2002 23:45:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288308AbSBEEpW>; Mon, 4 Feb 2002 23:45:22 -0500
Received: from rtlab.med.cornell.edu ([140.251.145.175]:63104 "HELO
	openlab.rtlab.org") by vger.kernel.org with SMTP id <S288149AbSBEEo7>;
	Mon, 4 Feb 2002 23:44:59 -0500
Date: Mon, 4 Feb 2002 23:44:58 -0500 (EST)
From: "Calin A. Culianu" <calin@ajvar.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Stevie O <stevie@qrpff.net>, <linux-kernel@vger.kernel.org>
Subject: Re: Asynchronous CDROM Events in Userland
In-Reply-To: <3C5F5F7E.8090703@zytor.com>
Message-ID: <Pine.LNX.4.30.0202042341030.31336-100000@rtlab.med.cornell.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Feb 2002, H. Peter Anvin wrote:

> Stevie O wrote:
>
> > At 09:07 PM 2/3/2002 -0800, H. Peter Anvin wrote:
> >
> >> Rather than a signal, it should be a file descriptor of some sort, so
> >> one can select() etc on it.  Personally I can't imagine polling would
> >> take any appreciable amount of resources, though.
> >
> >
> > Windows 95 polls the cd-rom drive for autorun.
> > It kills laptop batteries REAL quick.
> > CPU & memory aren't the only resources...
> >
>
> Does it spin up the CD-ROM doing so?
>
> 	-hpa

Probably it doesn't, but just having the cpu be non-idle when it could
otherwise be idle does add up over time.  In linux, polling the cdrom
*seems* inexpensive enough, but if you look at 'top' it seems to average
out to like 1-2% cpu time!  (Ok, these stats aren't super-accurate,
they're just from running 'top' with the kde autorun tool running).

[Admitedly, the autorun tool is written kind of strangely (it does one
redundant ioctl, plus it wait()s on its children constantly rather than
installing a signal handler), but still.. it would be nice to get those
extra cycles for quake3 or wolfenstein...]

-Calin

>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

