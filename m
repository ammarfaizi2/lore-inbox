Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261243AbTEMNvH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 09:51:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261244AbTEMNvH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 09:51:07 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:60810 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S261243AbTEMNvG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 09:51:06 -0400
Date: Tue, 13 May 2003 15:03:54 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: john stultz <johnstul@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@digeo.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, James <jamesclv@us.ibm.com>
Subject: Re: [PATCH] linux-2.5.69_clear-smi-fix_A1
Message-ID: <20030513140354.GB676@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	john stultz <johnstul@us.ibm.com>,
	lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@digeo.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, James <jamesclv@us.ibm.com>
References: <1052785802.4169.12.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1052785802.4169.12.camel@w-jstultz2.beaverton.ibm.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 12, 2003 at 05:30:03PM -0700, john stultz wrote:

 > 	I've been having problems with ACPI on a box here in our lab. Some of
 > our more recent hardware requires that SMIs are routed through the
 > IOAPIC, thus when we clear_IO_APIC() at boot time, we clear the BIOS
 > initialized SMI pin. This basically clobbers the SMI so we can then
 > never make the transition into ACPI mode. 
 > 
 > This patch simply reads the apic entry in clear_IO_APIC to make sure the
 > delivery_mode isn't dest_SMI. If it is, we leave the apic entry alone
 > and return.
 > 
 > With this patch, the box boots and SMIs function properly.

There's a whole bunch of 'ACPI buggers up interrupt routing' bugs
in bugzilla right now, I wonder if this could help out with those.

		Dave

