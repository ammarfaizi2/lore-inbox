Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263252AbSJOOFM>; Tue, 15 Oct 2002 10:05:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263256AbSJOOFM>; Tue, 15 Oct 2002 10:05:12 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:4489 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S263252AbSJOOFL>; Tue, 15 Oct 2002 10:05:11 -0400
Date: Tue, 15 Oct 2002 12:10:46 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@duckman.distro.conectiva
To: Pavel Machek <pavel@suse.cz>
Cc: Hu Gang <hugang@soulinfo.com>, <linux-kernel@vger.kernel.org>
Subject: Re: patch for 2.5.42. 2/2
In-Reply-To: <20021014185202.C585@elf.ucw.cz>
Message-ID: <Pine.LNX.4.44L.0210151208300.1648-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Oct 2002, Pavel Machek wrote:

> > This looks like a serious design mistake.  Surely it would be
> > better to just have the network layer stop operations when the
> > system is going into suspend, instead of having to modify 100
> > individual network drivers ?
>
> Whole userland is stopped at that point. That should mean that new
> requests can not come.
>
> OTOH packet from the network *can* come, and higher levels can not do
> much with that.

Higher layers can throw away the packet.  This means you just
need to modify the higher layer at one or two places, instead
of needing to modify every single network driver out there.

I don't need to tell you which of these two options is gonna
be the easiest to maintain, do I ?

regards,

Rik
-- 
A: No.
Q: Should I include quotations after my reply?

http://www.surriel.com/		http://distro.conectiva.com/

