Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261186AbUE2Wvl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261186AbUE2Wvl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 18:51:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261206AbUE2Wvj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 18:51:39 -0400
Received: from out014pub.verizon.net ([206.46.170.46]:48812 "EHLO
	out014.verizon.net") by vger.kernel.org with ESMTP id S261186AbUE2Wvd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 18:51:33 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: "Mario 'BitKoenig' Holbe" <Mario.Holbe@RZ.TU-Ilmenau.DE>,
       linux-kernel@vger.kernel.org, Henrik Persson <nix@syndicalist.net>,
       Sebastian <sebastian@expires0604.datenknoten.de>,
       Bruce Allen <ballen@gravity.phys.uwm.edu>
Subject: Re: Strange DMA-errors and system hang with Promise 20268
Date: Sat, 29 May 2004 18:51:31 -0400
User-Agent: KMail/1.6
References: <1078602426.16591.8.camel@vega> <c2dsha$psd$1@sea.gmane.org> <20040529144256.GA399@darkside.22.kls.lan>
In-Reply-To: <20040529144256.GA399@darkside.22.kls.lan>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200405291851.31585.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out014.verizon.net from [141.153.75.74] at Sat, 29 May 2004 17:51:32 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 29 May 2004 10:42, Mario 'BitKoenig' Holbe wrote:
>Hi,
>
>On Sun, Mar 07, 2004 at 02:05:46AM +0100, Mario 'BitKoenig' Holbe 
wrote:
>> Mar  4 01:01:06 darkside kernel: hde: dma_timer_expiry: dma status
>> == 0x21
>
>hmmm, it seems I solved the issue in my case.
>
>I did just connect the two disks on the Promise to a second separate
>power supply and everything works rock-stable and survives all
> things that went wrong before (parallel fsck, parallel hdparm -t as
> well as 'normal operation' over days).
>Things remain stable even with the WDC disk connected back to the
>Promise, which was heavy unstable before.
>
>Moreover, when I connect the disks back to the machines internal
> power supply, the problems arise again - immediately.
>
>IMHO, this does also explain, why the problems happen while heavy
> I/O (parallel over all disks) and/or while S.M.A.R.T selftests are
> running (also: parallel over all disks).
>
>Well, I thought, a 300W power supply would be enough for 1GHz P-III
>and 4 disks. And it definitely was enough for a long time.

It probably was, back up the log to when that 1Ghz P-III was new.  
However, psu's tend to suck up and trap all the dust in the universe 
(I mean there can't be that much dust in *my* house, can there? :) 
and can get ungodly hot, thereby cooking the goodies out of the 
electrolytic caps, which have failure temps ranging from 85C to 105C.

This is one of the reasons I try to pull all my gear apart and give it 
a good blasting with the air hose from my junky old air compressor at 
least annually.

Anyway, to make a long story shorter, either have a technician equipt 
with a ESR reading meter look all the caps in the psu over and 
replace any that aren't up to snuff, or replace the supply with a 
fresh one.  But, finding a tech with an ESR meter could be quite a 
chore, so I'd go psu shopping at Circuit City or wherever since the 
tech will probably want more in labor than fresh new ones cost.

>Most likely, the power supply just aged and its capacity decreased.
>
>Perhaps, the disks consume more power with newer kernels, but while
>crawling the lkm archives I found similar reports also for 2.4.19.
>
>I have no idea, why always the disks connected to the Promise
>controller did fail. Perhaps, the Promise is more sensitive
> regarding signal quality on the IDE wire.
>
>I have no idea, why my WDC disk failed when connected to the
> Promise, while others did work far more stable. Perhaps, the WDC
> disks signal quality under low-power is more bad than the one of
> other disks.
>
>I have no idea, why the WDC disk did work well when it was connected
>to the onboard controller. Perhaps, the lower signal quality of the
>WDC (if so) and the sensitivity of the Promise (if so) added
> together was too much at all.
>
>
>Henrik, Sebastian: if you still have problems, this is probably
>something to test for you.
>
>Sebastian: if you experience more instability after exchanging your
>drive with a newer (bigger? faster?) one, your chance is high to get
>it solved with a bigger power supply, I'd guess :)
>
>Bruce: this is probably something to hint for at the smartmontools
>warning page.
>
>
>regards,
>   Mario

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.23% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
