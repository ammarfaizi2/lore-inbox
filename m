Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313190AbSEVNKT>; Wed, 22 May 2002 09:10:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313201AbSEVNKS>; Wed, 22 May 2002 09:10:18 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:21008 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S313190AbSEVNKS>; Wed, 22 May 2002 09:10:18 -0400
Subject: Re: AUDIT: copy_from_user is a deathtrap.
To: rusty@rustcorp.com.au (Rusty Russell)
Date: Wed, 22 May 2002 14:30:40 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), pavel@suse.cz,
        linux-kernel@vger.kernel.org
In-Reply-To: <20020522145746.69756cf5.rusty@rustcorp.com.au> from "Rusty Russell" at May 22, 2002 02:57:46 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17AWCO-0001gi-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Because the standard says either you return the errorcode and no data
> > is transferred or for a partial I/O you return how much was done.
> 
> Hmm... I can't find anything like that in SuSv2: can you give a reference?
> And we're already violating that for the write() case.

The we should fix the bug. Its explicitly covered in SuSv3 because that
incorporates the posix text. Its also discussed in things like 1003.1g
drafts in great detail (sockets have very explicit ordering for error
reporting)
