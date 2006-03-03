Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752169AbWCCDj4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752169AbWCCDj4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 22:39:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752105AbWCCDj4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 22:39:56 -0500
Received: from mailhub.hp.com ([192.151.27.10]:31945 "EHLO mailhub.hp.com")
	by vger.kernel.org with ESMTP id S1752093AbWCCDjz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 22:39:55 -0500
Message-ID: <1084.24.9.204.52.1141357193.squirrel@mail.atl.hp.com>
In-Reply-To: <m1veuwgxd8.fsf@ebiederm.dsl.xmission.com>
References: <200603022340.k22Neq0o014875@shell0.pdx.osdl.net>
    <m1veuwgxd8.fsf@ebiederm.dsl.xmission.com>
Date: Thu, 2 Mar 2006 20:39:53 -0700 (MST)
Subject: Re: + pnp-mpu401-adjust-pnp_register_driver-signature.patch added 
     to -mm tree
From: "Bjorn Helgaas" <bjorn.helgaas@hp.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org, bjorn.helgaas@hp.com, ambx1@neo.rr.com,
       mm-commits@vger.kernel.org
User-Agent: SquirrelMail/1.4.4
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> This series of patches removes the assumption that pnp_register_driver()
>> returns the number of devices claimed.  Returning the count is
>> unreliable
>> because devices may be hot-plugged in the future.  (Many devices don't
>> support
>> hot-plug, of course, but PNP in general does.)
>
> Huh?
>
> How do onboard devices or ISA plug and play devices support hot-plug?
>
> Or what devices supported by the pnp subsystem support hot-plug?

I don't know for sure whether ISAPNP or PNPBIOS support hot-plug,
but ACPI does, and ACPI devices are being integrated into the
PNP subsystem via PNPACPI.

One example is HP sx2000 hardware that supports hot-plug of cells.
Each cell contains CPUs, memory, I/O bridges, and some miscellaneous
hardware like on-board serial devices.  All this stuff is described
by ACPI, and we'd like to use PNP drivers like 8250_pnp.c when we can.

