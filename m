Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283836AbRK3Xst>; Fri, 30 Nov 2001 18:48:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283833AbRK3Xsj>; Fri, 30 Nov 2001 18:48:39 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:60933 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S283836AbRK3Xs3>; Fri, 30 Nov 2001 18:48:29 -0500
Subject: Re: [PATCH] task_struct colouring ...
To: davidel@xmailserver.org (Davide Libenzi)
Date: Fri, 30 Nov 2001 23:57:13 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org (lkml),
        yamamura@flab.fujitsu.co.jp (Shuji YAMAMURA)
In-Reply-To: <Pine.LNX.4.40.0111301547130.1600-100000@blue1.dev.mcafeelabs.com> from "Davide Libenzi" at Nov 30, 2001 03:53:02 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E169xWr-0005EM-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So You like the idea of stocking structure pointers inside CPU registers
> or I missed Your point ?
> The proposed implementation is "uniform" between architectures, that's my
> point.

An uniform implementation for a totally non uniform set of processors. Not
actually useful. The x86 is one of the few cpus so short of registers that
current in a global register is not a win performancewise.

The cache behaviour also heavily depends on the processor. In paticular the
problem with having to align stacks to do current tricks is absent on non
x86 processors so they can use properly coloured stacks. 

current is far too critical to generalise
