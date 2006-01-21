Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932169AbWAUM5u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932169AbWAUM5u (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 07:57:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932174AbWAUM5u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 07:57:50 -0500
Received: from fluido.speedxs.nl ([83.98.238.192]:29705 "EHLO fluido.as")
	by vger.kernel.org with ESMTP id S932169AbWAUM5t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 07:57:49 -0500
Date: Sat, 21 Jan 2006 13:57:41 +0100
From: "Carlo E. Prelz" <fluido@fluido.as>
To: Andrew Morton <akpm@osdl.org>
Cc: "Carlo E. Prelz" <fluido@fluido.as>, linux-kernel@vger.kernel.org
Subject: Re: ATI RS480-based motherboard: stuck while booting with kernel >= 2.6.15 rc1
Message-ID: <20060121125741.GA13470@epio.fluido.as>
References: <20060120123202.GA1138@epio.fluido.as> <20060121010932.5d731f90.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <20060121010932.5d731f90.akpm@osdl.org>
X-operating-system: Linux epio 2.6.14
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Subject: Re: ATI RS480-based motherboard: stuck while booting with kernel >= 2.6.15 rc1
	Date: sab 21 gen 06 01:09:32 -0800

Quoting Andrew Morton (akpm@osdl.org):

> Can you please add `initcall_debug' to the kernel boot command line? 
> That'll tell us which function got stuck.

I photographed the screen. I am copying here the last few lines. I
hope I make no errors in copying...

...
...
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Calling initcall 0xffffffff806de042: init_nlm+0x0/0x21()
Calling initcall 0xffffffff806de063: init_nls_cp437+0x0/0xc()
Calling initcall 0xffffffff806de06f: init_nls_cp850+0x0/0xc()
Calling initcall 0xffffffff806de07b: init_nls_cp852+0x0/0xc()
Calling initcall 0xffffffff806de087: init_nls_iso8859_1+0x0/0xc()
Calling initcall 0xffffffff806de093: init_nls_iso8859_15+0x0/0xc()
Calling initcall 0xffffffff806de09f: init_nls_utf8+0x0/0x1f()
Calling initcall 0xffffffff806de0be: init_autofs4_fs+0x0/0xc()
Calling initcall 0xffffffff806de0ca: init_udf_fs+0x0/0x53()
Calling initcall 0xffffffff806de11d: ipc_init+0x0/0x14()
Calling initcall 0xffffffff806de2ea: init_mqueue_fs+0x0/0xc7()
Calling initcall 0xffffffff806de51d: key_proc_init+0x0/0x52()
Calling initcall 0xffffffff806de67c: init_crypto+0x0/0x18()
Initializing Cryptographic API
Calling initcall 0xffffffff806de6b4: init+0x0/0xc()
Calling initcall 0xffffffff806de6c0: init+0x0/0xc()
Calling initcall 0xffffffff806de6cc: init+0x0/0xc()
Calling initcall 0xffffffff806de6d8: init+0x0/0xc()
Calling initcall 0xffffffff806de6e4: init+0x0/0x35()
Calling initcall 0xffffffff806de719: init+0x0/0x5a()
Calling initcall 0xffffffff806de773: init+0x0/0x5a()
Calling initcall 0xffffffff806de7cd: init+0x0/0x35()
Calling initcall 0xffffffff806de802: init+0x0/0xc()
Calling initcall 0xffffffff806de80e: init+0x0/0xc()
Calling initcall 0xffffffff806de81a: init+0x0/0x35()
Calling initcall 0xffffffff806de84f: init+0x0/0xc()
Calling initcall 0xffffffff806de85b: init+0x0/0xc()
Calling initcall 0xffffffff806de867: arc4_init+0x0/0xc()
Calling initcall 0xffffffff806de873: init+0x0/0x5a()
Calling initcall 0xffffffff806de8cd: init+0x0/0xc()
Calling initcall 0xffffffff806de8d9: init+0x0/0xc()
Calling initcall 0xffffffff806de8e5: init+0x0/0xc()
Calling initcall 0xffffffff806de8f1: michael_mic_init+0x0/0xc()
Calling initcall 0xffffffff806de8fd: init+0x0/0xc()
Calling initcall 0xffffffff806dea0a: noop_init+0x0/0xc()
Scheduler noop registered
Calling initcall 0xffffffff806dea16: as_init+0x0/0x4f()
Scheduler anticipatory registered
Calling initcall 0xffffffff806dea65: deadline_init+0x0/0x4f()
Scheduler deadline registered
Calling initcall 0xffffffff806deab4: cfq_init+0x0/0xc4()
Scheduler cfq registered
Calling initcall 0xffffffff8026836c: pci_init+0x0/0x2b()


And then the machine freezes. I may add that, with 2.6.14.6, I am
getting errors like:

APIC error on CPU0: 04(40)

or, more often

APIC error on CPU0: 40(40)

I tried either to pass noapic, or to disable apic in bios, and the
kernel entered a slow process of testing and refusing all addresses of
my SCSI card (I tried both an Advansys and a NCR: the result has been
the same) and then eventually gave an oops in ifconfig. I haven't
photographed those messages, but I will do so if needed. 

Carlo

-- 
  *         Se la Strada e la sua Virtu' non fossero state messe da parte,
* K * Carlo E. Prelz - fluido@fluido.as             che bisogno ci sarebbe
  *               di parlare tanto di amore e di rettitudine? (Chuang-Tzu)
