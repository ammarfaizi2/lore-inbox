Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261779AbUEEEKN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261779AbUEEEKN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 00:10:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261817AbUEEEKM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 00:10:12 -0400
Received: from fmr03.intel.com ([143.183.121.5]:12730 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP id S261779AbUEEEKI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 00:10:08 -0400
Date: Tue, 4 May 2004 21:09:37 -0700
From: Ashok Raj <ashok.raj@intel.com>
To: akpm@osdl.org
Cc: davidm@hpl.hp.com, linux-kernel@vger.kernel.org, pj@sgi.com,
       rusty@rustycorp.com.au
Subject: IA64 hotplug patches patch 6 breaks i386
Message-ID: <20040504210937.A13172@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew

I will resend patch 6 and 7 for IA64 cpu hotplug. the cpu_present fix reworked to remove the
ARCH dependencies apparently didnt fit the smp boot sequence for i386. I must have moved the 
cpu_present_map fix to just before smp_init, but I added to sched_init which wasnt the right place
anyway, and the cpu_possible was not set for all cpu's at that time as it was too early for i386.

I will be resending just those 2 patches right after this mail, once my system can boot this time.

sorry for the trouble.

Cheers,
ashok
