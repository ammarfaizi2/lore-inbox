Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262278AbTICOOv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 10:14:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262260AbTICOOv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 10:14:51 -0400
Received: from as13-5-5.has.s.bonet.se ([217.215.179.23]:65209 "EHLO
	K-7.stesmi.com") by vger.kernel.org with ESMTP id S262278AbTICOOt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 10:14:49 -0400
Message-ID: <3F55F739.4010600@stesmi.com>
Date: Wed, 03 Sep 2003 16:14:17 +0200
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5b) Gecko/20030827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Vladimir Lazarenko <vlad@lazarenko.net>
CC: Stephan von Krawczynski <skraw@ithnet.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, adq_dvb@lidskialf.net,
       rl@hellgate.ch, linux-kernel@vger.kernel.org,
       acpi-devel@lists.sourceforge.net
Subject: Re: [ACPI] Where do I send APIC victims?
References: <20030903080852.GA27649@k3.hellgate.ch> <1062589205.19059.6.camel@dhcp23.swansea.linux.org.uk> <20030903145356.35b9a192.skraw@ithnet.com> <200309031504.03596.vlad@lazarenko.net>
In-Reply-To: <200309031504.03596.vlad@lazarenko.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vladimir Lazarenko wrote:
> On my board, A7V8X, ACPI/APIC works just perfectly with 2.4.22 and KT400 
> chipset, alas on A7N8X Deluxe board with nForce2 chipsets it causes nasty 
> hangups.
> Machine just simply freezes, no oops, nothing whatsoever.
> 
> Disabling APIC solved the problem.
> 
> --
> Regards,
> Vladimir
> 
> On Wednesday 03 September 2003 14:53, Stephan von Krawczynski wrote:
> 
>>On Wed, 03 Sep 2003 12:40:06 +0100
>>
>>Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>>
>>>On Mer, 2003-09-03 at 11:48, Andrew de Quincey wrote:
>>>
>>>>2.4.22 has the ACPI from 2.6 backported into it, (which includes my
>>>>patch for nforce2 boards) so it will start having the same issue with
>>>>the BIOS bug in KT333/KT400  boards.
>>>
>>>It does - 2.4.22pre7 is great on my boxes, 2.4.22 final ACPI is
>>>basically unusable on anything I own thats not intel.
>>
>>I can't back that. At least on all my Serverworks boxes there are no
>>problems with ACPI. I got reports from VIA-bases SMP boards that they are
>>doing well, too. (all for 2.4.22)

And I can say that my Soyo SY-KT600 Ultra (VIA KT600+8237) has ACPI
problems as well. pci=noacpi doesn't help but acpi=off does. It gives
lots of errors that the ACPI tables are buggy when booting claiming
my 8237 SATA controller has gotten IRQ -19 for instance.
Using acpi=off solves the problem. This is with or without the libata
VIA 8237 SATA driver. Without anything it recognizes the chip but
doesn't like using IRQ -19 and doesn't see any disks. With pci=noacpi
it sees the disks but bombs out when trying to get the partition table.
It gets IRQ -19 still there. acpi=off makes it all work.

// Stefan

