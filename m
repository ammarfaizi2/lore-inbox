Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263298AbTFYAOu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 20:14:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263315AbTFYAOu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 20:14:50 -0400
Received: from smtp.netcabo.pt ([212.113.174.9]:25725 "EHLO smtp.netcabo.pt")
	by vger.kernel.org with ESMTP id S263298AbTFYAOr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 20:14:47 -0400
Subject: Re: [ACPI] MS-6368L ACPI IRQ problem still in 2.4.21
From: =?ISO-8859-1?Q?S=E9rgio?= Monteiro Basto <sergiomb@netcabo.pt>
To: Marek Michalkiewicz <marekm@amelek.gda.pl>
Cc: linux-kernel@vger.kernel.org,
       acpi-devel <acpi-devel@lists.sourceforge.net>
In-Reply-To: <20030624221809.GA1805@alf.amelek.gda.pl>
References: <20030623221541.GA8096@alf.amelek.gda.pl>
	<20030623222311.GD25982@parcelfarce.linux.theplanet.co.uk>
	<20030624054612.GA20235@alf.amelek.gda.pl>
	<20030624112630.GB451@parcelfarce.linux.theplanet.co.uk> 
	<20030624221809.GA1805@alf.amelek.gda.pl>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9.7x.1) 
Date: 25 Jun 2003 01:28:31 +0100
Message-Id: <1056500914.2005.47.camel@darkstar.portugal>
Mime-Version: 1.0
X-OriginalArrivalTime: 25 Jun 2003 00:25:53.0578 (UTC) FILETIME=[5676B0A0:01C33AB0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi(gh)!
So, has we can see in your dmesg, you don't test new acpi,
you are report problems from old acpi.
Well, can you send the /var/log/dmesg for ACPI: Core Subsystem version
200306...
you can try to see if DSDT has problems,without stop your production.

Get last iasl (ACPI CA - Unix Build Environment )in
http://developer.intel.com/technology/iapc/acpi/downloads.htm
 cd compiler;make
after this
cat /proc/acpi/dsdt > acpi_dsdt.dat
./iasl  -d acpi_dsdt.dat
./iasl -tc acpi_dsdt.dsl

and see your dsdt in bios are ok or not.

On Tue, 2003-06-24 at 23:18, Marek Michalkiewicz wrote:
> On Tue, Jun 24, 2003 at 12:26:30PM +0100, Matthew Wilcox wrote:
> > The ACPI code in 2.4.21 is something like 18 months old now.  It's
> > basically unmaintainable.  Fortunately, 2.4.22 should have an ACPI update.
> 

> ACPI: Core Subsystem version [20011018]
			        ^^^^^^^^
> ACPI: Subsystem enabled
> ACPI: System firmware supports S0 S1 S4 S5
> Processor[0]: C0 C1 C2
> ACPI: Power Button (FF) found
> ACPI: Multiple power buttons detected, ignoring fixed-feature
> ACPI: Power Button (CM) found
> ACPI: Sleep Button (CM) found
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by: INetU
> Attention Web Developers & Consultants: Become An INetU Hosting Partner.
> Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
> INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
-- 
SérgioMB
email: sergiomb@netcabo.pt

Who gives me one shell, give me everything.

