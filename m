Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964847AbWCPTFO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964847AbWCPTFO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 14:05:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932707AbWCPTFN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 14:05:13 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:62947 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932706AbWCPTFM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 14:05:12 -0500
Date: Thu, 16 Mar 2006 20:04:28 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Christoph Hellwig <hch@infradead.org>
cc: Zachary Amsden <zach@vmware.com>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       Xen-devel <xen-devel@lists.xensource.com>,
       Andrew Morton <akpm@osdl.org>, Dan Hecht <dhecht@vmware.com>,
       Dan Arai <arai@vmware.com>, Anne Holler <anne@vmware.com>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>, Joshua LeVasseur <jtl@ira.uka.de>,
       Chris Wright <chrisw@osdl.org>, Rik Van Riel <riel@redhat.com>,
       Jyothy Reddy <jreddy@vmware.com>, Jack Lo <jlo@vmware.com>,
       Kip Macy <kmacy@fsmware.com>, Jan Beulich <jbeulich@novell.com>,
       Ky Srinivasan <ksrinivasan@novell.com>,
       Wim Coekaerts <wim.coekaerts@oracle.com>,
       Leendert van Doorn <leendert@watson.ibm.com>
Subject: Re: [RFC, PATCH 2/24] i386 Vmi config
In-Reply-To: <20060314152350.GB16921@infradead.org>
Message-ID: <Pine.LNX.4.61.0603161959510.11776@yvahk01.tjqt.qr>
References: <200603131800.k2DI0RfN005633@zach-dev.vmware.com>
 <20060314152350.GB16921@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> Introduce the basic VMI sub-arch configuration dependencies.  VMI
>> kernels only are designed to run on modern hardware platforms.  As
>> such, they require a working APIC, and do not support some legacy
>> functionality, including APM BIOS, ISA and MCA bus systems, PCI BIOS
>> interfaces, or PnP BIOS (by implication of dropping ISA support). 
>> They also require a P6 series CPU.
>

Maybe I'm mixing things, but if VMware is capable of running on a i586
(=P5?) (like AMD K6 - and it certainly is capable of doing that),
should not VMI be similar?

For example, the TM5800 CPU which is somewhat of a mixture between i586
and i686 but does not have an IOAPIC can run VMware machines (although
painfully slow).

And, the last thing, distributor kernels are often compiled for i586 to
be generic to all users. But some users may actually run them on i686,
and these users would like to have VMI (speculation :-). Which would
include a forceful patch to Kconfig to have the VMI option available
with CONFIG_M586.

>That's pretty bad because distributors need another kernel still.  At least
>a working APIC isn't quite as common today as it should.


Jan Engelhardt
-- 
