Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261471AbTCTRAg>; Thu, 20 Mar 2003 12:00:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261376AbTCTRAg>; Thu, 20 Mar 2003 12:00:36 -0500
Received: from fmr01.intel.com ([192.55.52.18]:52188 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S261471AbTCTRAd>;
	Thu, 20 Mar 2003 12:00:33 -0500
Message-ID: <F760B14C9561B941B89469F59BA3A847E96D2E@orsmsx401.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: James Wright <james@jigsawdezign.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: RE: P4 3.06Ghz Hyperthreading with 2.4.20?
Date: Thu, 20 Mar 2003 09:11:10 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
content-class: urn:content-classes:message
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: James Wright [mailto:james@jigsawdezign.com] 
>    So i can apply the ACPI patch to 2.4.20, and it will work, 
> even though my motherboard BIOS
> doesn't provide the MPS table?

Yes, because ACPI uses a different table.

> Do i still need to use 
> "acpismp=force" option?

Nope.

> What do you mean
> by *configuring* acpi

Configuring it into your kernel, presumably, using make menuconfig.

> do i need the "acpid" or other 
> resources, than just enabling it?

Nope, all the SMP detection stuff is in the kernel.

Regards -- Andy

> 
> Thanks,
> James
> 
> 
> On Wed, 19 Mar 2003 18:50:59 -0800
> "Nakajima, Jun" <jun.nakajima@intel.com> wrote:
> 
> > You need to apply the ACPI patch: 
> http://sourceforge.net/projects/acpi and *configure* APIC. 
> > 
> > The 2.4 kernel depends on the MPS table for all but logical 
> processors. If MPS table is not present, it will fall back to UP.
> > 
> > Thanks,
> > Jun
> > 
> > > -----Original Message-----
> > > From: James Wright [mailto:james@jigsawdezign.com]
> > > Sent: Wednesday, March 19, 2003 5:34 PM
> > > To: linux-kernel@vger.kernel.org
> > > Subject: P4 3.06Ghz Hyperthreading with 2.4.20?
> > > 
> > > Hello,
> > > 
> > >    I have kernel 2.4.20 with a single P4 3.06Ghz CPU and 
> Asus P4G8X
> > > motherboard
> > > (with the Intel E7205) Chipset. I have enabled 
> Hyperthreading in the BIOS
> > > options,
> > > compiled in SMP & ACPI support, and also tried adding 
> "acpismp=force" to
> > > my lilo
> > > kernel cmdline, but it just doesn't seem to detect the 
> second Logical CPU.
> > > My
> > > current theory is that this is bcos Linux expects the 
> motherboard to be an
> > > SMP
> > > item (as with the Xeon boards) but this board is a Single 
> processor board,
> > > ansd
> > > doesn't have an MP table, but the cpu info is held in the 
> ACPI tables.?!?
> > > 
> > > I have tried installing 2.5.65 but can't get past the 
> compile due to
> > > compile-time
> > > errors... Is this a known problem? SHall i just disable 
> Hyperthreading
> > > until a new
> > > kernel release?
> > > 
> > > 
> > > Thanks,
> > > James
> > > 
> > > 
> > > 
> > > -
> > > To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > Please read the FAQ at  http://www.tux.org/lkml/
> > -
> > To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> > 
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
