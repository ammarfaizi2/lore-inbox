Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262175AbREQCbU>; Wed, 16 May 2001 22:31:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262177AbREQCbK>; Wed, 16 May 2001 22:31:10 -0400
Received: from isis.its.uow.edu.au ([130.130.68.21]:28888 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S262175AbREQCaz>; Wed, 16 May 2001 22:30:55 -0400
Message-ID: <3B0336E1.5ED05565@uow.edu.au>
Date: Thu, 17 May 2001 12:26:41 +1000
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-ac13 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Julian Anastasov <ja@ssi.bg>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: locked 3c905B with 2.4.5pre2
In-Reply-To: <Pine.LNX.4.10.10105162125480.2866-100000@l>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Julian Anastasov wrote:
> 
> eth0: Interrupt posted but not delivered -- IRQ blocked by another device?

This is a failure of the APIC interrupt controller in
the 2.4 kernel.  You'll need to boot your kernel with
the `noapic' LILO option.  Or run -ac kernels, which
have a software workaround which fixes the problem.

Rumour has it that the APIC fix will be merged into Linus' tree
very soon.  It needs to be - one of the more important ethernet
drivers is basically unviable on x86 SMP in 2.4.

-
