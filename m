Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262996AbVALBxT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262996AbVALBxT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 20:53:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263000AbVALBxT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 20:53:19 -0500
Received: from fw.osdl.org ([65.172.181.6]:23785 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262996AbVALBxO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 20:53:14 -0500
Date: Tue, 11 Jan 2005 17:53:13 -0800
From: Chris Wright <chrisw@osdl.org>
To: Andi Kleen <ak@muc.de>
Cc: Chris Wright <chrisw@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: node_online_map patch kills x86_64
Message-ID: <20050111175313.E24171@build.pdx.osdl.net>
References: <20050111151656.A24171@build.pdx.osdl.net> <m1d5wb4jni.fsf@muc.de> <20050111163025.T469@build.pdx.osdl.net> <20050112013805.GA74675@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20050112013805.GA74675@muc.de>; from ak@muc.de on Wed, Jan 12, 2005 at 02:38:05AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andi Kleen (ak@muc.de) wrote:
> On Tue, Jan 11, 2005 at 04:30:25PM -0800, Chris Wright wrote:
> > kernel direct mapping tables upto ffff810100000000 @ 8000-d000
> > PANIC: early exception rip ffffffff8078b2e3 error 0 cr2 17c498a67
> >   Filesystem type ext2
> >   (couple more grub messgages like kernel name, root device)
> 
> Can you please boot with earlyprintk=serial,ttyS0,baud and send the full
> boot log? 
> 
> And also look up where ffffffff8078b2e3 is in System.map.

ffffffff8078b250 T free_area_init_node

Here's the log:

Bootdata ok (command line is ro root=/dev/VolGroup00/LogVol00 selinux=0 initcall_debug 3 earlyprintk=serial,ttyS0,115200)
Linux version 2.6.10 (chrisw@fuzzy.pdx.osdl.net) (gcc version 3.4.3 20041125 (Red Hat 3.4.3-7)) #217 SMP Tue Jan 11 16:13:52 PST 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009dc00 (usable)
 BIOS-e820: 000000000009dc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000d0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007ff60000 (usable)
 BIOS-e820: 000000007ff60000 - 000000007ff72000 (ACPI data)
 BIOS-e820: 000000007ff72000 - 000000007ff80000 (ACPI NVS)
 BIOS-e820: 000000007ff80000 - 0000000080000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec00400 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
kernel direct mapping tables upto ffff810100000000 @ 8000-d000
SRAT: PXM 0 -> APIC 0 -> Node 1
SRAT: PXM 1 -> APIC 1 -> Node 2
SRAT: Node 1 PXM 0 0-9ffff
SRAT: Node 1 PXM 0 0-3fffffff
SRAT: Node 2 PXM 1 40000000-7fffffff
Bootmem setup node 1 0000000000000000-000000003fffffff
Bootmem setup node 2 0000000040000000-000000007ff5ffff
No mptable found.
PANIC: early exception rip ffffffff8078b2e3 error 0 cr2 17c497a67
