Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318918AbSHEUXH>; Mon, 5 Aug 2002 16:23:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318921AbSHEUXH>; Mon, 5 Aug 2002 16:23:07 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:22772 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318918AbSHEUXG>; Mon, 5 Aug 2002 16:23:06 -0400
Subject: Re: i810 sound broken...
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Juergen Sawinski <juergen.sawinski@mpimf-heidelberg.mpg.de>
Cc: "linux-kernel@vger" <linux-kernel@vger.kernel.org>
In-Reply-To: <1028578861.1894.15.camel@voyager>
References: <200208051127.g75BRgX27554@eday-fe5.tele2.ee> 
	<1028552057.18130.6.camel@irongate.swansea.linux.org.uk> 
	<1028578861.1894.15.camel@voyager>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 05 Aug 2002 22:44:59 +0100
Message-Id: <1028583899.18156.86.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-08-05 at 21:21, Juergen Sawinski wrote:
> On my Intel D845GBV board (obviously ICH4) none of 2.4 nor alsa works.
> It's a production box, so I hestitate to try 2.5.

2.5 is older audio code than 2.4.19-ac

If your audio isnt working then a good starting point is to grab the
2.4.19-ac1 i810_audio (you can drop those files into 2.4.19 vanilla
fine)

1.	Does the mixer work, can you play a CD, control the volume etc ?

If so that means we have an active codec and the AC97 bus is running

2.	Do you get regular interrupts doing "yes oink >/dev/audio"

This is a good clue to whether the bus master engine is running. If it
is we should be getting regular interrupts (and if the audio works a
nasty squeak)

3.	Does the audio speed test report about 48Khz (expected except on some
Dell laptops)

