Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280971AbRLBQa6>; Sun, 2 Dec 2001 11:30:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281009AbRLBQat>; Sun, 2 Dec 2001 11:30:49 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:21265 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S280814AbRLBQam>; Sun, 2 Dec 2001 11:30:42 -0500
Subject: Re: [PATCH] task_struct colouring ...
To: davidel@xmailserver.org (Davide Libenzi)
Date: Sun, 2 Dec 2001 16:39:25 +0000 (GMT)
Cc: kumon@flab.fujitsu.co.jp, alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org (lkml),
        yamamura@flab.fujitsu.co.jp (Shuji YAMAMURA)
In-Reply-To: <Pine.LNX.4.40.0112011604260.1696-100000@blue1.dev.mcafeelabs.com> from "Davide Libenzi" at Dec 01, 2001 04:11:08 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16AZeH-0003p0-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > 1KB room for stack coloring realizes only 8 colors.
> 
> true, that's why I'm using the Manfred idea of a separate allocation of
> task structs through a slab allocator ( with task struct pointer stored at

8 colours is probably enough. Especially once the scheduler is replaced by
something resembling sanity, that doesn't keep walking the entire runnable
list.
