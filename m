Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271931AbRIQRXQ>; Mon, 17 Sep 2001 13:23:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271921AbRIQRW5>; Mon, 17 Sep 2001 13:22:57 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:48910 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S271918AbRIQRWr>; Mon, 17 Sep 2001 13:22:47 -0400
Subject: Re: [Q] Implementation of spin_lock on i386: why "rep;nop" ?
To: saffroy@ri.silicomp.fr (Jean-Marc Saffroy)
Date: Mon, 17 Sep 2001 18:27:44 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, linux-smp@vger.kernel.org
In-Reply-To: <Pine.LNX.4.31.0109171725140.26090-100000@sisley.ri.silicomp.fr> from "Jean-Marc Saffroy" at Sep 17, 2001 06:16:48 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15j2BM-0007WU-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The "rep;nop" line looks dubious, since the IA-32 programmer's manual from
> Intel (year 2001) mentions that the behaviour of REP is undefined when it
> is not used with string opcodes. BTW, according to the same manual, REP is
> supposed to modify ecx, but it looks like is is not the case here... which
> is fortunate, since ecx is never saved. :-)

rep nop is a pentium IV operation. Its retroactively after testing defined
to be portable and ok. 

Alan
