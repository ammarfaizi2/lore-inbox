Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314379AbSESMY6>; Sun, 19 May 2002 08:24:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314380AbSESMY5>; Sun, 19 May 2002 08:24:57 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:47116 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S314379AbSESMY4>; Sun, 19 May 2002 08:24:56 -0400
Subject: Re: AUDIT: copy_from_user is a deathtrap.
To: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Sun, 19 May 2002 13:22:12 +0100 (BST)
Cc: torvalds@transmeta.com (Linus Torvalds),
        rusty@rustcorp.com.au (Rusty Russell), linux-kernel@vger.kernel.org,
        alan@lxorguk.ukuu.org.uk
In-Reply-To: <20020518214717.3526@smtp.wanadoo.fr> from "Benjamin Herrenschmidt" at May 18, 2002 10:47:17 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E179PhU-0003hU-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Looking at generic_file_write(), it ignore the count returned by
> copy_from_user and always commit a write for the whole requested
> count, regardless of how much could actually be read from userland.

It has to commit the write for the entire block. That is needed to get
the disk sectors correct versus another reader. The error reporting may
not be berfect however

Alan
