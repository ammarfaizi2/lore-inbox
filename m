Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281893AbRLAWQ4>; Sat, 1 Dec 2001 17:16:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281897AbRLAWQp>; Sat, 1 Dec 2001 17:16:45 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:4877 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S281893AbRLAWQg>; Sat, 1 Dec 2001 17:16:36 -0500
Subject: Re: [OT] Wrapping memory.
To: maze@druid.if.uj.edu.pl (Maciej Zenczykowski)
Date: Sat, 1 Dec 2001 22:24:58 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0112012249440.15977-100000@druid.if.uj.edu.pl> from "Maciej Zenczykowski" at Dec 01, 2001 11:03:11 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16AIZ8-0008Re-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I would like to have a 64 KBarray (of char), that's trivial, however what
> I would like is for the last 4 KB [yes thankfully this is exactly one
> page... (assume i386)] to reference the same physical memory as the first
> four.

Yep you can do that.

> Is this at all possible? If so, how would I do this in user space (and
> could it be done without root priv?)?

mmap will do what you need. Create a 60K object on disk and mmap it
at the base address and then 60K further on for 4K. 

