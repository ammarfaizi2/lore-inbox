Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264454AbTGGUgy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 16:36:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264456AbTGGUgy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 16:36:54 -0400
Received: from air-2.osdl.org ([65.172.181.6]:38378 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264454AbTGGUgw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 16:36:52 -0400
Date: Mon, 7 Jul 2003 13:50:09 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: alan@lxorguk.ukuu.org.uk
Subject: Re: [PATCH] PATCH: fix definition of boot_DT
Message-Id: <20030707135009.49798a10.rddunlap@osdl.org>
In-Reply-To: <200307072023.h67KNJa4007824@hera.kernel.org>
References: <200307072023.h67KNJa4007824@hera.kernel.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 07 Jul 2003 19:43:36 +0000 Linux Kernel Mailing List <linux-kernel@vger.kernel.org> wrote:

| ChangeSet 1.1053, 2003/07/07 16:43:36-03:00, alan@lxorguk.ukuu.org.uk
| 
| 	[PATCH] PATCH: fix definition of boot_DT
| 	
| 
| diff -Nru a/include/asm-i386/io_apic.h b/include/asm-i386/io_apic.h
| --- a/include/asm-i386/io_apic.h	Mon Jul  7 13:23:22 2003
| +++ b/include/asm-i386/io_apic.h	Mon Jul  7 13:23:22 2003
| @@ -45,7 +45,7 @@
|  } __attribute__ ((packed));
|  
|  struct IO_APIC_reg_03 {
| -	__u32	boot_DT		:  1,
| +	__u32	boot_DT		: 1,
|  		__reserved_1	: 31;
|  } __attribute__ ((packed));

Now you have made this one line (boot_DT) different from all of
the other lines in that file regarding single-digit-sized bit fields.
It was done like this at Maciej's (macro's) request.

Compare:

struct IO_APIC_reg_02 {
	__u32	__reserved_2	: 24,
		arbitration	:  4,
		__reserved_1	:  4;
} __attribute__ ((packed));


--
~Randy
| http://developer.osdl.org/rddunlap/ | http://www.xenotime.net/linux/ |
