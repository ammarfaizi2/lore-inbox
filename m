Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288256AbSAMWxJ>; Sun, 13 Jan 2002 17:53:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288258AbSAMWxA>; Sun, 13 Jan 2002 17:53:00 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:32599 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S288256AbSAMWwt>; Sun, 13 Jan 2002 17:52:49 -0500
Date: Mon, 14 Jan 2002 00:52:44 +0200
From: Ville Herva <vherva@niksula.hut.fi>
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.18pre3-ac1
Message-ID: <20020113225244.GC51648@niksula.cs.hut.fi>
In-Reply-To: <200201132144.g0DLikH27385@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200201132144.g0DLikH27385@devserv.devel.redhat.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 13, 2002 at 04:44:46PM -0500, you [Alan Cox] claimed:
> People keep bugging me about the -ac tree stuff so this is whats in my
> current internal diff with the ll patch and the ide changes excluded.

Any big reason why you aren't including those two? I'm pretty sure a lot of
people will eventual bug Marcelo (and you) about merging ide to 2.4
proper (or -ac)... :)

> Linux 2.4.18pre3-ac1
> 
> o	rmap-11b VM					(Rik van Riel,
> 							 William Irwin etc)

So I gather you find this better than AA vm, even the -aa version?

> o	Fix O_NDELAY close mishandling on the following	(me)
> 	sound cards: cmpci, cs46xx, es1370, es1371,
> 	esssolo1, sonicvibes

With 17rc1, es1370 went once or twice to a state where it kept accepting
data _very_ slowly and seemingly nothing came out of speakers. Actually I'm
not sure if it actually ate any data, echo > /dev/dsp blocked, but some
audio apps _seemed_ to make some progress.

rmmod es1370; insmod es1370 succeeded, but didn't help - I had to reboot.

2.4.10ac10 (which is what I ran before 17rc1) never showed this. I wan't
able to reproduce it on purpose.

I guess this is not the fix for that?


-- v --

v@iki.fi
