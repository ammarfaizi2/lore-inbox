Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265239AbUEMXPn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265239AbUEMXPn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 19:15:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265245AbUEMXPn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 19:15:43 -0400
Received: from fw.osdl.org ([65.172.181.6]:52613 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265239AbUEMXPl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 19:15:41 -0400
Date: Thu, 13 May 2004 16:18:15 -0700
From: Andrew Morton <akpm@osdl.org>
To: Robert Picco <Robert.Picco@hp.com>
Cc: linux-kernel@vger.kernel.org, venkatesh.pallipadi@intel.com
Subject: Re: [PATCH] HPET driver
Message-Id: <20040513161815.4268801d.akpm@osdl.org>
In-Reply-To: <40A3F805.5090804@hp.com>
References: <40A3F805.5090804@hp.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Picco <Robert.Picco@hp.com> wrote:
>
> Hi:
> 
> The driver supports the High Precision Event Timer.  The driver has 
> adopted a similar API to the Real Time Clock driver.  It can support any 
> number of HPET devices and the maximum number of timers per HPET device.
> For further information look at the documentation in the patch.
> 
> Thanks to Venki at Intel for testing the driver on X86 hardware with HPET.

>From a quick read:

- Impressive lack of code comments!

- The /proc entries seem to be undocumented.

- There are several uses of `volatile' in the driver.  Usually this is
  either unnecessary or indicates a deeper problem.  Are they needed?

- Why is mmap setting VM_SHM?

- hpet_alloc() leaks `hpetp' on error paths

