Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286264AbRLJNhH>; Mon, 10 Dec 2001 08:37:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286266AbRLJNg6>; Mon, 10 Dec 2001 08:36:58 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:63751 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S286264AbRLJNgu>; Mon, 10 Dec 2001 08:36:50 -0500
Subject: Re: mm question
To: volodya@mindspring.com
Date: Mon, 10 Dec 2001 13:46:13 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.20.0112100820570.16878-100000@node2.localnet.net> from "volodya@mindspring.com" at Dec 10, 2001 08:25:39 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16DQl3-00023R-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  How does one do the following task: obtain a bunch of free pages (around
> 300K) with physical addresses between certain bounds (more then
> 0x4000000, but it is likely this is not constant) reserver them and map to
> kernel space so that the driver can access them directly ?

We support allocating pages below 16Mb, below 4Gb, or anywhere within RAM
on x86. If you want to within a range or your 300K must be a single 300K
block then you need to allocate it at boot time
