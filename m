Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265683AbUBJHXa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 02:23:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265695AbUBJHXa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 02:23:30 -0500
Received: from fmr04.intel.com ([143.183.121.6]:52644 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S265683AbUBJHX0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 02:23:26 -0500
Subject: Re: HT CPU handling - 2.6.2
From: Len Brown <len.brown@intel.com>
To: Hod McWuff <hod@wuff.dhs.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1076395641.2246.5.camel@siberian.wuff.dhs.org>
References: <BF1FE1855350A0479097B3A0D2A80EE0023E8B98@hdsmsx402.hd.intel.com>
	 <1076391435.4103.730.camel@dhcppc4>
	 <1076395641.2246.5.camel@siberian.wuff.dhs.org>
Content-Type: text/plain
Organization: 
Message-Id: <1076397803.4105.900.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 10 Feb 2004 02:23:23 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

no.  the disabled flag is a reflection of wires inside the processor. 
You could pop the cap and ion-beam edit the die, or buy an HT-enabled
processor.  The later would be somewhat more cost effective;-)

cheers,
-Len

On Tue, 2004-02-10 at 01:47, Hod McWuff wrote:
> OK, the BIOS setting is disabled and cannot be changed, so the message
> won't get cleaned up that way. I could of course disable SMP in my
> kernel, but that really doesn't address anything.
> 
> What I'm wondering is, if the second "CPU" appears to exist but is
> merely marked disabled, who cares about the BIOS flag? Why couldn't the
> disable flag be cleared or ignored?
> 
> Couldn't the ACPI/APIC/SMP code just cope with the odd LAPIC ID somehow?
> 
> On Tue, 2004-02-10 at 00:37, Len Brown wrote:
> > Your BIOS is reporting the 2nd CPU as disabled, and telling us that it
> > has LAPIC id 0x81 = 129.  The ACPI table code prints this out and
> > registers the processor anyway, but that chokes because the LAPIC ID is
> > way out of bounds.
> > 
> > I'm thinking that ACPI should not register a processor that the BIOS
> > marked as disabled...
> > 
> > What should you do?  Apparently you've got an HT-enabled platform, BIOS,
> > and OS, but do not have an HT-enabled processor.  Your choices are to
> > disable HT in the BIOS SETUP to clean up this message, or plug in an
> > HT-enabled processor.
> > 
> > cheers,
> > -Len
> > 
> > On Mon, 2004-02-09 at 15:44, Hod McWuff wrote:
> > > I've got a 2.0A GHz P4, advertised as non-hyperthread, that seems to
> > > be
> > > reporting the presence of a second CPU. It also seems to be disabled
> > > by
> > > setting bit 7 of its ID. I've tried compiling with support for 130
> > > CPU's
> > > and nothing changed. What would have to be done to get this disabled
> > > CPU half back online?
> > > 
> > > Feb  9 04:45:03 pug ACPI: Local APIC address 0xfee00000
> > > Feb  9 04:45:03 pug ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
> > > Feb  9 04:45:03 pug Processor #0 15:2 APIC version 20
> > > Feb  9 04:45:03 pug ACPI: LAPIC (acpi_id[0x02] lapic_id[0x81]
> > > disabled)
> > > Feb  9 04:45:03 pug Processor #129 invalid (max 16)
> > > Feb  9 04:45:03 pug ACPI: LAPIC_NMI (acpi_id[0x01] dfl dfl lint[0x1])
> > > Feb  9 04:45:03 pug ACPI: LAPIC_NMI (acpi_id[0x02] dfl dfl lint[0x1])
> > > 
> > > -
> > > To unsubscribe from this list: send the line "unsubscribe
> > > linux-kernel" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > Please read the FAQ at  http://www.tux.org/lkml/
> > > 
> > > 
> > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/

