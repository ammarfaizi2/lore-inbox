Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313823AbSDIIdq>; Tue, 9 Apr 2002 04:33:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313824AbSDIIdp>; Tue, 9 Apr 2002 04:33:45 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:3595 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S313823AbSDIIdp>; Tue, 9 Apr 2002 04:33:45 -0400
Message-Id: <200204090830.g398URX01757@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Anssi Saari <as@sci.fi>
Subject: Re: PROMBLEM: CD burning at 16x uses excessive CPU, although DMA is enabled
Date: Tue, 9 Apr 2002 11:33:40 -0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020408122603.GA7877@sci.fi> <Pine.LNX.3.96.1020408104857.21476C-100000@gatekeeper.tmr.com> <20020408154732.GA10271@sci.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8 April 2002 13:47, Anssi Saari wrote:
> I didn't really know how to put it. Maybe system load would be better. But
> the actual problem is, I effectively can't burn audio and other types
> at 16x in Linux, while there is no problem in some other operating systems
> with the same hardware and applications.
>
> Here're some time figures from cdrdao:
>
> cdrdao simulate -n --speed 8 foo.cue  2.62s user 3.37s system 1% cpu
> 6:41.86 total cdrdao simulate -n --speed 12 foo.cue  2.78s user 29.91s
> system 12% cpu 4:31.71 total cdrdao simulate -n --speed 16 foo.cue  2.67s
> user 128.77s system 52% cpu 4:10.68 total
>
> So yes, system time goes up quite steeply.
>
> But even though 50% is quite high, CPU load is not the problem as such,
> the problem is getting data to the writer fast enough. And it's not
> happening. Even a single audio track that is completely cached so that
> there is no HD access has problems. It's like somehow accessing the CD
> writer hogs the system for such long periods that there is insufficient
> time to fill the writing program's buffer.

You may try profiling kernel to see where it exactly spending that time.
It has an added benefit: you will learn how to profile kernels (if you
don't know how to do it already).

I am waiting for similar problem to bite me to learn that, too. :-)

> One thing I noticed just now. If I turn off unmaskirq for the CD writer
> with hdparm -u 0 /dev/hdc, it helps a little, but not enough. Time
> reports now:
>
> cdrdao simulate -n --speed 16 foo.cue  2.75s user 75.18s system 58% cpu
> 2:13.22 total
--
vda
