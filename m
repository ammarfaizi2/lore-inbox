Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750897AbWHVS7V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750897AbWHVS7V (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 14:59:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750879AbWHVS7V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 14:59:21 -0400
Received: from pythagoras.zen.co.uk ([212.23.3.140]:12491 "EHLO
	pythagoras.zen.co.uk") by vger.kernel.org with ESMTP
	id S1750832AbWHVS7U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 14:59:20 -0400
Date: Tue, 22 Aug 2006 19:59:09 +0100
From: Grant Wilson <grant.wilson@zen.co.uk>
To: Len Brown <lenb@kernel.org>
Cc: Maciej Rutecki <maciej.rutecki@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: 2.6.18-rc4-mm2
Message-ID: <20060822185909.GA18812@tlg.swandive.local>
References: <20060819220008.843d2f64.akpm@osdl.org> <20060821064411.20e61aa0.akpm@osdl.org> <44EA1585.8020303@gmail.com> <200608211922.10182.len.brown@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608211922.10182.len.brown@intel.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Originating-Pythagoras-IP: [82.71.45.175]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2006 at 07:22:09PM -0400, Len Brown wrote:
> Please dump the stack so we can find the secretive caller to 
> acpi_format_exception().

I get three of these when booting and the output from dump_stack
is the same for each.  I've observed no problems as a result of
these reported failures.  Here is the output from the first call
of dump_stack:

Aug 22 19:39:33 tlg kernel: ACPI Error (utglobal-0125): Unknown exception code: 0xFFFFFFEA [20060707]
Aug 22 19:39:33 tlg kernel: 
Aug 22 19:39:33 tlg kernel: Call Trace:
Aug 22 19:39:33 tlg kernel:  [<ffffffff80267cb8>] dump_trace+0xba/0x39e
Aug 22 19:39:33 tlg kernel:  [<ffffffff80267fd8>] show_trace+0x3c/0x52
Aug 22 19:39:33 tlg kernel:  [<ffffffff80268003>] dump_stack+0x15/0x17
Aug 22 19:39:33 tlg kernel:  [<ffffffff803c8d10>] acpi_format_exception+0xc0/0xcb
Aug 22 19:39:33 tlg kernel:  [<ffffffff803c54e5>] acpi_ut_status_exit+0x38/0x73
Aug 22 19:39:33 tlg kernel:  [<ffffffff803c11a0>] acpi_walk_resources+0x12e/0x140
Aug 22 19:39:33 tlg kernel:  [<ffffffff803d85e5>] acpi_motherboard_add+0x26/0x32
Aug 22 19:39:33 tlg kernel:  [<ffffffff803d73d7>] acpi_bus_driver_init+0x3a/0x98
Aug 22 19:39:33 tlg kernel:  [<ffffffff803d796c>] acpi_bus_register_driver+0xbd/0x144
Aug 22 19:39:33 tlg kernel:  [<ffffffff807dcbd4>] acpi_motherboard_init+0x10/0x130
Aug 22 19:39:33 tlg kernel:  [<ffffffff802668f1>] init+0x13b/0x313
Aug 22 19:39:33 tlg kernel:  [<ffffffff8025dba8>] child_rip+0xa/0x12
Aug 22 19:39:33 tlg kernel: DWARF2 unwinder stuck at child_rip+0xa/0x12
Aug 22 19:39:33 tlg kernel: Leftover inexact backtrace:
Aug 22 19:39:33 tlg kernel:  [<ffffffff802632ae>] _spin_unlock_irq+0x2b/0x53
Aug 22 19:39:33 tlg kernel:  [<ffffffff8025d300>] restore_args+0x0/0x30
Aug 22 19:39:33 tlg kernel:  [<ffffffff80215fed>] release_console_sem+0x4d/0x238
Aug 22 19:39:33 tlg kernel:  [<ffffffff802667b6>] init+0x0/0x313
Aug 22 19:39:33 tlg kernel:  [<ffffffff8025db9e>] child_rip+0x0/0x12

Cheers,
Grant

