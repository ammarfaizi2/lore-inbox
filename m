Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277402AbRJHWYp>; Mon, 8 Oct 2001 18:24:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277388AbRJHWYf>; Mon, 8 Oct 2001 18:24:35 -0400
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:44293 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S277402AbRJHWYb>; Mon, 8 Oct 2001 18:24:31 -0400
Date: Tue, 9 Oct 2001 00:21:04 +0200 (CEST)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Rik van Riel <riel@conectiva.com.br>,
        Krzysztof Rusocki <kszysiu@main.braxis.co.uk>, linux-xfs@oss.sgi.com,
        linux-kernel@vger.kernel.org
Subject: Re: %u-order allocation failed
In-Reply-To: <E15qLzV-00071D-00@the-village.bc.nu>
Message-ID: <Pine.LNX.3.96.1011009001720.20446A-100000@artax.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 Oct 2001, Alan Cox wrote:

> > The difference between memory and vmalloc space is this: you fill up the
> > whole memory with cache => memory fragments. You don't fill up the whole
> > vmalloc space with anything => vmalloc space doesn't fragment.
> 
> vmalloc space fragments. You fragment address space rather than pages thats
> all. Same problem

If you have more than half of virtual space free, you can always find two
consecutive free pages. Period.

You can fill up half of virtual space if you start 4096 processes or load
many modules of total size 32M. Is it clear? Do you realize that no one
will ever hit this limit in typical linux configuration? 

Mikulas

