Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314707AbSESSA7>; Sun, 19 May 2002 14:00:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314748AbSESSA6>; Sun, 19 May 2002 14:00:58 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:46606 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S314707AbSESSA5>; Sun, 19 May 2002 14:00:57 -0400
Subject: Re: AUDIT of 2.5.15 copy_to/from_user
To: dwmw2@infradead.org (David Woodhouse)
Date: Sun, 19 May 2002 19:20:23 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), rui.sousa@laposte.net (Rui Sousa),
        rusty@rustcorp.com.au (Rusty Russell), linux-kernel@vger.kernel.org,
        kernel-janitor-discuss@lists.sourceforge.net
In-Reply-To: <12687.1021830756@redhat.com> from "David Woodhouse" at May 19, 2002 06:52:36 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E179VI7-0004AY-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > After that we always use __copy_from_user() and we trust it not to fail. 
> > > Is this correct, or not?
> 
> > This is correct 
> 
> Even if another thread unmaps the page we were trying to read from between 
> the access_ok() and the actual copy?

Yes.

The only check done in access_ok on x86 is the 0xC0000000->0xFFFFFFFF check
with isnt affected by remappings. 
