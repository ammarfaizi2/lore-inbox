Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264499AbTIDCPN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 22:15:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264517AbTIDCPN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 22:15:13 -0400
Received: from lidskialf.net ([62.3.233.115]:21707 "EHLO beyond.lidskialf.net")
	by vger.kernel.org with ESMTP id S264499AbTIDCPK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 22:15:10 -0400
From: Andrew de Quincey <adq_dvb@lidskialf.net>
To: Chris Wright <chrisw@osdl.org>, "Nakajima, Jun" <jun.nakajima@intel.com>
Subject: Re: [ACPI] Re: Fixing USB interrupt problems with ACPI enabled
Date: Thu, 4 Sep 2003 03:15:09 +0100
User-Agent: KMail/1.5.3
Cc: lkml <linux-kernel@vger.kernel.org>, acpi-devel@lists.sourceforge.net,
       linux-acpi <linux-acpi@intel.com>
References: <7F740D512C7C1046AB53446D3720017304AEEC@scsmsx402.sc.intel.com> <20030903153746.A19323@osdlab.pdx.osdl.net>
In-Reply-To: <20030903153746.A19323@osdlab.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309040315.09955.adq_dvb@lidskialf.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 03 September 2003 23:37, Chris Wright wrote:
> * Nakajima, Jun (jun.nakajima@intel.com) wrote:
> > Doing this for Len, who is on vacation. We would like to thank the
> > people who provided debugging info such as acpidmp, dmidecode, and
> > demsg. This is one of our findings, and we believe this would fix some
> > interrupt problems (with USB, for example) with ACPI enabled, especially
> > when the dmesg reads like:
> >
> > ACPI: PCI Interrupt Link [ALKA] enabled at IRQ 0
> > ACPI: PCI Interrupt Link [ALKB] enabled at IRQ 0
> > ACPI: PCI Interrupt Link [ALKC] enabled at IRQ 0
> > ACPI: PCI Interrupt Link [ALKD] enabled at IRQ 0
> >
> > Basically we assumed that _CRS returned the one we set with _SRS, when
> > setting up a PCI interrupt link device, but that's not the case with
> > some AML codes. Some of them always return 0.
> > Attached is a patch against 2.4.23-pre1. It should be easy to apply this
> > to 2.6.

Wow! This is exactly the idea I've just come up with for VIA boards!

