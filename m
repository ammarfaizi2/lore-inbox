Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264106AbUDVPEd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264106AbUDVPEd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 11:04:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264099AbUDVPEc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 11:04:32 -0400
Received: from fmr11.intel.com ([192.55.52.31]:16098 "EHLO
	fmsfmr004.fm.intel.com") by vger.kernel.org with ESMTP
	id S264097AbUDVPEZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 11:04:25 -0400
Subject: Re: IO-APIC on nforce2 [PATCH] + [PATCH] for nmi_debug=1 + [PATCH]
	for idle=C1halt, 2.6.5
From: Len Brown <len.brown@intel.com>
To: Craig Bradney <cbradney@zip.com.au>
Cc: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>, ross@datscreative.com.au,
       christian.kroener@tu-harburg.de, linux-kernel@vger.kernel.org,
       "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
       Jamie Lokier <jamie@shareable.org>, Daniel Drake <dan@reactivated.net>,
       Ian Kumlien <pomac@vapor.com>, Jesse Allen <the3dfxdude@hotmail.com>,
       a.verweij@student.tudelft.nl, Allen Martin <AMartin@nvidia.com>
In-Reply-To: <1082623508.10528.7.camel@amilo.bradney.info>
References: <200404131117.31306.ross@datscreative.com.au>
	 <200404131703.09572.ross@datscreative.com.au>
	 <1081893978.2251.653.camel@dhcppc4>
	 <200404160110.37573.ross@datscreative.com.au>
	 <1082060255.24425.180.camel@dhcppc4>
	 <1082063090.4814.20.camel@amilo.bradney.info>
	 <1082578957.16334.13.camel@dhcppc4>  <4086E76E.3010608@gmx.de>
	 <1082587298.16336.138.camel@dhcppc4>
	 <1082623508.10528.7.camel@amilo.bradney.info>
Content-Type: text/plain
Organization: 
Message-Id: <1082646181.16333.217.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 22 Apr 2004 11:03:01 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-04-22 at 04:45, Craig Bradney wrote:

> > Yes, you need to enable ACPI and IOAPIC.  The goal of this patch
> > is to address the XT-PIC timer issue in IOAPIC mode.
> > 
> > Here's the latest (vs 2.6.5).
> 
> 
> Do we need any other patch? eg the idlec1halt patch? My Athlon still has
> 2.6.3 on it.

If you needed idlec1halt before, you still need it.
This patch just addresses the XT-PIC timer issue.

> 
> > I've got 1 Abit, 2 Asus, and 1 Shuttle DMI entry.  Let me know if the
> > product names (1st line of dmidecode entry) are correct,
> > these are not from DMI, but are supposed to be human-readable titles.
> 
> + { ignore_timer_override, "Asus A7N8X v2", { 
> > +			MATCH(DMI_BOARD_VENDOR, "ASUSTeK Computer INC."),
> > +			MATCH(DMI_BOARD_NAME, "A7N8X2.0"),
> > +			MATCH(DMI_BIOS_VERSION, "ASUS A7N8X2.0 Deluxe ACPI BIOS Rev 1007"),
> > +			MATCH(DMI_BIOS_DATE, "10/06/2003") }},
> 
> my dmidecode output also shows (in the first BIOS information section):
> Vendor: Phoenix Technologies, LTD
> although the Manufacturer is ASUSTek Computer INC. form the Base Board
> and System sections.

Right, DMI has separate sections for System, Board, BIOS, and we're
using two pieces from the BOARD and two pieces from the BIOS sections.

> Not really sure about the code. If it matches on all of above then it
> might not work. Ill try a new kernel later today and see the result.

The workaround is triggered only if all the MATCH()'s above match.
If it doesn't trigger, then either I munged it on copy out of dmidecode
or you've got a different BIOS and we need a new dmidecode...

> > I'm interested only in the latest BIOS -- if it is still broken.
> > The assumption is that if a fixed BIOS is available, the users
> > should upgrade.
> > 
> 
> Yes, I just checked yesterday and there was nothing new.

thanks,
-Len


