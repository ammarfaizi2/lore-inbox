Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264272AbUE3Rgs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264272AbUE3Rgs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 May 2004 13:36:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264261AbUE3Rgs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 May 2004 13:36:48 -0400
Received: from APastourelles-108-2-1-3.w80-14.abo.wanadoo.fr ([80.14.139.3]:56837
	"EHLO samwise.two-towers.net") by vger.kernel.org with ESMTP
	id S264272AbUE3Rgq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 May 2004 13:36:46 -0400
Message-ID: <40BA1B9B.9070805@two-towers.net>
Date: Sun, 30 May 2004 19:36:27 +0200
From: Philip Dodd <phil.lists@two-towers.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040528 Debian/1.6-7
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Philip Dodd <phil.lists@two-towers.net>, linux-kernel@vger.kernel.org,
       Hugo Mills <hugo-lkml@carfax.org.uk>, Daniele Bernardini <db@sqbc.com>
Subject: Re: dma ripping
References: <1084548566.12022.57.camel@linux.site> <20040515101415.GA24600@suse.de> <1084610731.4666.8.camel@linux.site> <20040515145800.GE24600@suse.de> <1084629809.4612.51.camel@linux.site> <20040515211901.GG24600@suse.de> <40A78834.1030605@two-towers.net> <20040516153945.GA21520@selene> <40A9377A.70200@two-towers.net> <20040520133437.GH1952@suse.de>
In-Reply-To: <20040520133437.GH1952@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Tue, May 18 2004, Philip Dodd wrote:
>>Hugo Mills wrote:
>>>  Put me down for this latter one, too. I'm using a vanilla 2.6.[56]
>>>on amd64. Controller is VIA.
>>>  It seems to be related to hard-to-read CDs (dirty/scratched/badly-
>>>made) -- I've got a couple here that I'm pretty sure I can use as test
>>>cases to trigger the problem instantly.
>>Hi,
>>OK - I don't know if any of this helps, but I guess a little more 
>>precision won't do anyone any harm.
>>Intel i820 Chipset on P3C-D mobo.
>>ide0: BM-DMA at 0xa800-0xa807, BIOS settings: hda:DMA, hdb:pio
>>hda: ASUS DVD-ROM E616, ATAPI CD/DVD-ROM drive
>>hda: ATAPI 48X DVD-ROM drive, 512kB Cache, UDMA(33)
>>ide1: BM-DMA at 0xa808-0xa80f, BIOS settings: hdc:DMA, hdd:pio
>>hdc: RICOH CD-R/RW MP7060A, ATAPI CD/DVD-ROM drive
>>hdc: ATAPI 24X CD-ROM CD-R/RW drive, 2048kB Cache, DMA
>>Now hda is the one that bogs out, ripping silence after the "cdrom:
>>dropping to single frame dma" error. hdc can rip for hours and hardly 
>>ever get cdparanoia errors - even on "problematic" CDs that would appear 
>>to be a declenching factor for the single frame dma switch for hda.

> Any chance you can see if this makes any difference (on 2.6.6-BK)?

Hi,

Sorry it took a while for me to get you feedback on this patch.  I have 
just applied this patch against 2.6.7-rc2 (some fuzz and some offset - I 
can get you details if you would like).  It exhibits exactly the same 
symptoms as before - ie. certain CDs will cause the "kernel: cdrom: 
dropping to single frame dma", and all ripping form that point on until 
reboot will just rip to silence (I have one test case that does it 75% 
of the way through track 4, as regular as clockwork, but several other 
do to, and some even appear not to do it all the time - physically the 
CD is in good shape and rips fine using Win32 ripping tools on my laptop).

My next guess is that this is a hardware problem, though I'd appreciate 
your feedback on whether that patch should have fixed or not.

Thanks again for all your help on this,

Phil
