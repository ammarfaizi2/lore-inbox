Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314559AbSEHQ0F>; Wed, 8 May 2002 12:26:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314556AbSEHQ0E>; Wed, 8 May 2002 12:26:04 -0400
Received: from rtlab.med.cornell.edu ([140.251.145.175]:6626 "HELO
	openlab.rtlab.org") by vger.kernel.org with SMTP id <S314513AbSEHQ0D>;
	Wed, 8 May 2002 12:26:03 -0400
Date: Wed, 8 May 2002 12:26:03 -0400 (EDT)
From: "Calin A. Culianu" <calin@ajvar.org>
X-X-Sender: <calin@rtlab.med.cornell.edu>
To: Der Herr Hofrat <der.herr@mail.hofr.at>
Cc: "Serguei I. Ivantsov" <administrator@svitonline.com>,
        <linux-gcc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: Measure time
In-Reply-To: <200205081200.g48C0a805476@hofr.at>
Message-ID: <Pine.LNX.4.33L2.0205081224390.9196-100000@rtlab.med.cornell.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 May 2002, Der Herr Hofrat wrote:

> > Hello!
> >
> > Is there any function for high precision time measuring.
> > time() returns only in second. I need nanoseconds.
> >
> you can directly read the TSC but that will not realy give you nanoseconds
> resolution as the actual read access even on a PIII/1GHz is going to take
> up to a few 100 nanoseconds, and depending on what you want to time
> stamp the overall jitter of that code can easaly be in the
> range of a microsecond.
>
> There are some hard-realtime patches to the Linux kernel that will
> allow time precission of aprox. 1us (the TSC has a precission of 32ns)
> but I don't think you can get below that without dedicated hardware.
>
> for RTLinux check at ftp://ftp.rtlinux.org/pub/rtlinux/

I recommend RTAI instead.  It's more feature-rich, and works with newer
kernels.. the url is http://www.aero.polimi.it/~rtai/, or
http://www.rtai.org.

-Calin

>
> hofrat
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

