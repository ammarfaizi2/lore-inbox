Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261441AbTCTN0Q>; Thu, 20 Mar 2003 08:26:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261443AbTCTN0P>; Thu, 20 Mar 2003 08:26:15 -0500
Received: from loki.a-q.co.uk ([195.224.50.15]:7941 "EHLO loki.a-q.co.uk")
	by vger.kernel.org with ESMTP id <S261441AbTCTN0O>;
	Thu, 20 Mar 2003 08:26:14 -0500
Date: Thu, 20 Mar 2003 13:37:12 +0000
From: James Wright <james@jigsawdezign.com>
To: "Nakajima, Jun" <jun.nakajima@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: P4 3.06Ghz Hyperthreading with 2.4.20?
Message-Id: <20030320133712.468930bd.james@jigsawdezign.com>
In-Reply-To: <3014AAAC8E0930438FD38EBF6DCEB564013393B6@fmsmsx407.fm.intel.com>
References: <3014AAAC8E0930438FD38EBF6DCEB564013393B6@fmsmsx407.fm.intel.com>
Organization: Jigsaw Dezign
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


   So i can apply the ACPI patch to 2.4.20, and it will work, even though my motherboard BIOS
doesn't provide the MPS table? Do i still need to use "acpismp=force" option? What do you mean
by *configuring* acpi, do i need the "acpid" or other resources, than just enabling it?

Thanks,
James


On Wed, 19 Mar 2003 18:50:59 -0800
"Nakajima, Jun" <jun.nakajima@intel.com> wrote:

> You need to apply the ACPI patch: http://sourceforge.net/projects/acpi and *configure* APIC. 
> 
> The 2.4 kernel depends on the MPS table for all but logical processors. If MPS table is not present, it will fall back to UP.
> 
> Thanks,
> Jun
> 
> > -----Original Message-----
> > From: James Wright [mailto:james@jigsawdezign.com]
> > Sent: Wednesday, March 19, 2003 5:34 PM
> > To: linux-kernel@vger.kernel.org
> > Subject: P4 3.06Ghz Hyperthreading with 2.4.20?
> > 
> > Hello,
> > 
> >    I have kernel 2.4.20 with a single P4 3.06Ghz CPU and Asus P4G8X
> > motherboard
> > (with the Intel E7205) Chipset. I have enabled Hyperthreading in the BIOS
> > options,
> > compiled in SMP & ACPI support, and also tried adding "acpismp=force" to
> > my lilo
> > kernel cmdline, but it just doesn't seem to detect the second Logical CPU.
> > My
> > current theory is that this is bcos Linux expects the motherboard to be an
> > SMP
> > item (as with the Xeon boards) but this board is a Single processor board,
> > ansd
> > doesn't have an MP table, but the cpu info is held in the ACPI tables.?!?
> > 
> > I have tried installing 2.5.65 but can't get past the compile due to
> > compile-time
> > errors... Is this a known problem? SHall i just disable Hyperthreading
> > until a new
> > kernel release?
> > 
> > 
> > Thanks,
> > James
> > 
> > 
> > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
