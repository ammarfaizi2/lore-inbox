Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276185AbRI1RYa>; Fri, 28 Sep 2001 13:24:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276186AbRI1RYU>; Fri, 28 Sep 2001 13:24:20 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:48648 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S276185AbRI1RYN>; Fri, 28 Sep 2001 13:24:13 -0400
Subject: Re: Adding a printk in start_secondary breaks 2.4.10, not 2.4.9 ??
To: fletch@aracnet.com
Date: Fri, 28 Sep 2001 18:29:23 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (linux-kernel)
In-Reply-To: <945217781.1001672597@[10.10.1.2]> from "Martin J. Bligh" at Sep 28, 2001 10:23:17 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15n1Rz-0007lt-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> undiagnosable BINT error - I have no idea why ... maybe
> the console_lock serialises some action of the procs?)

The console locking changes have I suspect broken your bandaid. I guess
this time you need to fix it properly. Garbled panics normally occur when
both cpus panic in parallel. That really wants some kind of timed spinlock
to try and dump them one after the other

Alan
