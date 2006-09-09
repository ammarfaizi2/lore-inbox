Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932241AbWIIOrO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932241AbWIIOrO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 10:47:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932235AbWIIOrO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 10:47:14 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:47794 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932243AbWIIOrL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 10:47:11 -0400
Subject: Re: Opinion on ordering of writel vs. stores to RAM
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Paul Mackerras <paulus@samba.org>,
       linux-kernel@vger.kernel.org, akpm@osdl.org, segher@kernel.crashing.org,
       davem@davemloft.net
In-Reply-To: <1157786600.31071.166.camel@localhost.localdomain>
References: <17666.8433.533221.866510@cargo.ozlabs.ibm.com>
	 <Pine.LNX.4.64.0609081928570.27779@g5.osdl.org>
	 <1157786600.31071.166.camel@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 09 Sep 2006 16:09:51 +0100
Message-Id: <1157814591.6877.29.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Sad, 2006-09-09 am 17:23 +1000, ysgrifennodd Benjamin Herrenschmidt:
> The problem is that very few people have any clear idea of what mmiowb
> is :) In fact, what you described is not the definition of mmiowb
> according to Jesse 

Some of us talked a little about this at Linux Kongress and one
suggestion so people did understand it was

	spin_lock_io();
	spin_unlock_io();

so that it can be expressed not as a weird barrier op but as part of the
locking.

