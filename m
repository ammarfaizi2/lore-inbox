Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315503AbSESWfO>; Sun, 19 May 2002 18:35:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315514AbSESWfN>; Sun, 19 May 2002 18:35:13 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:31504 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S315503AbSESWfL>; Sun, 19 May 2002 18:35:11 -0400
Subject: Re: AUDIT of 2.5.15 copy_to/from_user
To: dwmw2@infradead.org (David Woodhouse)
Date: Sun, 19 May 2002 23:54:38 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), rui.sousa@laposte.net (Rui Sousa),
        rusty@rustcorp.com.au (Rusty Russell), linux-kernel@vger.kernel.org,
        kernel-janitor-discuss@lists.sourceforge.net
In-Reply-To: <12975.1021831347@redhat.com> from "David Woodhouse" at May 19, 2002 07:02:27 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E179ZZW-0004W4-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> alan@lxorguk.ukuu.org.uk said:
> > > > After that we always use __copy_from_user() and we trust it not to fail. 
> > > This is correct 
> 
> > The only check done in access_ok on x86 is the 0xC0000000->0xFFFFFFFF
> > check with isnt affected by remappings. 
> 
> Right.... so trusting __copy_to_user() not to fail doesn't seem 
> particularly correct.

EFAULT reporting is not required by posix. Its not so much incorrect as
slightly rude..
