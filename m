Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317149AbSEXPzU>; Fri, 24 May 2002 11:55:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314457AbSEXPzQ>; Fri, 24 May 2002 11:55:16 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:4621 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S317149AbSEXPyW>; Fri, 24 May 2002 11:54:22 -0400
Subject: Re: Quota patches
To: dalecki@evision-ventures.com (Martin Dalecki)
Date: Fri, 24 May 2002 17:14:02 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), jack@suse.cz (Jan Kara),
        nathans@sgi.com (Nathan Scott),
        torvalds@transmeta.com (Linus Torvalds),
        hirofumi@mail.parknet.co.jp (OGAWA Hirofumi),
        linux-kernel@vger.kernel.org
In-Reply-To: <3CEE4ECB.5070603@evision-ventures.com> from "Martin Dalecki" at May 24, 2002 04:31:39 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17BHha-0006m7-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It is an illusion to think that you can actually run *that old*
> a.out binaries on a modern kernel I think.
> 
> BTW. (almost no space) * (many times) == huge number.

Uninline copy*user and a few other things then. Fix the size of struct
page. Add a CONFIG_SMALL where users can pick to have very small hash tables
on older systems with little RAM.  Add the two extra common slab sizes 
people identified

This kind of stuff tends to save you hundreds of K yet nobody is doing that
before even worrying about some trivial 150 bytes.
