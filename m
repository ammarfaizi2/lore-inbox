Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269748AbRHIJGt>; Thu, 9 Aug 2001 05:06:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269752AbRHIJGj>; Thu, 9 Aug 2001 05:06:39 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:5394 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S269748AbRHIJGd>; Thu, 9 Aug 2001 05:06:33 -0400
Subject: Re: Swapping for diskless nodes
To: dws@dirksteinberg.de (Dirk W. Steinberg)
Date: Thu, 9 Aug 2001 10:08:37 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (linux-kernel@vger.kernel.org)
In-Reply-To: <no.id> from "Dirk W. Steinberg" at Aug 09, 2001 09:51:42 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15Ulnx-0006zZ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> what is the best/recommended way to do remote swapping via the network
> for diskless workstations or compute nodes in clusters in Linux 2.4?=20
> Last time i checked was linux 2.2, and there were some races related=20
> to network swapping back then. Has this been fixed for 2.4?

The best answer probably is "don't". Networks are high latency things for
paging and paging is latency sensitive. If performance is not an issue then
the nbd driver ought to work. You may need to check it uses the right
GFP_ levels to avoid deadlocks and you might need to up the amount of atomic
pool memory. Hopefully other hacks arent needed

[The general case of network swap is basically insoluble but its possible to
 make it perfectly usable as Sun proved]

Alan
