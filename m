Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964902AbWCAKar@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964902AbWCAKar (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 05:30:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964901AbWCAKar
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 05:30:47 -0500
Received: from cluster-e.mailcontrol.com ([217.79.216.190]:27860 "EHLO
	cluster-e.mailcontrol.com") by vger.kernel.org with ESMTP
	id S964899AbWCAKaq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 05:30:46 -0500
Message-ID: <4405778D.2030001@superbug.co.uk>
Date: Wed, 01 Mar 2006 10:29:33 +0000
From: James Courtier-Dutton <James@superbug.co.uk>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Jeff Garzik <jgarzik@pobox.com>, pavel@ucw.cz,
       randy_d_dunlap@linux.intel.com, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: [PATCH 2/13] ATA ACPI: debugging infrastructure
References: <20060222133241.595a8509.randy_d_dunlap@linux.intel.com>	<20060222135133.3f80fbf9.randy_d_dunlap@linux.intel.com>	<20060228114500.GA4057@elf.ucw.cz>	<44043B4E.30907@pobox.com> <20060228041817.6fc444d2.akpm@osdl.org>
In-Reply-To: <20060228041817.6fc444d2.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> - The new debug stuff isn't documented.  One has funble around in the
>   source to work out how to even turn it on.  Can it be altered at runtime?
>   Dunno - the changelogs are risible.  What effect do the various flags
>   have?
>
>   Having spent (and re-spent) time grovelling through the ALSA source
>   working out how to enable their debug stuff during a maintainer snooze
>   I'd prefer we didn't have to do that with libata as well.
>
>   

Is there a particular debugging coding style that we should adopt for
all the kernel code.
For example,
kconfig option in order to compile a module/section of core code for
debug work.
A sysfs file to then control the debug level for each module.
A debug module option, in the cases where a particular level of debug is
required at module load time, and before the sysfs entry exists.
If particularly fine grained debug control is needed, the module could
have multiple entries in the sysfs to control different classes of debug
output.

One then implements all this debug support code at a global level,
making it easy for each kernel module to make use of it.

With regard to ALSA, we can make it fit in with the kernel preferred method.

James




This e-mail and any attachment is for authorised use by the intended recipient(s) only. It may contain proprietary material, confidential information and/or be subject to legal privilege. It should not be copied, disclosed to, retained or used by, any other party. If you are not an intended recipient then please promptly delete this e-mail and any attachment and all copies and inform the sender. Thank you.
