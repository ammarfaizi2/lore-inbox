Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282222AbRLHQmG>; Sat, 8 Dec 2001 11:42:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282244AbRLHQmA>; Sat, 8 Dec 2001 11:42:00 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:51450 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S282222AbRLHQlw>;
	Sat, 8 Dec 2001 11:41:52 -0500
From: David Mosberger <davidm@hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15378.17075.960942.357075@napali.hpl.hp.com>
Date: Sat, 8 Dec 2001 08:41:23 -0800
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: davidm@hpl.hp.com, marcelo@conectiva.com.br (Marcelo Tosatti),
        akpm@zip.com.au (Andrew Morton), j-nomura@ce.jp.nec.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.16 kernel/printk.c (per processorinitializationcheck)
In-Reply-To: <E16CfdX-00017X-00@the-village.bc.nu>
In-Reply-To: <15377.26745.265632.705793@napali.hpl.hp.com>
	<E16CfdX-00017X-00@the-village.bc.nu>
X-Mailer: VM 6.76 under Emacs 20.4.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Sat, 8 Dec 2001 11:27:19 +0000 (GMT), Alan Cox <alan@lxorguk.ukuu.org.uk> said:

  >> I'm no x86 expert, but I have the impression that
  >> current_cpu_data.loops_per_jiffy will be invalid (probably 0)
  >> until smp_store_cpu_info() is called in smp_callin().  If so, a
  >> console driver using udelay() might not work properly.  I suspect
  >> there are other issues, but this is just based on looking at the
  >> x86 source code for 5 minutes.

  Alan> x86_udelay_tsc wont have been set at that point so the main
  Alan> timer is still being used.

x86 does use current_cpu_data.loops_per_jiffy in the non-TSC case, no?

	--david
