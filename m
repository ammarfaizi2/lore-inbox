Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267813AbTAMTZ6>; Mon, 13 Jan 2003 14:25:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267841AbTAMTZ6>; Mon, 13 Jan 2003 14:25:58 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:2749 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S267813AbTAMTZ4>;
	Mon, 13 Jan 2003 14:25:56 -0500
Date: Mon, 13 Jan 2003 11:26:10 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
cc: William Lee Irwin III <wli@holomorphy.com>,
       Christoph Hellwig <hch@infradead.org>,
       James Cleverdon <jamesclv@us.ibm.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: RE: APIC version
Message-ID: <325030000.1042485970@flay>
In-Reply-To: <3014AAAC8E0930438FD38EBF6DCEB5647D1026@fmsmsx407.fm.intel.com>
References: <3014AAAC8E0930438FD38EBF6DCEB5647D1026@fmsmsx407.fm.intel.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The entries in acpi_version[] are indexed by the APIC id, not smp_processor_id(). So you can overwrite acpi_version[] for a different processor.

>> +	apic_version[smp_processor_id()] =

Ugh.

It's indexed by the apic ID, not the cpu id. They're not 1-1.


