Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751647AbWJTBIe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751647AbWJTBIe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 21:08:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751650AbWJTBIe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 21:08:34 -0400
Received: from hqemgate01.nvidia.com ([216.228.112.170]:36891 "EHLO
	HQEMGATE01.nvidia.com") by vger.kernel.org with ESMTP
	id S1751646AbWJTBIe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 21:08:34 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: ASUS M2NPV-VM APIC/ACPI Bug (patched)
Date: Thu, 19 Oct 2006 18:08:12 -0700
Message-ID: <DBFABB80F7FD3143A911F9E6CFD477B00E48D31D@hqemmail02.nvidia.com>
In-Reply-To: <200610191811.49243.ak@suse.de>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: ASUS M2NPV-VM APIC/ACPI Bug (patched)
Thread-Index: AcbzmWFuydwrL0O9Q4GgTEdN8JYVfQASLz2Q
From: "Allen Martin" <AMartin@nvidia.com>
To: "Andi Kleen" <ak@suse.de>
Cc: "Robert Hancock" <hancockr@shaw.ca>, "Len Brown" <lenb@kernel.org>,
       "linux-kernel" <linux-kernel@vger.kernel.org>,
       "Daniel Mierswa" <impulze@impulze.org>,
       "Andy Currid" <ACurrid@nvidia.com>
X-OriginalArrivalTime: 20 Oct 2006 01:08:12.0327 (UTC) FILETIME=[36BFCB70:01C6F3E4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Ah my understanding was that it applied to NF3 and possible 
> NF4 too. Does it 
> not?
>  
> > I believe the HPET check was because the workaround was 
> causing problems
> > when enabling HPET on systems that support it.  Andy 
> probably has more
> > details on that.
> 
> Yes it was because NF5 needed it to be disabled. Anyways if I can 
> get a list of PCI-IDs of chipsets where the reference BIOS had this
> issue it can be narrowed to those.

Well that's the problem.  The issue only existed in the nForce2
reference BIOS (and maybe early in nForce3) but we still occasionally
see shipping customer BIOSes to this day that have this same bug for
nForce5 (like M2NPV referenced in this thread).

Probably what ASUS is doing in the M2NPV BIOS is copying the ACPI tables
from an earlier nForce2 product.

Probably what needs to happen is to make the HPET check more robust and
only return 1 if HPET is present and enabled.
-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
