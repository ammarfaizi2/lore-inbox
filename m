Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030339AbWGaTR1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030339AbWGaTR1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 15:17:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030340AbWGaTR1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 15:17:27 -0400
Received: from wr-out-0506.google.com ([64.233.184.237]:59594 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1030339AbWGaTR0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 15:17:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:references:mime-version:content-type:content-disposition:content-transfer-encoding:in-reply-to:user-agent;
        b=QESDMj2j/pcUEsyosMwlboZroX1I4ZStPOg+2zNPSeRA8DQdYCssHwebmEQVMwqF0YaTjkXEdKdJIvpeKl1qvXW6WfZTwWtzryvrSm8bO9NhCMxHi3CCM2UzScnFap/m9coSuMqf3xhWLQaP4+s90deDCzLCR6fk8UMKvqqte54=
Date: Mon, 31 Jul 2006 12:17:12 -0700
From: Clay Barnes <clay.barnes@gmail.com>
To: Rudy Zijlstra <rudy@edsons.demon.nl>,
       Adrian Ulrich <reiser4@blinkenlights.ch>, vonbrand@inf.utfsm.cl,
       ipso@snappymail.ca, reiser@namesys.com, lkml@lpbproductions.com,
       jeff@garzik.org, tytso@mit.edu, linux-kernel@vger.kernel.org,
       reiserfs-list@namesys.com
Subject: Re: the " 'official' point of view" expressed by kernelnewbies.org
	regarding reiser4 inclusion
Message-ID: <20060731191712.GE17206@HAL_5000D.tc.ph.cox.net>
References: <1153760245.5735.47.camel@ipso.snappymail.ca>
	<200607241806.k6OI6uWY006324@laptop13.inf.utfsm.cl>
	<20060731125846.aafa9c7c.reiser4@blinkenlights.ch>
	<20060731144736.GA1389@merlin.emma.line.org>
	<20060731175958.1626513b.reiser4@blinkenlights.ch>
	<20060731162224.GJ31121@lug-owl.de>
	<Pine.LNX.4.64.0607311842120.13492@nedra.edsons.demon.nl>
	<20060731173239.GO31121@lug-owl.de>
	<20060731181120.GA9667@merlin.emma.line.org>
	<20060731184314.GQ31121@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060731184314.GQ31121@lug-owl.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20:43 Mon 31 Jul     , Jan-Benedict Glaw wrote:
> On Mon, 2006-07-31 20:11:20 +0200, Matthias Andree <matthias.andree@gmx.de> wrote:
> > Jan-Benedict Glaw schrieb am 2006-07-31:
> > >   * reiser3: A HDD containing a reiser3 filesystem was tried to be
> > >     booted on a machine that fucked up DMA writes. Fortunately, it
> > >     crashed really soon (right after going for read-write.)  After
> > >     rebooting the HDD on a sane PeeCee, it refused to boot. Starting
> > >     off some rescue system showed an _empty_ root filesystem.
> > 
> > Massive hardware problems don't count. ext2/ext3 doesn't look much better in
> > such cases. I had a machine with RAM gone bad (no ECC - I wonder what
> 
> They do! Very much, actually. These happen In Real Life, so I have to
> pay attention to them. Once you're in setups with > 10000 machines,
> everything counts. At some certain point, you can even use HDD's
> temperature sensors in old machines to diagnose dead fans.

I think what he meant was that it is unfair to blame reiser3 for data
loss in a massive failure situation as a case example by itself.  What
would be more appropriate (and fair) is saying something along the lines
of "in a machine with DMA failure, reiser3 hosed a drive, while ext3
only lost x data (or nothing).  In my situation, every bit of massive
failure robustness counts... "  This of course assumes you actually had
the *exact* same problem with hardware under ext3, pretty much in every
detail.  Of course, so many subtleties interact in massive ways with
filesystems and hardware problems, so we have to keep in mind how much
difference that can make (all the difference in the world), and that,
really, without a statistically significant sample size and some real
analysis, hardware failure comparisons are impossible to do fairly.

Of course, if ext3 were proven to be more robust against failures, I bet
the reiser team would be very interested in all the forensic data you
can offer, since, from what I've seen, they are always trying to make
reiser as good as possible---in speed, flexability, *and* robustness.
If they didn't care about the last, they'd benifit greatly from not
journaling!  :-P

--Clay
> 
> Everything that eases recovery for whatever reason is something you
> have to pay attention to. The simplicity of ext{2,3} is something I
> really fail to find proper words for. As well as the really good fsck.
> Once seen a SIGSEGV'ing fsck, you really don't want to go there.
> 
> MfG, JBG
> 
> -- 
>        Jan-Benedict Glaw       jbglaw@lug-owl.de                +49-172-7608481
>  Signature of:                       Eine Freie Meinung in einem Freien Kopf
>  the second  :                     für einen Freien Staat voll Freier Bürger.
