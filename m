Return-Path: <linux-kernel-owner+w=401wt.eu-S1947424AbWLHWEp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947424AbWLHWEp (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 17:04:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947425AbWLHWEp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 17:04:45 -0500
Received: from outgoing1.smtp.agnat.pl ([193.239.44.83]:40118 "EHLO
	outgoing1.smtp.agnat.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1947424AbWLHWEo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 17:04:44 -0500
From: Arkadiusz Miskiewicz <arekm@maven.pl>
Organization: SelfOrganizing
To: Andi Kleen <ak@suse.de>
Subject: Re: proxy_pda was Re: What was in the x86 merge for .20
Date: Fri, 8 Dec 2006 23:04:19 +0100
User-Agent: KMail/1.9.5
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, linux-kernel@vger.kernel.org
References: <200612080401.25746.ak@suse.de> <4579D496.6080201@goop.org> <200612082222.33673.ak@suse.de>
In-Reply-To: <200612082222.33673.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200612082304.19371.arekm@maven.pl>
X-Authenticated-Id: arekm
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 08 December 2006 22:22, Andi Kleen wrote:

> The trouble is when it's CSEd it actually causes worse code because
> a register is tied up. That might not be worth the advantage of having it?
>
> Hmm, maybe marking it volatile would help? Arkadiusz, does the following
> patch help?

Unfortunately - no.

  LD      .tmp_vmlinux1
arch/i386/kernel/built-in.o: In function `dump_stack':
(.text+0x36a7): undefined reference to `_proxy_pda'
arch/i386/kernel/built-in.o: In function `math_emulate':
(.text+0x3910): undefined reference to `_proxy_pda'
arch/i386/kernel/built-in.o: In function `smp_error_interrupt':
(.text+0xe093): undefined reference to `_proxy_pda'
arch/i386/kernel/built-in.o: In function `smp_apic_timer_interrupt':
(.text+0xe16d): undefined reference to `_proxy_pda'
arch/i386/kernel/built-in.o: In function `smp_apic_timer_interrupt':
(.text+0xe184): undefined reference to `_proxy_pda'
arch/i386/kernel/built-in.o:(.init.text+0x268a): more undefined references to 
`_proxy_pda' follow
make: *** [.tmp_vmlinux1] B³±d 1

.i, .S offlist.

> -Andi


-- 
Arkadiusz Mi¶kiewicz        PLD/Linux Team
arekm / maven.pl            http://ftp.pld-linux.org/
