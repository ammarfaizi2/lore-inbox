Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264477AbTIDCbk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 22:31:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264479AbTIDCbk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 22:31:40 -0400
Received: from k-kdom.nishanet.com ([65.125.12.2]:28168 "EHLO
	mail2k.k-kdom.nishanet.com") by vger.kernel.org with ESMTP
	id S264477AbTIDCbi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 22:31:38 -0400
Message-ID: <3F56A147.1040009@boxho.com>
Date: Wed, 03 Sep 2003 22:19:51 -0400
From: Resident Boxholder <resid@boxho.com>
User-Agent: Mozilla/5.0 (Windows; U; Win98; en-US; rv:1.4) Gecko/20030624 Netscape/7.1 (ax)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: "bleating edge" What is the SiI 0680 chipset status?
References: <20030902165537.GA1830@bartek.tu.kielce.pl> <1062589779.19059.8.camel@dhcp23.swansea.linux.org.uk>
In-Reply-To: <1062589779.19059.8.camel@dhcp23.swansea.linux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

siimage.c is not broken, works, and may be perfect, since workarounds 
point to ioapic
handling for which siimage.c is just downstream. ioapic code could be 
fine, too, and
boards or chips responsible for ioapic problems, but ioapic is involved 
when things
go wrong. Total ACPI lobotomy is unnecessary, acpi is valuable.

Alan Cox wrote:

>On Maw, 2003-09-02 at 17:55, Tomasz B±tor wrote:
>  
>
>>I recently got MiNt PCI IDE ATA/133 RAID controller based on SiI 0680
>>chipset. I browsed through the archives and I know that the driver is
>>known to be broken and simply doesn't work.
>>    
>>
>
>It just works. You do want 2.4.22 ideally, and you want 2.4.22-ac to use
>hotplug.
>
>Alan
>
SiI680 siig ata/133 card, siimage.c(and no separate cmd640 fix option) 
kern 2.6.0-test4,
kernel APIC on but kernel IOAPIC off then hdparm -c1 -d1 -p9 -u0 -X70 
the drives
on the sii680

cmos setup setting APIC off gets rtl8139c card to ping by letting linux 
turn apic on

That's nforce2 mbo with rtl8139c on **card** and sii680 on card.

Then rtl8139a **onboard ** with all via chips in a Shuttle SK41G toaster 
FX41 mbo had
the same no-ping problem fixed by using kernel 2.6.0-test2 or test4 
instead of 2.4! That
defines 2.6 as "bleating edge" for sheeple--turning acpi off is more 
drastic than necessary,
and the siimage.c driver is not "broken" or perhaps even involved with 
the IOAPIC problem,
and using 2.6 can make something work where 2.4 doesn't.

I guess sii680 qualifies as bleatiing edge. I was close to going scsi-bear.

Actually I pulled the raid jumper off sii680 so sii680's two drives and 
two more on
onboard amd74xx nforce2 are handled by linux software raid0, reiserfs.

-Bob

