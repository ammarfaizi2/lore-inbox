Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313660AbSDPJfb>; Tue, 16 Apr 2002 05:35:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313661AbSDPJfa>; Tue, 16 Apr 2002 05:35:30 -0400
Received: from ws-002.ray.fi ([193.64.14.2]:9356 "EHLO behemoth.ts.ray.fi")
	by vger.kernel.org with ESMTP id <S313660AbSDPJfa>;
	Tue, 16 Apr 2002 05:35:30 -0400
Date: Tue, 16 Apr 2002 12:30:17 +0300 (EEST)
From: Tommi Kyntola <kynde@ts.ray.fi>
X-X-Sender: kynde@behemoth.ts.ray.fi
To: Gerd Knorr <kraxel@bytesex.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19-pre7
In-Reply-To: <slrnabnps8.evm.kraxel@bytesex.org>
Message-ID: <Pine.LNX.4.44.0204161222280.30988-100000@behemoth.ts.ray.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I can confirm this, mere TCGETS for ioctl(2) fails with errno 5 (EIO).
Has been fine right up to 2.4.19-pre7 since the invention of the wheel. :)

> Marcelo Tosatti wrote:
> >  
> >  Hi, 
> >  
> >  Here goes pre7.
> 
> This one breaks my serial ports.  Related config:
> 
> bogomips kraxel /work/bk/2.4/build# grep CONFIG_SERIAL .config
> CONFIG_SERIAL=y
> CONFIG_SERIAL_CONSOLE=y
> # CONFIG_SERIAL_EXTENDED is not set
> # CONFIG_SERIAL_NONSTANDARD is not set
> bogomips kraxel /work/bk/2.4/build# 
> 
> If I try to boot the box with serial console enabled
> (console=ttyS0,115200n8 console=tty0) it hangs at boot time.  Without
> the "console=ttyS0 ..." it boots just fine.  But I get no login prompt
> at the serial line.  Syslog shows this:
> 
> Apr 16 10:43:21 bogomips agetty[979]: ttyS0: ioctl: Input/output error
> Apr 16 10:43:31 bogomips agetty[1022]: ttyS0: ioctl: Input/output error
> Apr 16 10:43:42 bogomips agetty[1023]: ttyS0: ioctl: Input/output error
> Apr 16 10:43:52 bogomips agetty[1025]: ttyS0: ioctl: Input/output error
> Apr 16 10:44:02 bogomips agetty[1030]: ttyS0: ioctl: Input/output error
> Apr 16 10:44:12 bogomips agetty[1040]: ttyS0: ioctl: Input/output error
> Apr 16 10:44:22 bogomips agetty[1044]: ttyS0: ioctl: Input/output error
> Apr 16 10:44:32 bogomips agetty[1071]: ttyS0: ioctl: Input/output error
> Apr 16 10:44:42 bogomips agetty[1111]: ttyS0: ioctl: Input/output error
> Apr 16 10:44:52 bogomips init: Id "S0" respawning too fast: disabled for 5 minutes
> 
> -pre6 works just fine.
> 
>   Gerd
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
Tommi Kynde Kyntola		kynde@ts.ray.fi
      "A man alone in the forest talking to himself and
       no women around to hear him. Is he still wrong?"


