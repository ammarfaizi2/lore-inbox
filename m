Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261492AbVCNNfo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261492AbVCNNfo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 08:35:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261495AbVCNNfo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 08:35:44 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:9377 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S261492AbVCNNfg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 08:35:36 -0500
Subject: Re: User mode drivers: part 1, interrupt handling (patch
	for	2.6.11)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Peter Chubb <peterc@gelato.unsw.edu.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <16948.54411.754999.668332@wombat.chubb.wattle.id.au>
References: <16945.4650.250558.707666@berry.gelato.unsw.EDU.AU>
	 <1110568448.15927.74.camel@localhost.localdomain>
	 <16948.54411.754999.668332@wombat.chubb.wattle.id.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1110807209.15943.115.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 14 Mar 2005 13:33:31 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-03-14 at 00:02, Peter Chubb wrote:
> I can see there'd be problems if the code allowed shared interrupts,
> but it doesn't.

If you don't allow shared IRQ's its useless, if you do allow shared
IRQ's it deadlocks. Take your pick 8)

As to your comment about needing to do a few more I/O operations I
agree. However if your need is for speed then you might want to just
write a small IRQ helper module for the kernel or extend the syntax I
proposed a little (its conveniently trivial to generate native code from
this). 

There isn't much you can do about the status read without MWI on most
chip designs (some get it right by posting status to system memory but
not many)

Alan

