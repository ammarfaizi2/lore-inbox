Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135344AbREHUsl>; Tue, 8 May 2001 16:48:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135363AbREHUsb>; Tue, 8 May 2001 16:48:31 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:33797 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S135328AbREHUsT>; Tue, 8 May 2001 16:48:19 -0400
Subject: Re: [RFC] Direct Sockets Support??
To: Venkateshr@ami.com (Venkatesh Ramamurthy)
Date: Tue, 8 May 2001 21:50:57 +0100 (BST)
Cc: pw@osc.edu ('Pete Wyckoff'), alan@lxorguk.ukuu.org.uk (Alan Cox),
        knicholson@corp.iready.com (Ken Nicholson),
        Venkateshr@ami.com (Venkatesh Ramamurthy),
        pollard@tomcat.admin.navo.hpc.mil, linux-kernel@vger.kernel.org
In-Reply-To: <1355693A51C0D211B55A00105ACCFE6402B9DEE0@ATL_MS1> from "Venkatesh Ramamurthy" at May 08, 2001 04:18:01 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14xERf-0000am-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 		a. when a user app wants to receive some data, it allocates
> memory(using malloc) and waits for the hw to do zero-copy read. The kernel
> does not allocate physical page frames for the entire memory region
> allocated. We need to lock the memory (and locking is expensive due to
> costly TLB flushes) to do this
> 
> 		b. when a user app wants to send data, he fills the buffer
> and waits for the hw to transmit data, but under heavy physical memory
> pressure, the swapper might swap the pages we want to transmit. So we need
> to lock the memory to be 100% sure.
> 

Or c) you prealloc two ring buffers.

