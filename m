Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261791AbUEFHPS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261791AbUEFHPS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 03:15:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261802AbUEFHPS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 03:15:18 -0400
Received: from ns.suse.de ([195.135.220.2]:4759 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261791AbUEFHPO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 03:15:14 -0400
To: "Zhenmin Li" <zli4@cs.uiuc.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [OPERA] Potential bugs detected by static analysis tool in 2.6.4
References: <002701c4331c$092a3b40$76f6ae80@Turandot.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 06 May 2004 00:14:51 -0700
In-Reply-To: <002701c4331c$092a3b40$76f6ae80@Turandot.suse.lists.linux.kernel>
Message-ID: <p73ad0mc9hw.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Zhenmin Li" <zli4@cs.uiuc.edu> writes:

> 5. /arch/x86_64/kernel/mpparse.c, Line 652:
> Dprintk("Boot CPU = %d\n", boot_cpu_physical_apicid);
> 
> Maybe change to:
> Dprintk("Boot CPU = %d\n", boot_cpu_id);

They are the same anyways:

include/asm-x86_64/acpi.h:144:#define boot_cpu_physical_apicid boot_cpu_id

-Andi
