Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265065AbSLQNxT>; Tue, 17 Dec 2002 08:53:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265066AbSLQNxT>; Tue, 17 Dec 2002 08:53:19 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:61921
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265065AbSLQNxS>; Tue, 17 Dec 2002 08:53:18 -0500
Subject: Re: Via 8233 flooding of errors [2.4-ac]
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Nathaniel Russell <reddog83@chartermi.net>
Cc: alan@redhat.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0212170636420.1698-200000@reddog.example.net>
References: <Pine.LNX.4.44.0212170636420.1698-200000@reddog.example.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 17 Dec 2002 14:41:07 +0000
Message-Id: <1040136067.20018.1.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-12-17 at 11:41, Nathaniel Russell wrote:
> Hello
> When i play 3 or more songs in a row i get the error message of
> drained playback and my audio just shuts off until i exit the mp3 program
> and reload it. Every 3rd song though it stops playing. And plus once in
> awhile i get a Assertion failed message. Help please....
> Nathaniel

> Assertion failed! chan->is_active == sg_active(chan->iobase),via82cxxx_audio.c,via_chan_maybe_start,line=1347
> via_audio: ignoring drain playback error -512
> [SNIPED]

I need to look at the assertion - somehow the chip is being stopped when
it should not have been. The ignoring drain playback error one is over
paranoia in the driver and quite legal (you hit ^C is what made that
second moan appear)

