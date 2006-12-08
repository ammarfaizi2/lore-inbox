Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1425454AbWLHMFF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425454AbWLHMFF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Dec 2006 07:05:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425469AbWLHMEm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 07:04:42 -0500
Received: from outgoing1.smtp.agnat.pl ([193.239.44.83]:48402 "EHLO
	outgoing1.smtp.agnat.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1425454AbWLHMEh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 07:04:37 -0500
From: Arkadiusz Miskiewicz <arekm@maven.pl>
Organization: SelfOrganizing
To: Andi Kleen <ak@suse.de>
Subject: Re: What was in the x86 merge for .20
Date: Fri, 8 Dec 2006 13:04:23 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
References: <200612080401.25746.ak@suse.de>
In-Reply-To: <200612080401.25746.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200612081304.23230.arekm@maven.pl>
X-Authenticated-Id: arekm
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 08 December 2006 04:01, Andi Kleen wrote:

> - Support for a Processor Data Area (PDA) on i386. This makes
> the code more similar to x86-64 and will allow some other
> optimizations in the future.

  LD      .tmp_vmlinux1
arch/i386/kernel/built-in.o: In function `math_emulate':
(.text+0x3809): undefined reference to `_proxy_pda'
arch/i386/kernel/built-in.o: In function `smp_apic_timer_interrupt':
(.text+0xe140): undefined reference to `_proxy_pda'
kernel/built-in.o: In function `sys_set_tid_address':
(.text+0x370b): undefined reference to `_proxy_pda'
kernel/built-in.o: In function `switch_uid':
(.text+0xcc6c): undefined reference to `_proxy_pda'
mm/built-in.o: In function `sys_munlock':
(.text+0xcaf1): undefined reference to `_proxy_pda'
mm/built-in.o:(.text+0xcc11): more undefined references to `_proxy_pda' follow
make: *** [.tmp_vmlinux1] B³±d 1

Something related (git tree fetched 1-2h ago) ?

> -Andi

-- 
Arkadiusz Mi¶kiewicz        PLD/Linux Team
arekm / maven.pl            http://ftp.pld-linux.org/
