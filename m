Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261650AbVAXVDZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261650AbVAXVDZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 16:03:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261654AbVAXVCo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 16:02:44 -0500
Received: from rproxy.gmail.com ([64.233.170.206]:13679 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261650AbVAXU4w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 15:56:52 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=tScBHukNrXdJLK6i8OtYEqn4NpaftnOWhSBKSeU/jiAJPn4sS4OnnEI+Wj9BLTA/xQF6E4Q4E9sloBgrCt8XUSmPbEOU+zjykvT9zpukoDxl5pjd8Zxnsm+Gv4thDhe/tGjqBsA/58+w2lZQsJrs8UuBNUSCf9e+6zsV7C2vHZg=
Message-ID: <5a4c581d0501241256608d3d1a@mail.gmail.com>
Date: Mon, 24 Jan 2005 21:56:48 +0100
From: Alessandro Suardi <alessandro.suardi@gmail.com>
Reply-To: Alessandro Suardi <alessandro.suardi@gmail.com>
To: Jens Axboe <axboe@suse.de>
Subject: Re: DVD burning still have problems
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Volker Armin Hemmann <volker.armin.hemmann@tu-clausthal.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050124204529.GA19242@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <200501232126.55191.volker.armin.hemmann@tu-clausthal.de>
	 <5a4c581d050123125967a65cd7@mail.gmail.com>
	 <20050124150755.GH2707@suse.de>
	 <1106594023.6154.89.camel@localhost.localdomain>
	 <20050124204529.GA19242@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jan 2005 21:45:29 +0100, Jens Axboe <axboe@suse.de> wrote:
> On Mon, Jan 24 2005, Alan Cox wrote:
> > On Llu, 2005-01-24 at 15:07, Jens Axboe wrote:
> > > >  794034176/4572807168 (17.4%) @2.4x, remaining 18:47
> > > >  805339136/4572807168 (17.6%) @2.4x, remaining 18:42
> > > > :-[ WRITE@LBA=60eb0h failed with SK=3h/ASC=0Ch/ACQ=00h]: Input/output error
> > > > builtin_dd: 396976*2KB out @ average 2.4x1385KBps
> > > > :-( write failed: Input/output error
> > >
> > > As with the original report, the drive is sending back a write error to
> > > the issuer. Looks like bad media.
> >
> > I've got several reports like this that only happen with ACPI, and one
> > user whose burns report fine but are corrupted if ACPI is allowed to do
> > power manglement.
> 
> Really weird, I cannot begin to explain that. Perhaps the two reporters
> in this thread can try it as well?
> 

...my K7-800 is so old that the FC3 kernel disables ACPI itself:

Linux version 2.6.10-1.737_FC3 (bhcompile@porky.build.redhat.com) (gcc
version 3.4.2 20041017 (Red Hat 3.4.2-6.fc3)) #1 Mon Jan 10 13:50:10
EST 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000ec000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fff0000 (usable)
 BIOS-e820: 000000000fff0000 - 000000000fff8000 (ACPI data)
 BIOS-e820: 000000000fff8000 - 0000000010000000 (ACPI NVS)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
255MB LOWMEM available.
On node 0 totalpages: 65520
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 61424 pages, LIFO batch:14
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 AMI                                   ) @ 0x000fa9e0
ACPI: RSDT (v001 AMIINT          0x00000010 MSFT 0x00000097) @ 0x0fff0000
ACPI: FADT (v001 AMIINT          0x00000010 MSFT 0x00000097) @ 0x0fff0030
ACPI: DSDT (v001    VIA   VT8371 0x00001000 MSFT 0x0100000b) @ 0x00000000
ACPI: BIOS age (1997) fails cutoff (2001), acpi=force is required to enable ACPI
ACPI: Disabling ACPI support

But as it stands I'll sacrifice my 11+ days uptime for a -latest
 build from kernel.org and try compiling ACPI out :)

--alessandro
 
 "And every dream, every, is just a dream after all"
  
    (Heather Nova, "Paper Cup")
