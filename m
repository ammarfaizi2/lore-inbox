Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317905AbSFSPPP>; Wed, 19 Jun 2002 11:15:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317907AbSFSPPO>; Wed, 19 Jun 2002 11:15:14 -0400
Received: from mtvwca1-smrly1.gtei.net ([128.11.176.196]:35495 "HELO
	mtvwca1-smrly1.gtei.net") by vger.kernel.org with SMTP
	id <S317905AbSFSPPN>; Wed, 19 Jun 2002 11:15:13 -0400
To: linux-kernel@vger.kernel.org
Cc: gibbs@scsiguy.com
Subject: Re: AIC7XXX + v2.4.18 problems?
References: <m3k7ov2tly.fsf@noop.bombay>
From: Nick Papadonis <nick@coelacanth.com>
Organization: None
X-Face: 01-z%.O)i7LB;Cnxv)c<Qodw*J*^HU}]Y-1MrTwKNn<1_w&F$rY\\NU6U\ah3#y3r<!M\n9
 <vK=}-Z{^\-b)djP(pD{z1OV;H&.~bX4Tn'>aA5j@>3jYX:)*O6:@F>it.>stK5,i^jk0epU\$*cQ9
 !)Oqf[@SOzys\7Ym}:2KWpM=8OCC`
Date: Wed, 19 Jun 2002 11:15:10 -0400
In-Reply-To: <m3k7ov2tly.fsf@noop.bombay> (Nick Papadonis's message of "Wed,
 19 Jun 2002 11:09:13 -0400")
Message-Id: <m3fzzj2tc1.fsf@noop.bombay>
User-Agent: Gnus/5.090006 (Oort Gnus v0.06) XEmacs/21.1 (Cuyahoga Valley,
 i686-pc-linux)
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wonder if problems are due to my VIA PCI chipset?  Here are some details:


  Bus  0, device  10, function  0:
    SCSI storage controller: Adaptec AIC-7892A U160/m (rev 2).
      IRQ 12.
      Master Capable.  Latency=32.  Min Gnt=40.Max Lat=25.
      I/O at 0xa800 [0xa8ff].
      Non-prefetchable 64 bit memory at 0xdf000000 [0xdf000fff].

  Bus  0, device   0, function  0:
    Host bridge: VIA Technologies, Inc. VT82C693A/694x [Apollo PRO133x] (rev 196).
      Prefetchable 32 bit memory at 0xe7000000 [0xe7ffffff].

  Bus  0, device   1, function  0:
    PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo MVP3/Pro133x AGP] (rev 0).
      Master Capable.  No bursts.  Min Gnt=8.



Nick Papadonis <nick@coelacanth.com> writes:

> Is anyone else having problems with the AIC7XXX driver using a AHA-29160
> controller?  I believe my kernel is going into a unrecoverable spin-lock 
> when there is high SCSI load.  I'm assuming this because the keyboard 
> lights still function and network still replies to pings.
>
> In addition the 'st' driver returns with unrecoverable errors when 
> trying to tar to tape.  This usually occurs after a few hundred 
> megabytes have been pushed through a device.
>
> My setup is :
>    - AHA-29160N controller
>    - Internal 50 PIN / SCSI-2 port in use
>    - See below for connected drives
>
> I tested the following kernels and they display similar behavior:
>    - v2.4.9
>    - v2.4.18
>    - v2.4.18 with updated 7XXX driver
>    - v2.4.19-pre10
>
> Any insight is appreciated.
>
> - Nick
