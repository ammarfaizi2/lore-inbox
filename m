Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293219AbSCOUPB>; Fri, 15 Mar 2002 15:15:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293226AbSCOUOm>; Fri, 15 Mar 2002 15:14:42 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:61199 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S293219AbSCOUOj>; Fri, 15 Mar 2002 15:14:39 -0500
Subject: Re: bug (trouble?) report on high mem support
To: john.helms@photomask.com (John Helms)
Date: Fri, 15 Mar 2002 20:30:22 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org,
        Jim.Trice@photomask.com (Trice Jim), Martin.Bligh@us.ibm.com
In-Reply-To: <20020315.20073100@linux.local> from "John Helms" at Mar 15, 2002 08:07:31 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16lyLG-0004Zo-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Here is a top output.  We have 16Gb of ram.
> I have also tried a 2.4.9-31 enterprise=20
> kernel rpm from RedHat with the same=20
> results.

Ok that would make sense. Next question is do you have an I/O controller
that can use all the 64bit address space on the PCI bus ?

What is happening is that you are using a lot of CPU copying buffers down
into lower memory to transfer to/from disk - as well probably as that
causing a lot of competition for low memory. If your I/O controller can hit
the full 64bit space there are some rather nice test patches that should
completely obliterate the problem.

Alan
