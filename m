Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310214AbSCXQi3>; Sun, 24 Mar 2002 11:38:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310252AbSCXQiU>; Sun, 24 Mar 2002 11:38:20 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:19727 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S310249AbSCXQiN>; Sun, 24 Mar 2002 11:38:13 -0500
Subject: Re: [2.4.18] Security: Process-Killer if machine get's out of memory
To: andihartmann@freenet.de (Andreas Hartmann)
Date: Sun, 24 Mar 2002 16:54:23 +0000 (GMT)
Cc: riel@conectiva.com.br (Rik van Riel),
        linux-kernel@vger.kernel.org (Kernel-Mailingliste)
In-Reply-To: <3C9DDDEE.3000401@athlon.maya.org> from "Andreas Hartmann" at Mar 24, 2002 03:08:46 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16pBGB-0006gE-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Advantage of combining consumption-speed and memory usage per process 
> would be, that processes could be filtered, which are obviously broken. 
> If the behaviour of the process is correct, than the machine hasn't 
> enough memory. But this is a problem, which cannot be handled by the kernel.

With 2.4.19pre3-ac3+ you don't need a heuristic. Do

	echo "2" >/proc/sys/vm/overcommit_memory

The system will then fail allocations before they can cause an OOM status.
It might be interesting to add "except root" modes to this.

Alan
