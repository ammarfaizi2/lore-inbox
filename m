Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263645AbTLAQdt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 11:33:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263660AbTLAQdt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 11:33:49 -0500
Received: from fmr99.intel.com ([192.55.52.32]:42454 "EHLO
	hermes-pilot.fm.intel.com") by vger.kernel.org with ESMTP
	id S263645AbTLAQdr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 11:33:47 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: Problem Report 2.4.23 ACPI and ASUS TRL-DLS
Date: Mon, 1 Dec 2003 11:33:43 -0500
Message-ID: <BF1FE1855350A0479097B3A0D2A80EE0CC8881@hdsmsx402.hd.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Problem Report 2.4.23 ACPI and ASUS TRL-DLS
Thread-Index: AcO4Jb8VdTyGRsCTTD6EaA1aOA0ewQAALuMQ
From: "Brown, Len" <len.brown@intel.com>
To: "Stephan von Krawczynski" <skraw@ithnet.com>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 01 Dec 2003 16:33:44.0663 (UTC) FILETIME=[E3354E70:01C3B828]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephan,
Looks like this is ACPI specific and applies to all releases.

Please file an ACPI bug with the details below so we can get to the
bottom of it.

Thanks,
-Len

How to file a bug against ACPI:

http://bugzilla.kernel.org/
Category: Power Management
Component: ACPI

Please attach /proc/interrupts and the dmesg output showing the failure,
if possible;
And the same for the success case (pci=noacpi).

Please attach the output from lspci -v

Please attach the output from acpidmp, available in /usr/sbin/, or in
here
http://www.intel.com/technology/iapc/acpi/downloads/pmtools-20010730.tar
.gz

Please attach the output from dmidecode, available in /usr/sbin/, or
here: 
http://www.nongnu.org/dmidecode/

> -----Original Message-----
> From: Stephan von Krawczynski [mailto:skraw@ithnet.com] 
> Sent: Monday, December 01, 2003 11:11 AM
> To: Brown, Len
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: Problem Report 2.4.23 ACPI and ASUS TRL-DLS
> 
> 
> On 30 Nov 2003 03:45:48 -0500
> Len Brown <len.brown@intel.com> wrote:
> 
> > On Sat, 2003-11-29 at 12:10, Stephan von Krawczynski wrote:
> > > Hello,
> > > 
> > > I just found out that enabling ACPI (kernel 2.4.23) on an 
> ASUS TRL-DLS
> > > board
> > > leads to a failing boot, caused by not configuring the 
> onboard scsi
> > > aic
> > > interfaces. In fact they are simply gone from the pci list (no
> > > kidding).
> > > Disabling ACPI leads to a perfectly working box with:
> > 
> > Did earlier 2.4 or 2.6 kernels with ACPI configured work properly on
> > this box?
> 
> Hello Len,
> 
> sorry for delayed answer.
> Actually I never tried 2.6 on this box. Regarding earlier 2.4 
> I can only tell
> you that SuSE 9.0 kernel (some patched 
> 2.4.21-whoeverdidwhatever) does not boot
> either with acpi-enabled.
> 
> > Does the failing kernel do any better if you tell it to boot with
> > "pci=noacpi"
> 
> Yes, works.
> 
> > or "noapic"?
> 
> No, does not work.
> 
> Hope that helps.
> 
> Regards,
> Stephan
> 
