Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133027AbRDUXL5>; Sat, 21 Apr 2001 19:11:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133025AbRDUXLs>; Sat, 21 Apr 2001 19:11:48 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:37133 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S133027AbRDUXLm>; Sat, 21 Apr 2001 19:11:42 -0400
Subject: Re: APIC-Errors+Crashes on GA 586DX, 2.2.17/2.4.3
To: kkeil@suse.de (Karsten Keil)
Date: Sun, 22 Apr 2001 00:13:34 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010421180435.A22420@pingi.muc.suse.de> from "Karsten Keil" at Apr 21, 2001 06:04:35 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14r6ZO-0004Xf-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> here. These errors itself are not a problem since the APIC bus detect
> it and recover, but if here are double errors in a way that the checksum
> is OK, the APIC may run in trouble.

Also nothing but recent -ac kernels in the 2.4 range handle the replay of
IPI's sometimes caused by this. That patch is a post 2.4.4 thing to sort out.

> I don't know all kinds of events the APIC bus is used for, it is not only
> for the IRQs.

Interrupts from I/O devices and interrupts sent between processors. The latter
are used to tell the other cpus to do things like flush TLB entries, change
an MTRR value etc

Alan

