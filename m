Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315388AbSESWYr>; Sun, 19 May 2002 18:24:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315428AbSESWYq>; Sun, 19 May 2002 18:24:46 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:27408 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S315388AbSESWYp>; Sun, 19 May 2002 18:24:45 -0400
Subject: Re: AUDIT: copy_from_user is a deathtrap.
To: froese@gmx.de (Edgar Toernig)
Date: Sun, 19 May 2002 23:44:41 +0100 (BST)
Cc: torvalds@transmeta.com (Linus Torvalds), ak@suse.de (Andi Kleen),
        linux-kernel@vger.kernel.org, rusty@rustcorp.com.au,
        alan@lxorguk.ukuu.org.uk
In-Reply-To: <3CE809C0.59C4CBD5@gmx.de> from "Edgar Toernig" at May 19, 2002 10:23:28 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E179ZPt-0004Uk-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Oh, like read() or write() for regular files? Yup, they exist.
> 
> And that would be?  I've never seen such an abomination.  Sure,
> mapping pages on SEGV is use, but passing only partially mapped
> buffers to read/write on purpose???

Some of the storage systems do this. They may try to use the host page
size but on some platforms the host page size is variable so that isnt
feasible.

