Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314690AbSESRQP>; Sun, 19 May 2002 13:16:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314702AbSESRQO>; Sun, 19 May 2002 13:16:14 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:28430 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S314690AbSESRQN>; Sun, 19 May 2002 13:16:13 -0400
Subject: Re: AUDIT of 2.5.15 copy_to/from_user
To: hugh@veritas.com (Hugh Dickins)
Date: Sun, 19 May 2002 18:36:06 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), rui.sousa@laposte.net (Rui Sousa),
        rusty@rustcorp.com.au (Rusty Russell), linux-kernel@vger.kernel.org,
        kernel-janitor-discuss@lists.sourceforge.net
In-Reply-To: <Pine.LNX.4.21.0205191755200.9972-100000@localhost.localdomain> from "Hugh Dickins" at May 19, 2002 06:01:31 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E179UbG-000473-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sun, 19 May 2002, Alan Cox wrote:
> > > 
> > > On the emu10k1 driver we use access_ok(VERIFY_READ) once at the beginning
> > > of the write() routine to check we can access the user buffer. After that 
> > > we always use __copy_from_user() and we trust it not to fail. Is this 
> > > correct, or not?
> > 
> > This is correct
> 
> Am I right to read that as "This is a correct description of what is
> currently done in the emu10k1 driver, but what it is doing is incorrect"?

It seems correct in what it is doing, to a point. copy_from_user won't ever
fail in a fatal manner. It may not copy enough data and zero fill returning
an error code. Reporting of that error isnt required however, its just
good manners
