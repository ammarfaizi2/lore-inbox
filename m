Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316582AbSINNbM>; Sat, 14 Sep 2002 09:31:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316610AbSINNbM>; Sat, 14 Sep 2002 09:31:12 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:7666 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316582AbSINNbL>; Sat, 14 Sep 2002 09:31:11 -0400
Subject: Re: Possible bug and question about ide_notify_reboot in
	drivers/ide/ide.c (2.4.19)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020914095356.GA28271@merlin.emma.line.org>
References: <20020914010101.75725.qmail@web40502.mail.yahoo.com> 
	<20020914095356.GA28271@merlin.emma.line.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-7) 
Date: 14 Sep 2002 14:37:35 +0100
Message-Id: <1032010655.12892.8.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-09-14 at 10:53, Matthias Andree wrote:
> How about this: The FLUSH CACHE command has only recently become a
> mandatory command for non-PACKET devices, so there may be drives that do
> implement a write cache, but do NOT implement the FLUSH CACHE -- and
> still adhere to some older edition of the ATA standard.

Worse than that. There are drives that did implement it - as a no-op.
They didn't even say "Umm sorry no can do"

> See above. Disable Write Cache would also do with recent drives.

Except some drives have a habit of turning it back on quietly

> If I recall correctly, Windows' shutdown procedure was at some time in
> the past changed to wait a couple of seconds before switching the ATX
> computers off, to allow the drives to flush their caches. I can't quote
> on a KB article though.

Flush on shutdown was apparently one of the windows 98 service pack/hot
fix additions.

