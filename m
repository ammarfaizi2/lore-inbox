Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264688AbTA0Xww>; Mon, 27 Jan 2003 18:52:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264690AbTA0Xww>; Mon, 27 Jan 2003 18:52:52 -0500
Received: from smtp08.iddeo.es ([62.81.186.18]:44684 "EHLO smtp08.retemail.es")
	by vger.kernel.org with ESMTP id <S264688AbTA0Xwv>;
	Mon, 27 Jan 2003 18:52:51 -0500
Date: Tue, 28 Jan 2003 01:02:08 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21-pre3 kernel crash
Message-ID: <20030128000208.GA1456@werewolf.able.es>
References: <Pine.OSF.4.51.0301271632230.49659@tao.natur.cuni.cz> <3E356403.9010805@google.com> <Pine.OSF.4.51.0301271813230.57372@tao.natur.cuni.cz> <20030127192327.GD889@suse.de> <20030127231819.GA1651@werewolf.able.es> <20030127232412.GF17791@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20030127232412.GF17791@suse.de>; from axboe@suse.de on Tue, Jan 28, 2003 at 00:24:12 +0100
X-Mailer: Balsa 2.0.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2003.01.28 Jens Axboe wrote:
> On Tue, Jan 28 2003, J.A. Magallon wrote:
[...]
> > Applied on top of 2.4.21-pre3-aa (no highmem), it makes my box hang on drive
> > detection:
> > 
> > PIIX4: IDE controller at PCI slot 00:07.1
> > PIIX4: chipset revision 1
> > PIIX4: not 100% native mode: will probe irqs later
> >     ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:DMA
> >     ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
> > hda: 
> > 
[...]
> 
> Reviewing the patch, it did have a nasty bug, didn't iterate
> buffer_heads at all so a clustered request will fail. Attached version
> should work.
> 

Thanks, it works both on a box without himem and on one with 1Gb.

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.1 (Cooker) for i586
Linux 2.4.21-pre3-jam4 (gcc 3.2.1 (Mandrake Linux 9.1 3.2.1-4mdk))
