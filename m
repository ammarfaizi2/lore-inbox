Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310740AbSDAIYi>; Mon, 1 Apr 2002 03:24:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310749AbSDAIY1>; Mon, 1 Apr 2002 03:24:27 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:55565 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S310740AbSDAIYN>; Mon, 1 Apr 2002 03:24:13 -0500
Subject: Re: ECC memory and SMP lockups on Gateway 6400 server
To: Jason-Czerak@Jasnik.net (Jason Czerak)
Date: Mon, 1 Apr 2002 09:41:13 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1017641806.17921.35.camel@neworder> from "Jason Czerak" at Apr 01, 2002 01:16:46 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16rxNJ-0007wZ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> slowed to a crawl. After an hour of messing around. I started to pull
> memory and CPU's out. Turns out the 512meg DIMM ECC ram was the cause of
> the slowness problem.  No error messages no nothing. looks like the ECC
> was doing it's thing. But created a CPU useage of 100% all the time...
> Is there a kernel switch I can flip to make it place nice with broken
> ECC ram? or is this ram just worthless?

Unless you loaded the extra ECC modules Linux really has no awareness of the
ECC at all. More likely and the one I would check first is that the mtrr
ranges are right and the BIOS set up the memory correctly. It could be
continuous ecc faults (eg if the kernel puts something critical in an iffy
spot in the DIMM and NT didnt) but that sounds dubious.

Alan
