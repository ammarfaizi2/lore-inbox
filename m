Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292289AbSDEAEC>; Thu, 4 Apr 2002 19:04:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310953AbSDEAD4>; Thu, 4 Apr 2002 19:03:56 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:23825 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292289AbSDEADk>; Thu, 4 Apr 2002 19:03:40 -0500
Subject: Re: [BUG] compile error in 2.4.19-pre5-ac1
To: davidsen@tmr.com (Bill Davidsen)
Date: Fri, 5 Apr 2002 01:17:44 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (Linux-Kernel Mailing List)
In-Reply-To: <Pine.LNX.3.96.1020404183703.4898A-100000@gatekeeper.tmr.com> from "Bill Davidsen" at Apr 04, 2002 06:45:24 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16tHQG-00077u-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   init/do_mounts.c uses SCHED_YIELD, which seems no longer defined
> although grep tells me it's heavily used in non-Intel code. I noted that

Fixed in pre2

>   Note of warning to new Redhat users, for some reason /usr/include/linux
> is a directory instead of a symbolic link to /usr/src/linux/include/linux,
> so changes in includes aren't used. Possibly an artifact of the install on
> that system, but something to note. 

Thats a feature. Its how this is meant to work. The headers with glibc
reflect the interface glibc provides and was compiled to. The ones with
the kernel reflect the kernel. Linus wanted it that way and RH finally 
caught up with implementing it properly
