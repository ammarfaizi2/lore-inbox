Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932562AbWAJUOY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932562AbWAJUOY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 15:14:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932558AbWAJUOY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 15:14:24 -0500
Received: from ds01.webmacher.de ([213.239.192.226]:44488 "EHLO
	ds01.webmacher.de") by vger.kernel.org with ESMTP id S932530AbWAJUOX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 15:14:23 -0500
In-Reply-To: <Pine.LNX.4.61.0601101455140.10330@tm8103.perex-int.cz>
References: <20050726150837.GT3160@stusta.de>  <20060103193736.GG3831@stusta.de> <Pine.BSO.4.63.0601032210380.29027@rudy.mif.pg.gda.pl>  <mailman.1136368805.14661.linux-kernel2news@redhat.com>  <20060104030034.6b780485.zaitcev@redhat.com>  <Pine.LNX.4.61.0601041220450.9321@tm8103.perex-int.cz> <Pine.BSO.4.63.0601051253550.17086@rudy.mif.pg.gda.pl>  <Pine.LNX.4.61.0601051305240.10350@tm8103.perex-int.cz>  <Pine.BSO.4.63.0601051345100.17086@rudy.mif.pg.gda.pl>  <s5hmziaird8.wl%tiwai@suse.de> <Pine.LNX.4.61.0601060028310.27932@zeus.compusonic.fi> <1136504460.847.91.camel@mindpipe> <Pine.LNX.4.61.0601060156430.27932@zeus.compusonic.fi> <Pine.LNX.4.61.0601101040430.10330@tm8103.perex-int.cz> <Pine.LNX.4.61.0601101520360.24146@zeus.compusonic.fi> <Pine.LNX.4.61.0601101455140.10330@tm8103.perex-int.cz>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <720AF6CA-E42F-4ABC-9FEF-545D1B3A9F8B@dalecki.de>
Cc: Hannu Savolainen <hannu@opensound.com>, Lee Revell <rlrevell@joe-job.com>,
       Takashi Iwai <tiwai@suse.de>, linux-sound@vger.kernel.org,
       LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Marcin Dalecki <martin@dalecki.de>
Subject: Re: [OT] ALSA userspace API complexity
Date: Tue, 10 Jan 2006 21:13:31 +0100
To: Jaroslav Kysela <perex@suse.cz>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2006-01-10, at 15:08, Jaroslav Kysela wrote:

> On Tue, 10 Jan 2006, Hannu Savolainen wrote:
>
>> On Tue, 10 Jan 2006, Jaroslav Kysela wrote:
>>
>>> Overloading interrupt handlers with extra things is evil (and I  
>>> bet you're
>>> mixing samples in the interrupt handler). Even the network stack  
>>> uses
>>> interrupts only for DMA management and not for any extra operations.
>> You mean it's evil because nobody else is doing it? Then it must be
>> evil or rather voodoo.
>
> No, I mean that it's quite obvious bad design, because you might  
> increase
> interrupt latencies for other drivers.

"Becasue you might" is a bad argument. Either you do or you don't. My  
guess is that you don't
becase the amount of data to be handled is absymally small. (Come one  
48kBaud is not much...)
And BTW. good luck trying to convince  the /dev/random gang that it  
isn't good for performance
what they are doing on the IRQ path...


Marcin Dalecki


