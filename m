Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264379AbUFCPXy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264379AbUFCPXy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 11:23:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264377AbUFCPXp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 11:23:45 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:34511 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S265554AbUFCPUv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 11:20:51 -0400
Date: Thu, 3 Jun 2004 17:20:43 +0200
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, len.brown@intel.com
Subject: Re: 2.6.7-rc2-mm2
Message-ID: <20040603152042.GK1946@suse.de>
References: <20040603015356.709813e9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040603015356.709813e9.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 03 2004, Andrew Morton wrote:
>  bk-acpi.patch

Doesn't compile if you disable ACPI, since mp_register_gsi is guarded by

#if defined(CONFIG_X86_IO_APIC) && defined(CONFIG_ACPI_INTERPRETER)

but used in arch/i386/kernel/acpi/boot.c if CONFIG_X86_IO_APIC is set
alone. I have to disable ACPI on this box still, otherwise it crashes
very hard immediately after displaying ACPI banner.

-- 
Jens Axboe

