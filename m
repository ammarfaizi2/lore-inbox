Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272164AbTHNFp3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 01:45:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272166AbTHNFp3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 01:45:29 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:19211 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S272164AbTHNFp2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 01:45:28 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: C99 Initialisers
Date: 13 Aug 2003 22:45:03 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <bhf7kv$dd5$1@cesium.transmeta.com>
References: <20030812020226.GA4688@zip.com.au> <20030812180158.GA1416@kroah.com> <20030812235324.GA12953@redhat.com> <20030813000841.GP10015@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20030813000841.GP10015@parcelfarce.linux.theplanet.co.uk>
By author:    Matthew Wilcox <willy@debian.org>
In newsgroup: linux.dev.kernel
>
> On Wed, Aug 13, 2003 at 12:53:24AM +0100, Dave Jones wrote:
> > What would be *really* nice, would be the ability to do something
> > to the effect of..
> 
> While we're off in never-never land, it'd be nice to specify default
> values for struct initialisers.  eg, something like:
> 
> struct pci_device_id {
>         __u32 vendor = PCI_ANY_ID;
>         __u32 device = PCI_ANY_ID;
>         __u32 subvendor = PCI_ANY_ID;
> 	__u32 subdevice = PCI_ANY_ID;
>         __u32 class = 0;
> 	__u32 class_mask = 0;
>         kernel_ulong_t driver_data = 0;
> };
> 
> Erm, hang on a second ...  Since when are PCI IDs 32-bit?  What is this
> ridiculous bloat?  You can't even argue that this makes things pack
> better since this packs equally well:
> 

I usually find that treating VID:DID and SVID:SDID as two 32-bit
numbers makes a lot more sense than four 16-bit fields.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
If you send me mail in HTML format I will assume it's spam.
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
