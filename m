Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751136AbWCBEME@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751136AbWCBEME (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 23:12:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751125AbWCBEME
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 23:12:04 -0500
Received: from mx1.redhat.com ([66.187.233.31]:3018 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751136AbWCBEMB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 23:12:01 -0500
Date: Wed, 1 Mar 2006 23:11:54 -0500
From: Dave Jones <davej@redhat.com>
To: Ashok Raj <ashok.raj@intel.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       linux-acpi@vger.kernel.org
Subject: Re: 2.6.16rc5 'found' an extra CPU.
Message-ID: <20060302041154.GA31863@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Ashok Raj <ashok.raj@intel.com>, Andi Kleen <ak@suse.de>,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
References: <20060301224647.GD1440@redhat.com> <200603020155.46534.ak@suse.de> <20060302011959.GC19755@redhat.com> <200603020238.31639.ak@suse.de> <20060301195218.A3539@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060301195218.A3539@unix-os.sc.intel.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 01, 2006 at 07:52:19PM -0800, Ashok Raj wrote:
 > On Thu, Mar 02, 2006 at 02:38:31AM +0100, Andi Kleen wrote:
 > > 
 > > > ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
 > > > Processor #0 15:5 APIC version 16
 > > > ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
 > > > Processor #1 15:5 APIC version 16
 > > > ACPI: LAPIC (acpi_id[0x03] lapic_id[0x82] disabled)
 > > > ACPI: LAPIC (acpi_id[0x04] lapic_id[0x83] disabled)
 > > 
 > > It's because of the two disabled CPUs. We decreed at some point
 > > that disabled CPUs mean hotpluggable CPUs. But it's doing
 > > this for some time so you probably only noticed now.
 > > 
 > > All is ok. Sorry for blaming you wrongly, Ashok.
 > 
 > 
 > Phew!..
 > 
 > The ACPI hotplug code isnt in 2.6.15-rc* yet. It should be in the next
 > -mm when Andrew rolls the next mm.
 > 
 > But the 3 entries seem weird, we should only see 2 sysfs entries in 
 > /sys/devices/system/cpu and just 2 entries in proc/acpi/processor as well.

sysfs gets it right.

(23:11:01:davej@nemesis:~)$ ls /sys/devices/system/cpu/
cpu0/  cpu1/
(23:11:07:davej@nemesis:~)$ ls /proc/acpi/processor/
CPU1/  CPU2/  CPU3/
(23:11:11:davej@nemesis:~)$

		Dave

