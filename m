Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751173AbVHLNVE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751173AbVHLNVE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 09:21:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751175AbVHLNVE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 09:21:04 -0400
Received: from dgate1.fujitsu-siemens.com ([217.115.66.35]:14149 "EHLO
	dgate1.fujitsu-siemens.com") by vger.kernel.org with ESMTP
	id S1751173AbVHLNVC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 09:21:02 -0400
X-SBRSScore: None
X-IronPort-AV: i="3.96,103,1122847200"; 
   d="scan'208"; a="13997555:sNHT27586180"
Message-ID: <42FCA23C.7040601@fujitsu-siemens.com>
Date: Fri, 12 Aug 2005 15:21:00 +0200
From: Martin Wilck <martin.wilck@fujitsu-siemens.com>
Organization: Fujitsu Siemens Computers
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: de, en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: APIC version and 8-bit APIC IDs
References: <42FC8461.2040102@fujitsu-siemens.com.suse.lists.linux.kernel> <p73pssj2xdz.fsf@verdi.suse.de>
In-Reply-To: <p73pssj2xdz.fsf@verdi.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:

> Yes, it's broken. In fact I removed it in my physflat32 patch
> which is needed for 16 core AMD systems. I don't think there
> is a generic way to fix it because the XAPIC check breaks
> on AMD systems 

on the Intel Xeon MP systems, too,

> and there is no good way to decide early 
> on subarchitectures before doing this check. Also it's only
> a sanity check for broken BIOS, and in this case it causes more problems
> than it solves.

agreed.

> ftp://ftp.firstfloor.org/pub/ak/x86_64/x86_64-2.6.13rc3-1/patches/physflat32

That is a beautiful patch, thank you.

Only one small point: I wonder whether it is correct to use the number 
of CPUs as criterion for this architecture. AFAICS, the Specs allow
having only 4 CPUS, but giving them APIC IDs e.g. 16,17,18,19. In this 
case, physflat32 should be used as well (in particular, the APIC ID 
broadcast and mask must be set to 0xff).

> Will hopefully be fixed in 2.6.14.

Great,

Martin

-- 
Martin Wilck                Phone: +49 5251 8 15113
Fujitsu Siemens Computers   Fax:   +49 5251 8 20409
Heinz-Nixdorf-Ring 1        mailto:Martin.Wilck@Fujitsu-Siemens.com
D-33106 Paderborn           http://www.fujitsu-siemens.com/primergy
