Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263107AbUDVEBL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263107AbUDVEBL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 00:01:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263183AbUDVEBL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 00:01:11 -0400
Received: from fmr01.intel.com ([192.55.52.18]:43239 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id S263107AbUDVEBH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 00:01:07 -0400
Subject: Re: IO-APIC on nforce2 [PATCH]
From: Len Brown <len.brown@intel.com>
To: Jamie Lokier <jamie@shareable.org>
Cc: Allen Martin <AMartin@nvidia.com>, ross@datscreative.com.au,
       Christian =?ISO-8859-1?Q?Kr=F6ner?= 
	<christian.kroener@tu-harburg.de>,
       Linux-Nforce-Bugs <Linux-Nforce-Bugs@exchange.nvidia.com>,
       linux-kernel@vger.kernel.org, "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
In-Reply-To: <20040416082730.GB22226@mail.shareable.org>
References: <DCB9B7AA2CAB7F418919D7B59EE45BAF49FB9D@mail-sc-6-bk.nvidia.com>
	 <1082058625.24423.161.camel@dhcppc4>
	 <20040416082730.GB22226@mail.shareable.org>
Content-Type: text/plain
Organization: 
Message-Id: <1082606439.16333.188.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 22 Apr 2004 00:00:39 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-04-16 at 04:27, Jamie Lokier wrote:
> Len Brown wrote:
> > As we expected, an automatic workaround based on chip-set would
> > fail because some BIOS's are fixed and some are not.
> 
> Does the workaround actually fail with the fixed BIOSes?

A fixed BIOS will not have a bogus IRQ2->pin-2 mapping,
so the acpi_skip_timer_override workaround would not
find an entry to ignore, and would become a NOP.

So if
1. all nforce2 chipsets have timer connected to pin0
2. we can safely discover we're on nforce2 early enough,
   like andi did on x86_64

then we could apply the workaround automatically always
w/o any harm.

-Len


