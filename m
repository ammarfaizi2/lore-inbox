Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932515AbVHaO1q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932515AbVHaO1q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 10:27:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932516AbVHaO1p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 10:27:45 -0400
Received: from dgate1.fujitsu-siemens.com ([217.115.66.35]:60297 "EHLO
	dgate1.fujitsu-siemens.com") by vger.kernel.org with ESMTP
	id S932515AbVHaO1p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 10:27:45 -0400
X-SBRSScore: None
Message-ID: <4315BE5C.9030809@fujitsu-siemens.com>
Date: Wed, 31 Aug 2005 16:27:40 +0200
From: Martin Wilck <martin.wilck@fujitsu-siemens.com>
Organization: Fujitsu Siemens Computers
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: de, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Andi Kleen <ak@suse.de>,
       "Wichert, Gerhard" <Gerhard.Wichert@fujitsu-siemens.com>,
       macro@linux-mips.org
Subject: Re: APIC version and 8-bit APIC IDs
References: <42FC8461.2040102@fujitsu-siemens.com.suse.lists.linux.kernel> <p73pssj2xdz.fsf@verdi.suse.de> <4315AD07.2020500@fujitsu-siemens.com> <Pine.LNX.4.61L.0508311417110.10940@blysk.ds.pg.gda.pl>
In-Reply-To: <Pine.LNX.4.61L.0508311417110.10940@blysk.ds.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maciej,

> It actually depends on the APIC type, rather than the CPU.  E.g. with
> Pentium systems the width of the ID is either 4 bits or 8 bits,
> depending on whether the integrated or an external 82489DX APIC is
> used.  This should be able to be determined by the APIC version; for
> v <= 0xf the ID is 8-bit and for v >= 0x10 it used to be 4-bit.  Now
> you only need to determine what is the value of v above 0x10 that
> makes the ID 8-bit again.

That would be v>=0x14 for Intel. But that is wrong for AMD CPUs. The 
actual Dual-Core Athlon CPUs we have report an APIC version of 0x10. 
Please refer to the start of this thread.

Anyway, I understand that you agree this does not belong into the 
subarch code?

Regards
Martin

-- 
Martin Wilck                Phone: +49 5251 8 15113
Fujitsu Siemens Computers   Fax:   +49 5251 8 20409
Heinz-Nixdorf-Ring 1        mailto:Martin.Wilck@Fujitsu-Siemens.com
D-33106 Paderborn           http://www.fujitsu-siemens.com/primergy
