Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274023AbRISIwj>; Wed, 19 Sep 2001 04:52:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274025AbRISIwa>; Wed, 19 Sep 2001 04:52:30 -0400
Received: from cpe.atm0-0-0-209183.boanxx7.customer.tele.dk ([62.242.151.103]:1729
	"HELO mail.hswn.dk") by vger.kernel.org with SMTP
	id <S274023AbRISIwR>; Wed, 19 Sep 2001 04:52:17 -0400
Date: Wed, 19 Sep 2001 10:52:40 +0200
From: =?iso-8859-1?Q?Henrik_St=F8rner?= <henrik@hswn.dk>
To: linux-kernel@vger.kernel.org
Subject: 2.4.10pre12: IO_APIC_init_uniprocessor undefined
Message-ID: <20010919105240.A11535@hswn.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Compiling without SMP but with "APIC and IO-APIC support on
uniprocessors" enabled, i.e.

# CONFIG_SMP is not set
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_LOCAL_APIC=y

fails with IO_APIC_init_uniprocessor undefined. This comes from
init/main.c line 486, which has the only mention of this routine 
in the kernel source - it seems pre12 removed this routine from
kernel/io_apic.c. So is this just a forgotten remnant of that
clean-up, or should there have been a replacement in the patch?

-- 
Henrik Storner <henrik@hswn.dk> 

