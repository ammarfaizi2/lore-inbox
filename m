Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275686AbRIZXIm>; Wed, 26 Sep 2001 19:08:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275688AbRIZXId>; Wed, 26 Sep 2001 19:08:33 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:46857 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S275686AbRIZXIT>; Wed, 26 Sep 2001 19:08:19 -0400
Subject: Re: SIGSTOP/CONT behaviour
To: christian.jaeger@sl.ethz.ch (Christian Jaeger)
Date: Thu, 27 Sep 2001 00:13:12 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010927004617.3ffcb95b.christian.jaeger@sl.ethz.ch> from "Christian Jaeger" at Sep 27, 2001 12:46:17 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15mNrc-0002CV-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If I send a SIGSTOP to another process, I can NOT rely on him not
> running anymore after the kill syscall returns. Is that right? I think

Correct in specific narrow windows.  A signal is an asynchronous event

> Additionally I could imagine there isn't even a guarantee that the
> process won't execute userland code anymore in the case of SMP?

Yep.

> (What I wanted to do is stop several file serving daemons
> (ftp,samba,netatalk) from fiddling with the filesystem while I traverse
> through a file tree. I need to make sure I don't get files twice because
> they have been moved while traversing and so on. I would not mind that
> much about file *contents* changing, though. I'd welcome other
> suggestions that don't imply changing the source code of these servers.)

I guess if you arent doing it often you could kill them then check they
are in stopped state but thats icky. 

Alan
