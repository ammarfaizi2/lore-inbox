Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310516AbSCPTcu>; Sat, 16 Mar 2002 14:32:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310528AbSCPTcj>; Sat, 16 Mar 2002 14:32:39 -0500
Received: from ns.suse.de ([213.95.15.193]:35079 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S310516AbSCPTc3>;
	Sat, 16 Mar 2002 14:32:29 -0500
To: yodaiken@fsmlabs.com
Cc: Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Subject: Re: [Lse-tech] Re: 10.31 second kernel compile
In-Reply-To: <20020316113536.A19495@hq.fsmlabs.com.suse.lists.linux.kernel> <Pine.LNX.4.33.0203161037160.31913-100000@penguin.transmeta.com.suse.lists.linux.kernel> <20020316115726.B19495@hq.fsmlabs.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 16 Mar 2002 20:32:26 +0100
In-Reply-To: yodaiken@fsmlabs.com's message of "16 Mar 2002 20:03:00 +0100"
Message-ID: <p73g0301f79.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

yodaiken@fsmlabs.com writes:

> is there a 64 bit machine with hardware search of pagetables? Even ibm
> only has a hardware search of hash tables - which we agree are simply
> a means of making your hardware TLB larger and slower.

x86-64 aka AMD Hammer does hardware (or more likely microcode) search of 
page tables.
It has a 4 level page table with 4K pages. Generic Linux MM code only sees
the first slot in 4th level page limit user space to 512GB with 3 levels. 
Direct mappings and kernel mappings are handled specially by architecture 
specific code outside that first slot.

The CPU itself has I/D TLBs split into L1 and L2.

-Andi
