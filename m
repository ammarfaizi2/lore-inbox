Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272805AbTG3IMw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 04:12:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272807AbTG3IMw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 04:12:52 -0400
Received: from www.13thfloor.at ([212.16.59.250]:1959 "EHLO www.13thfloor.at")
	by vger.kernel.org with ESMTP id S272805AbTG3IMt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 04:12:49 -0400
Date: Wed, 30 Jul 2003 10:12:57 +0200
From: Herbert =?iso-8859-1?Q?P=F6tzl?= <herbert@13thfloor.at>
To: Shawn <core@enodev.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: APIC error on CPU0: 02(02)
Message-ID: <20030730081257.GC2593@www.13thfloor.at>
Reply-To: herbert@13thfloor.at
Mail-Followup-To: Shawn <core@enodev.com>,
	linux-kernel@vger.kernel.org
References: <1059528202.4820.12.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1059528202.4820.12.camel@localhost>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 29, 2003 at 08:23:22PM -0500, Shawn wrote:
> I just bought a shiny new Athlon 2400+ and popped it in my biostar M7VIB
> with an up to date bios.
> 
> I'm running 2.6.0-test1-mm2, and I get tons of "APIC error on CPU0:
> 02(02)" messages. Can someone tell me what is going on?

in the ol' BP6 times (dual Celeron) APIC errors
where reported (by certain 2.4.x kernels, previous
versions simply ignored them) when an error occured
while the CPUs where communicating ...

as far as I understood, the communication between
APIC and CPU is checksummed (a very simple checksum,
like a parity) and if this checksum is invalid, the
action is restarted, so this okay, because an error
was avoided, but because the checksum is so simple
(IIRC only two bits), chances are good that some 
faulty communication will go undetected ...

please, I'm no expert on Athlon APIC or such stuff,
so this could be total bullshit, but maybe some
APIC expert will comment on that ;)

best,
Herbert

> Info about my machine's hardware:
> http://www.enodev.com/info.html
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
