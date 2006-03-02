Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751340AbWCBBgk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751340AbWCBBgk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 20:36:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751334AbWCBBgk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 20:36:40 -0500
Received: from mx2.suse.de ([195.135.220.15]:35774 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751317AbWCBBgi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 20:36:38 -0500
From: Andi Kleen <ak@suse.de>
To: Dave Jones <davej@redhat.com>
Subject: Re: 2.6.16rc5 'found' an extra CPU.
Date: Thu, 2 Mar 2006 02:38:31 +0100
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
       Ashok Raj <ashok.raj@intel.com>
References: <20060301224647.GD1440@redhat.com> <200603020155.46534.ak@suse.de> <20060302011959.GC19755@redhat.com>
In-Reply-To: <20060302011959.GC19755@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603020238.31639.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
> Processor #0 15:5 APIC version 16
> ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
> Processor #1 15:5 APIC version 16
> ACPI: LAPIC (acpi_id[0x03] lapic_id[0x82] disabled)
> ACPI: LAPIC (acpi_id[0x04] lapic_id[0x83] disabled)

It's because of the two disabled CPUs. We decreed at some point
that disabled CPUs mean hotpluggable CPUs. But it's doing
this for some time so you probably only noticed now.

All is ok. Sorry for blaming you wrongly, Ashok.

-Andi
