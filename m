Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272926AbRIWAPE>; Sat, 22 Sep 2001 20:15:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272942AbRIWAOy>; Sat, 22 Sep 2001 20:14:54 -0400
Received: from mail6.speakeasy.net ([216.254.0.206]:58637 "EHLO
	mail6.speakeasy.net") by vger.kernel.org with ESMTP
	id <S272926AbRIWAOp>; Sat, 22 Sep 2001 20:14:45 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: safemode <safemode@speakeasy.net>
To: Dieter =?iso-8859-1?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>,
        Robert Love <rml@tech9.net>
Subject: Re: [PATCH] Preemption Latency Measurement Tool
Date: Sat, 22 Sep 2001 20:15:09 -0400
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.30.0109201659210.5622-100000@waste.org> <20010922211919Z272247-760+15646@vger.kernel.org> 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20010923001447Z272926-760+15671@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 22 September 2001 19:46, Dieter Nützel wrote:
> Am Sonntag, 23. September 2001 01:40 schrieb safemode:
> > ok. The preemption patch helps realtime applications in linux be a little
> > more close to realtime.  I understand that.  But your mp3 player
> > shouldn't need root permission or renicing or realtime priority flags to
> > play mp3s. To test how well the latency patches are working you should be
> > running things all at the same priority.  The main issue people are
> > having with skipping mp3s is not in the decoding of the mp3 or in the
> > retrieving of the file, it's in the playing in the soundcard.  That's
> > being affected by dbench flooding the system with irq requests.  I'm
> > inclined to believe it's irq requests because the _only_ time i have
> > problems with mp3s (and i dont change priority levels) is when A. i do a
> > cdparanoia -Z -B "1-"    or dbench 32.   I bet if someone did these tests
> > on scsi hardware with the latency patch, they'd find much better results
> > than us users of ide devices.
>
> Nope.
> If you would have read (all) posts about this and related threads you
> should have noticed that I am and others running SCSI systems...

hrmm  strange because the only thing that could be causing the soundcard to 
skip would be irq requests still stuck in the cpu as far as i know.  I only 
get that with massive ide access and that's it.  Also that is when linux is 
juggling them all equally. 

> > even i dont get any skips when i run the player at nice -n -20.
>
> During dbench 16/32 and higher? Are you sure?

I ran it myself and i dont drink alcohol or take drugs.  so yea, i'm sure :)  
If i went high enough i suppose the same problem would occur.  it's probably 
in an area of the kernel where the preempt patch doesn't work (yet).    It 
does happen on cdparanoia -Z -B "1"    I dont think anything ide is safe from 
that.    

> -Dieter
