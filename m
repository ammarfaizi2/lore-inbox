Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316634AbSERCox>; Fri, 17 May 2002 22:44:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316640AbSERCow>; Fri, 17 May 2002 22:44:52 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:12050 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S316634AbSERCow>; Fri, 17 May 2002 22:44:52 -0400
Subject: Re: Question : Broadcast Inter Process Communication ?
To: jt@hpl.hp.com
Date: Sat, 18 May 2002 04:04:52 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (Linux kernel mailing list),
        alan@lxorguk.ukuu.org.uk (Alan Cox)
In-Reply-To: <20020517143052.A30047@bougret.hpl.hp.com> from "Jean Tourrilhes" at May 17, 2002 02:30:52 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E178uWc-0007mP-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	This "one sender - multiple reader" model seems common and
> usefull enough that there must be a way to do that under Linux. I know
> that it exist under Windows. Can somebody help me to find out how to
> do it under Linux ?

Its actually a nontrivial construct - especially since readers can vanish
and appear asynchronously during the lifetime of any event. You could 
implement it with multiple linked lists of pointers to refcounted objects,
and you could do that in user space (eg with shared memory), the chances
are that for all but the most extreme cases sending a copy of the event to
each listener is cheaper, simpler and more debuggable
