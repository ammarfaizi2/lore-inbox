Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271798AbRHRKAV>; Sat, 18 Aug 2001 06:00:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271800AbRHRKAL>; Sat, 18 Aug 2001 06:00:11 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:41595 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S271798AbRHRKAD>; Sat, 18 Aug 2001 06:00:03 -0400
To: Dan Hollis <goemon@anime.net>
Cc: <root@chaos.analogic.com>,
        David Christensen <David_Christensen@Phoenix.com>,
        Holger Lubitz <h.lubitz@internet-factory.de>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Encrypted Swap
In-Reply-To: <Pine.LNX.4.30.0108171200510.4065-100000@anime.net>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 18 Aug 2001 03:52:53 -0600
In-Reply-To: <Pine.LNX.4.30.0108171200510.4065-100000@anime.net>
Message-ID: <m1snepoft6.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Hollis <goemon@anime.net> writes:

> On 17 Aug 2001, Eric W. Biederman wrote:
> > Clearing memory on most machines takes a 1s or less.  Think of memory
> > fill rates at the 800MB/s level.  Most BIOS's seem to clear some of
> > the memory but I haven't read their code to see what they are doing.
> 
> Ive measured rates far lower than that, at least for SDRAM.

Hmm.  The numbers were off the top of my head and I've been messing
with DDR SDRAM quite a bit so I may have doubled it.   Hmm.

Nope.  I was remember something close to the typical streams numbers
on an Athlon with DDR SDRAM.  Since those are read-modify-write
numbers they should be close to the write numbers for normal SDRAM.

With a PII/PIII and PC100 SDRAM I have measured about 640 MB/s writes.

> http://bani.anime.net/memspeed/

However just looking at your numbers, I would guess that there is
something off.  Read numbers should almost always be worse then write
numbers on SDRAM, because reads have a latency between the command and
the first data cycle.  Writes do not have that delay.  

Compare what you have to streams.  But those numbers from Memtest.c
don't look correct at all.

Eric
