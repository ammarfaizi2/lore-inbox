Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293161AbSCSABl>; Mon, 18 Mar 2002 19:01:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293314AbSCSABW>; Mon, 18 Mar 2002 19:01:22 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:31493 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S293161AbSCSABL>; Mon, 18 Mar 2002 19:01:11 -0500
Subject: Re: VFS mediator?
To: trond.myklebust@fys.uio.no (Trond Myklebust)
Date: Tue, 19 Mar 2002 00:15:49 +0000 (GMT)
Cc: pavel@suse.cz (Pavel Machek), viro@math.psu.edu (Alexander Viro),
        alan@lxorguk.ukuu.org.uk (Alan Cox),
        Simon.Richter@phobos.fachschaften.tu-muenchen.de (Simon Richter),
        jbarker@ebi.ac.uk (Jonathan Barker), linux-kernel@vger.kernel.org
In-Reply-To: <shs1yeha5b4.fsf@charged.uio.no> from "Trond Myklebust" at Mar 18, 2002 11:18:07 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16n7I5-0006SA-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>      > Does not work... If you mount nfs server on localhost, you can
>      > deadlock.
> 
> Huh? Examples please? A hell of a lot of work has gone into ensuring
> that this cannot happen. I do most of my NFS client work on this sort
> of setup, so it had bloody well better work...

At least theoretically it can. Imagine you have every other process stuck
trying to page out (or blocked on a page out) over NFS, including your
user mode nfs process. In practice it would be very hard to arrange but
the theory is real.

Alan
