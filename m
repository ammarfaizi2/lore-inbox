Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261277AbVEFTgw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261277AbVEFTgw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 15:36:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261278AbVEFTgw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 15:36:52 -0400
Received: from usbb-lacimss1.unisys.com ([192.63.108.51]:7945 "EHLO
	usbb-lacimss1.unisys.com") by vger.kernel.org with ESMTP
	id S261277AbVEFTgv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 15:36:51 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [patch 1/1] Do not enforce unique IO_APIC_ID for Xeonprocessors in EM64T mode (x86_64)
Date: Fri, 6 May 2005 13:29:59 -0500
Message-ID: <19D0D50E9B1D0A40A9F0323DBFA04ACCE04B4C@USRV-EXCH4.na.uis.unisys.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch 1/1] Do not enforce unique IO_APIC_ID for Xeonprocessors in EM64T mode (x86_64)
Thread-Index: AcVSZpu1wymjqJK4QlegO/rHTQff/AAAok8Q
From: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: "Len Brown" <len.brown@intel.com>, "Andrew Morton" <akpm@osdl.org>,
       "Andi Kleen" <ak@suse.de>, "Zwane Mwaikambo" <zwane@arm.linux.org.uk>,
       "Venkatesh Pallipadi" <venkatesh.pallipadi@intel.com>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 06 May 2005 18:30:00.0171 (UTC) FILETIME=[9C90DBB0:01C55269]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Would the APIC version be a good criteria to make a 
> run-time decision 
> > with Xeons? I know that everything Intel that can run EM64T 
> has front 
> > side bus (APIC version >= 20?). And I guess the boot parameter can 
> > still be useful?
> 
>  Isn't there a bit in one of the I/O APIC registers which 
> denotes that FSB delivery is used?  Hmm, that would be 
> "IO_APIC_reg_00.bits.delivery_type",
> actually...

Perhaps, I will try just set it up unconditionally for Intel as Zwane
suggested, somewhere in (early_)identify_cpu() and will resend the
patch.

Thanks,
--Natalie
