Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268390AbTGNIvr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 04:51:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268417AbTGNIvr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 04:51:47 -0400
Received: from usr.lcm.msu.ru ([193.232.113.217]:55725 "EHLO
	tentacle.sectorb.msk.ru") by vger.kernel.org with ESMTP
	id S268390AbTGNIv2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 04:51:28 -0400
Date: Mon, 14 Jul 2003 13:06:15 +0400
From: "Vladimir B. Savkin" <master@sectorb.msk.ru>
To: Wes Janzen <superchkn@sbcglobal.net>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, reiserfs-list@namesys.com
Subject: Re: FS Corruption with VIA MVP3 + UDMA/DMA
Message-ID: <20030714090615.GA6334@tentacle.sectorb.msk.ru>
References: <16128.19218.139117.293393@charged.uio.no> <3F007EBF.9020506@sbcglobal.net> <3F10729F.7070701@sbcglobal.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <3F10729F.7070701@sbcglobal.net>
User-Agent: Mutt/1.3.28i
X-Organization: Moscow State Univ., Dept. of Mechanics and Mathematics
X-Operating-System: Linux 2.4.21-rc7-ac1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Sat, Jul 12, 2003 at 03:42:07PM -0500, Wes Janzen wrote:
> Thanks for the suggestions, here's what I've tried to solve the problem:
> -->Tested system memory for 4 consecutive days with memtest86
> -->Replaced SDRAM with new modules tested in every DIMM slot
> -->Tried the ac patch on 2.5.69
> -->Clocked K6-2 back to 350 from 400 (FSB still 100Mhz)
> -->Played with PCI settings in the BIOS
> -->Removed all other cards except AGP video card
> -->Disabled all other integrated peripherals in the BIOS (only serial 
> and parallel in this case).
> -->Reverted to BIOS defaults.
> 

I was using PA2013, and was having problems with IDE too.
The data corruption was solved after turning off "Spread spectrum
modulated" feature in the BIOS setup (AFAIR this misfeature is ON
by default). But I wasn't able to get on-board IDE working right
nevertheless. For some strange reason it was OK with kernel 2.2.15
but produced DMA timeouts with every later kernel version I tested.
Yes, I did try copying VIA IDE driver from 2.2.15 to later kernel,
it still didn't help. So I ended up with Promise controller too :(

:wq
                                        With best regards, 
                                           Vladimir Savkin. 

