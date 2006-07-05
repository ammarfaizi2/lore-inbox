Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964979AbWGESne@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964979AbWGESne (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 14:43:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964946AbWGESne
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 14:43:34 -0400
Received: from mga02.intel.com ([134.134.136.20]:61116 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S964944AbWGESnd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 14:43:33 -0400
X-IronPort-AV: i="4.06,210,1149490800"; 
   d="scan'208"; a="60900678:sNHT4249353717"
x-mimeole: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] cardbus: revert IO window limit
Date: Wed, 5 Jul 2006 11:29:38 -0700
Message-ID: <B89EB28C36F28844BA12BBD21F096D1F43A7B9@scsmsx414.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] cardbus: revert IO window limit
Thread-Index: Acackrdh1QFeEKL4QyyMYTG02q8s/gDzRlkQ
From: "Mallick, Asit K" <asit.k.mallick@intel.com>
To: "Linus Torvalds" <torvalds@osdl.org>, "Dave Jones" <davej@redhat.com>,
       "Li, Shaohua" <shaohua.li@intel.com>,
       "Arjan van de Ven" <arjan@linux.intel.com>
Cc: "Alessio Sangalli" <alesan@manoweb.com>, "Andrew Morton" <akpm@osdl.org>,
       <alan@lxorguk.ukuu.org.uk>, <penberg@cs.Helsinki.FI>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       <ink@jurassic.park.msu.ru>, <dtor_core@ameritech.net>
X-OriginalArrivalTime: 05 Jul 2006 18:29:38.0778 (UTC) FILETIME=[F9604BA0:01C6A060]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am trying to find the register information. 440MX is an integration of
440BX north-bridge without AGP and PIIX4E (82371EB). PIIX4 quirk should
cover the ACPI and SMBus related I/O registers. Is there a pci dump for
this machine?

Thanks,
Asit


Linus Torvalds <mailto:torvalds@osdl.org> wrote on Friday, June 30, 2006
3:15 PM:

> On Fri, 30 Jun 2006, Dave Jones wrote:
>>  >
>>  > http://www.codemonkey.org.uk/cruft/440/
>>  > There's an assortment of docs for the other flavour Intel PCIsets
>> from  > that era in the same dir. 
>> 
>> Hrmm, actually that seems to have everything *but* config space
>> definitions. 
> 
> Yeah, I found those on the intel site too, but nothing with config
> space 
> access info.
> 
> It's surprising, actually. I usually have no trouble finding chipset
> config space info for intel chipsets.
> 
> Adding a few Intel people to the list, in the hope that they would
> know at 
> least the right person to ask.
> 
> Guys: the problem is that the 440MX (PCI ID: 8086:7194) seems to have
> some 
> magic IO register stuff again (probably ACPI or SMBus as usual), and
> we 
> don't know about them, and we don't have a quirk, so when the cardbus
> IO 
> range gets allocated, it can clash and cause trouble.
> 
> No docs seem to say _what_ the magic IO addresses are.. Pls help!
> 
> 		Linus
