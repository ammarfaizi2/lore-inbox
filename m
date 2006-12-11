Return-Path: <linux-kernel-owner+w=401wt.eu-S1763143AbWLKVmm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763143AbWLKVmm (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 16:42:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937052AbWLKVmm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 16:42:42 -0500
Received: from rrcs-24-153-217-226.sw.biz.rr.com ([24.153.217.226]:39539 "EHLO
	smtp.opengridcomputing.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1763142AbWLKVml (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 16:42:41 -0500
Subject: Re: 2.6.19-git3 panics on boot - ata_piix/PCI related [still in
	-git17]
From: Steve Wise <swise@opengridcomputing.com>
To: Alessandro Suardi <alessandro.suardi@gmail.com>
Cc: Alan <alan@lxorguk.ukuu.org.uk>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <5a4c581d0612110526j26a07b31q26edc075d4981cd8@mail.gmail.com>
References: <5a4c581d0612110526j26a07b31q26edc075d4981cd8@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 11 Dec 2006 15:42:42 -0600
Message-Id: <1165873362.20877.22.camel@stevo-desktop>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm also hitting this running at commit:

commit 7bf65382caeecea4ae7206138e92e732b676d6e5
Author: Andrew Morton <akpm@osdl.org>
Date:   Fri Dec 8 02:41:14 2006 -0800

I was at 2.6.19, then merged up to Linus's tree Friday 12/8 and now I
hit this. I have 2 identical systems with one difference, one has a DVD
ROM device hooked to the ATA controller.  This system displays the same
problem.  Since the other system without the DVD worked fine with the
same code, I removed the DVD from the problem system and it boots ok.
However I need the DVD, so I guess I'll start bisecting to see what
caused this. There's about 2000 commits from 2.6.19 to my head...

More to come...

Steve.



On Mon, 2006-12-11 at 14:26 +0100, Alessandro Suardi wrote:
> On 12/3/06, Alessandro Suardi <alessandro.suardi@gmail.com> wrote:
> > On 12/3/06, Alan <alan@lxorguk.ukuu.org.uk> wrote:
> > > > > ACPI: PCI Interrupt 0000:00:1f.2[B] -> Link [LNKB] -> GSI 5 (level, low) -> IRQ5
> > > > > PCI: Unable to reserve I/O region #1:8@1f0 for device 0000:00:1f.2
> > > > > ata_piix: probe of 0000:00:1f.2 failed with error -16
> > > > > [snip]
> > > > > mount: could not find filesystem '/dev/root'
> > > >
> > > > Same failure is also in 2.6.19-git4...
> > >
> > > Thats the PCI updates - you need the matching fix to libata-sff where it
> > > tries to reserve stuff it shouldn't.
> >
> > Thanks Alan. Indeed -git1 is where stuff breaks for me.
> > I'll watch out for when libata-sff gets fixed in the -git
> >  snapshots and will then report back.
> 
> Alan,
> 
>   I still have this problem in 2.6.19-git17. Is this expected behavior
>   or should it have been fixed by now ?
> 
> Thanks,
> 
> --alessandro
> 
> "...when I get it, I _get_ it"
> 
>      (Lara Eidemiller)
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

