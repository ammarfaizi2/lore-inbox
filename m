Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265798AbTL3Ojj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 09:39:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265802AbTL3Oji
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 09:39:38 -0500
Received: from holomorphy.com ([199.26.172.102]:24770 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265798AbTL3Ojh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 09:39:37 -0500
Date: Tue, 30 Dec 2003 06:39:29 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Thomas Molina <tmolina@cablespeed.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0 performance problems
Message-ID: <20031230143929.GN27687@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Thomas Molina <tmolina@cablespeed.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0312291647410.5288@localhost.localdomain> <Pine.LNX.4.58.0312291420370.1586@home.osdl.org> <Pine.LNX.4.58.0312291755080.5835@localhost.localdomain> <Pine.LNX.4.58.0312291502210.1586@home.osdl.org> <Pine.LNX.4.58.0312300903170.2825@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0312300903170.2825@localhost.localdomain>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 30, 2003 at 09:14:31AM -0500, Thomas Molina wrote:
> CPU: PIII, speed 648.076 MHz (estimated)
> Counted CPU_CLK_UNHALTED events (clocks processor is not halted) with a unit mask of 0x00 (No unit mask) count 324038
> vma      samples  %           symbol name
> c014a1a0 195865   29.5231     module_text_address
> c0118510 90031    13.5705     mark_offset_tsc
> c0111920 49842     7.5128     mask_and_ack_8259A
> c014a2e0 23263     3.5065     kallsyms_lookup
> c0141bb0 15389     2.3196     kernel_text_address
> c01d1600 15017     2.2635     ext3_find_entry
> c0111550 14170     2.1359     enable_8259A_irq
> c0272560 13515     2.0371     cfb_imageblit
> c0120330 8149      1.2283     kernel_map_pages
> c0205f00 7819      1.1786     __io_virt_debug
> c0156560 7685      1.1584     poison_obj
> c01564d0 7497      1.1300     store_stackinfo

Okay, thus far we have some seriously performance-affecting debug
options. Could you turn those off and build non-modular?


-- wli
