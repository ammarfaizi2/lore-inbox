Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289727AbSAOW5r>; Tue, 15 Jan 2002 17:57:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289728AbSAOW5j>; Tue, 15 Jan 2002 17:57:39 -0500
Received: from gw.wmich.edu ([141.218.1.100]:49860 "EHLO gw.wmich.edu")
	by vger.kernel.org with ESMTP id <S289727AbSAOW5Z>;
	Tue, 15 Jan 2002 17:57:25 -0500
Message-ID: <000f01c19e18$469a3700$0501a8c0@psuedogod>
From: "Ed Sweetman" <ed.sweetman@wmich.edu>
To: "Nicholas Lee" <nj.lee@plumtree.co.nz>,
        "Ville Herva" <vherva@niksula.hut.fi>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <20020115202302.GA598@inktiger.kiwa.co.nz> <20020115205116.GH51648@niksula.cs.hut.fi> <20020115211032.GC598@inktiger.kiwa.co.nz> <20020115214049.GI51648@niksula.cs.hut.fi> <20020115220211.GE598@inktiger.kiwa.co.nz>
Subject: Re: Disk corruption - Abit KT7, 2.2.19+ide patches
Date: Tue, 15 Jan 2002 17:59:19 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Tue, Jan 15, 2002 at 11:40:49PM +0200, Ville Herva wrote:
> >
> > Hmm, do the pci ids map somehow to physical pci slots? It seems one
>
> Im not sure. Someone in the mailing list should know though. 8)
>
> > particular physical pci slot location is troublesome in our case. It
caused
> > problems with nic and even with a scsi adapter. Unfortunately I can't
> > remember which slot it was - I'll have to check (I _think_ it was the
third
> > counting from bottom).
> >
> > So I'm interested in the physical location of you nic...
>
> Ok. I can't check the machine in Wellington, but in the machine here.
> Not couting the AGP slot, the NIC is sitting in the third slot in the
> back of the box.
>
>
> I'd have to open it (later today when the office is closed) to comfirm
> its sitting in the 'third' PCI slot from the CPU.
>
> The NIC is the only PCI card in this machines. The video card being a
> basic AGP one. (This is the other difference with the machine in
> Wellington which has an old but expensive PCI video card.)
>
>
> The problem with moving the card, is that the problem exhibits very
> slowly. After the previous problems with the Seagate drive reseting and
> the computer finally crashing majorly I replaced the drive and
> everything seemed fine.
>
> Only now have I notice the problems.
>

sounds like you're using the shared irq slot, might want to verify that with
lspci -vvv to see if anything else is using an irq at the time that's the
same as the card in that slot.  Also some places will do various special
things to one of the last pci slots, you should be able to find out by
looking in the manual.  Some cards just dont play nicely with shared irqs.

Then there's always the locality to some other device in the case possibly
causing your problem.   many reasons could cause the problem you're
describing.   I'm not really sure how this is a linux problem though since
you mention it's occuring only in a certain physical slot.

