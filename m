Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314321AbSESLVo>; Sun, 19 May 2002 07:21:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314330AbSESLVn>; Sun, 19 May 2002 07:21:43 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:15372 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S314321AbSESLVn>; Sun, 19 May 2002 07:21:43 -0400
Subject: Re: AUDIT: copy_from_user is a deathtrap.
To: torvalds@transmeta.com (Linus Torvalds)
Date: Sun, 19 May 2002 12:41:41 +0100 (BST)
Cc: rusty@rustcorp.com.au (Rusty Russell), linux-kernel@vger.kernel.org,
        alan@lxorguk.ukuu.org.uk
In-Reply-To: <Pine.LNX.4.44.0205182210330.878-100000@home.transmeta.com> from "Linus Torvalds" at May 18, 2002 10:23:05 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E179P4H-0003dO-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Oh, read() has to return the right value, but we should _also_ do a
> SIGSEGV, in my opinion (it would also catch all those programs that didn't
> expect it).
> 
> However, that apparently flies in the face of UNIX history and apparently
> some standard (whether it was POSIX or SuS or something else, I can't
> remember, but that discussion came up earlier..)

Unix history I think

Posix doesnt care - indeed it can be that a posix system has no memory
protection or kernel/user divide. SuS seems to simply leave passing bogus
addresses as undefined

Alan
