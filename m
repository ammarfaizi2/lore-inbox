Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261781AbVBIFAa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261781AbVBIFAa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 00:00:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261782AbVBIFAa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 00:00:30 -0500
Received: from fsmlabs.com ([168.103.115.128]:15335 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S261781AbVBIFAZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 00:00:25 -0500
Date: Tue, 8 Feb 2005 22:00:55 -0700 (MST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: "Marcos D. Marado Torres" <marado@student.dei.uc.pt>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc3-mm1
In-Reply-To: <Pine.LNX.4.61.0502090357060.7433@student.dei.uc.pt>
Message-ID: <Pine.LNX.4.61.0502082200320.26742@montezuma.fsmlabs.com>
References: <20050204103350.241a907a.akpm@osdl.org>
 <Pine.LNX.4.61.0502090357060.7433@student.dei.uc.pt>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Feb 2005, Marcos D. Marado Torres wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> On Fri, 4 Feb 2005, Andrew Morton wrote:
> 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11-rc3/2.6.11-rc3-mm1/
> 
> Andrew,
> 
> Please add to -mm the patch in attachment, since it solves the old
> acpi_power_off bug...

Where is the original bug report? Is the set_cpus_allowed the problem?

+#if 0  /* This should be made redundant by other patches.. */
        /* Some SMP machines only can poweroff in boot CPU */
        set_cpus_allowed(current, cpumask_of_cpu(0));
-       acpi_wakeup_gpe_poweroff_prepare();
-       acpi_enter_sleep_state_prep(ACPI_STATE_S5);
+#endif
