Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262910AbREWAGV>; Tue, 22 May 2001 20:06:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262915AbREWAGB>; Tue, 22 May 2001 20:06:01 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:34066 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262912AbREWAFw>; Tue, 22 May 2001 20:05:52 -0400
Message-ID: <3B0AFEC8.CDBF6C92@transmeta.com>
Date: Tue, 22 May 2001 17:05:28 -0700
From: "H. Peter Anvin" <hpa@transmeta.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5-pre1-zisofs i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Martin Knoblauch <martin.knoblauch@teraport.de>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Patch] Output of L1,L2 and L3 cache sizes to /proc/cpuinfo
In-Reply-To: <3B0A28C0.2FFFC935@TeraPort.de> <3B0A3794.15BDF9D6@TeraPort.de> <3B0A99E7.467CE534@transmeta.com> <3B0AFCFB.CAE7A145@teraport.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Knoblauch wrote:
> >
> > If so, then that's their problem.  We're not here to solve the problem of
> > stupid system administrators.
> >
> 
>  They may not be stupid, just mislead :-( When Intel created the "cpuid"
> Feature some way along the P3 line, they gave a stupid reason for it and
> created a big public uproar. As silly as I think that was (on both
> sides), the term "cpuid" is tainted. Some people just fear it like hell.
> Anyway.
> 

Ummm... CPUID has been around since the P5, and even if you have one with
the serial-number feature, Linux disables it. 

> > > - you would need a utility with root permission to analyze the cpuid
> > > info. The
> > >   cahce info does not seem to be there in clear ascii.
> >
> > Bullsh*t.  /dev/cpu/%d/cpuid is supposed to be mode 444 (world readable.)
> >
> 
>  Thanks you :-) In any case, on my system (Suse 7.1) the files are mode
> 400.
> 

It's pointless since you can execute CPUID directly in user space.  The
device is there just to support CPU selection in a multiprocessor system.

	-hpa
