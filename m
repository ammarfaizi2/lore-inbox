Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317141AbSEXPtW>; Fri, 24 May 2002 11:49:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317154AbSEXPtV>; Fri, 24 May 2002 11:49:21 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:64012 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S317141AbSEXPtU>; Fri, 24 May 2002 11:49:20 -0400
Subject: Re: It hurts when I shoot myself in the foot
To: kasperd@daimi.au.dk (Kasper Dupont)
Date: Fri, 24 May 2002 17:09:39 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org (Linux-Kernel)
In-Reply-To: <3CEE5DFB.985EFF6E@daimi.au.dk> from "Kasper Dupont" at May 24, 2002 05:36:27 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17BHdL-0006lF-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Couldn't that be solved in one of the following ways?
> 
> 1) Disable pre-emption while reading TSC and CPU nr.
> 2) Use affinity for processes pre-empted in kernel mode.
> 3) Disable pre-emption for SMP systems.

You can solve it by disabling pre-emption (and given its questionable
value doing so permanently might not be a bad idea). However if you simply
disable pre-emption during udelay() calls then you've just screwed yourself
by removing 99% of the use pre-emption had.

Given all the pain its probably better to not use the TSC
