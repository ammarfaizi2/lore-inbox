Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317772AbSHaRU3>; Sat, 31 Aug 2002 13:20:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317778AbSHaRU3>; Sat, 31 Aug 2002 13:20:29 -0400
Received: from smtp-send.myrealbox.com ([192.108.102.143]:25154 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id <S317772AbSHaRU2>; Sat, 31 Aug 2002 13:20:28 -0400
From: "Pedro M. Rodrigues" <pmanuel@myrealbox.com>
To: Rik van Riel <riel@conectiva.com.br>
Date: Sat, 31 Aug 2002 19:22:16 +0200
MIME-Version: 1.0
Subject: Re: PROBLEM: nfs & "Warning - running *really* short on DMA buffers"
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
Message-ID: <3D711768.19281.F874DB@localhost>
In-reply-to: <3D70E0E4.32286.238238@localhost>
References: <Pine.LNX.4.44L.0208300916580.1857-100000@imladris.surriel.com>
X-mailer: Pegasus Mail for Windows (v4.02)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Replying to myself, i found out that in kernel 2.4.20-pre5, the 
section responsible for the warning has a #if  0 #endif around it . 
This was not the case in 2.4.19 btw. I had rate limited the warning, 
but it's not needed. 

Thanks to everybody,
Pedro

On 31 Aug 2002 at 15:29, Pedro M. Rodrigues wrote:

>    It doesn't seem rate limited to me, it floods the console and log
> files. If i can't tune the vm settings to decrease the likelyhood of
> this error message, what can i do? Is rate limiting the error message
> at scsi_merge.c a good idea?
> 
> 
> Thanks,
> Pedro
> 
> On 30 Aug 2002 at 9:18, Rik van Riel wrote:
> 
> > On Fri, 30 Aug 2002, Pedro M. Rodrigues wrote:
> > 
> > >    I do wan't to tune the vm settings, these warnings may not be
> > > fatal but it's not pretty to have hundreds of those in the console
> > > and log files. Bear with me on this one, but i remember doing
> > > exactly that in the past, tuning  /proc/sys/vm/freepages. How does
> > > one acomplish that nowadays? I looked at the kernel source
> > > documentation and still found references to freepages, but
> > > vm/freepages doesn't exist anymore. Kernel is 2.4.18-10 from
> > > Redhat.
> > 
> > For fundamental reasons it's always possible for non-sleeping
> > allocations to fail.  I think this warning just needs to be
> > rate-limited, if it isn't already ...
> > 
> > OTOH, failed allocations could serve as a hint for kswapd to
> > try to keep more memory free. I should look into that for some
> > next version.
> > 
> > regards,
> > 
> > Rik
> > -- 
> > Bravely reimplemented by the knights who say "NIH".
> > 
> > http://www.surriel.com/		http://distro.conectiva.com/
> > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe
> > linux-kernel" in the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> > 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


