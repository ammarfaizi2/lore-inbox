Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264108AbTLZVS2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Dec 2003 16:18:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265229AbTLZVS2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Dec 2003 16:18:28 -0500
Received: from citrine.spiritone.com ([216.99.193.133]:39848 "EHLO
	citrine.spiritone.com") by vger.kernel.org with ESMTP
	id S264108AbTLZVS1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Dec 2003 16:18:27 -0500
Date: Fri, 26 Dec 2003 13:18:15 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6 kgdb without serial port
Message-ID: <2380000.1072473494@[10.10.2.4]>
In-Reply-To: <20031226110851.29ce9fa5.akpm@osdl.org>
References: <20031215200640.GA3724@elf.ucw.cz><20031215223438.196295a8.akpm@osdl.org><20031226182740.GA10397@elf.ucw.cz> <20031226110851.29ce9fa5.akpm@osdl.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > > 2.6 kgdb patches in -mm tree seem to contain kgdb-over-ethernet stuff,
>> > > but still require me to fill in serial port interrupt/address. Is
>> > > there easy way to make it work without serial port? [This notebook has
>> > > none :-(].
>> > 
>> > That's a bit ugly, but things should still work OK?  Give it some random
>> > UART address but specify an ethernet connection at boot time - the kgdb
>> > stub should never touch the UART.
>> 
>> I found out what was biting me: using 2.95 with kgdb is bad idea. 2.95
>> with kgdb means reboot just after uncompressing kernel -- pretty nasty
>> to debug. Please apply,
> 
> I've been using 2.95.3 on and off for ages, no problems?

2.95.4 seems to work as well, or did last time I tried it. 
Pavel, what version exactly were you using?

early_printk might help debugging, if you're interested.
ftp://ftp.kernel.org/pub/linux/kernel/people/mbligh/patches/2.6.0/2.6.0-mjb1/200-early_printk

M.
