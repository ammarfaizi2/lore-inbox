Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263081AbTLDE7O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 23:59:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263106AbTLDE7N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 23:59:13 -0500
Received: from fmr05.intel.com ([134.134.136.6]:52678 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S263081AbTLDE7I convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 23:59:08 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: [Lhms-devel] RE: memory hotremove prototype, take 3
Date: Wed, 3 Dec 2003 20:59:04 -0800
Message-ID: <A20D5638D741DD4DBAAB80A95012C0AE0125DD50@orsmsx409.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [Lhms-devel] RE: memory hotremove prototype, take 3
Thread-Index: AcO6G4xkomP5VW/kQBKW2S7tRqwq7QAAPOOQ
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "Yasunori Goto" <ygoto@fsw.fujitsu.com>
Cc: "Pavel Machek" <pavel@suse.cz>, <linux-kernel@vger.kernel.org>,
       "Luck, Tony" <tony.luck@intel.com>,
       "IWAMOTO Toshihiro" <iwamoto@valinux.co.jp>,
       "Hirokazu Takahashi" <taka@valinux.co.jp>,
       "Linux Hotplug Memory Support" <lhms-devel@lists.sourceforge.net>
X-OriginalArrivalTime: 04 Dec 2003 04:59:05.0168 (UTC) FILETIME=[57885500:01C3BA23]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Yasunori Goto
> Sent: Wednesday, December 03, 2003 1:23 PM
> To: Perez-Gonzalez, Inaky
> Cc: Pavel Machek; linux-kernel@vger.kernel.org; Luck, Tony; IWAMOTO Toshihiro; Hirokazu Takahashi; Linux Hotplug Memory Support
> Subject: Re: [Lhms-devel] RE: memory hotremove prototype, take 3
> 
> 
> > > IMHO, To hot-remove memory, memory attribute should be divided
> > > into Hotpluggable and no-Hotpluggable, and each attribute memory
> > > should be allocated each unit(ex. node).
> >
> > Why? I still don't get that -- we should be able to use the virtual
> > addressing mechanism of any CPU to swap under the rug any virtual
> > address without needing to do anything more than allocate a page frame
> > for the new physical location
> 
> My understanding is that the kernel and device drivers sometimes
> assume physical memory address is not changed.
> For example, IA32 kernel often uses __PAGE_OFFSET.
> I suppose that there are many case which the kernel and device drivers
> assume physical address is not changed like this.
> Even if we use Mr. Iwamoto's method use, some memories will remain.

Grrrr ... my concern is that Murphy's Law says that we'll need to hotplug
the memory that we cannot in most of the cases (pray not). I guess I will
need to research some more to think how to do it.

I still think we could use the CPU's virtualization mechanism--of course,
and as you and Tony Luck mention, we'd had to track down and modify the
parts that assume physical memory et al. That they use large pages or
not doesn't seem to be such a big problem (other than allocating a bigger
chunk for transfer) and that performance wise, it'd take longer to 
do _that_ part, but still I prefer it to taking the machine down.

Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own (and my fault)
