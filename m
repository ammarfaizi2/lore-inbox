Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277646AbRJHXyw>; Mon, 8 Oct 2001 19:54:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277631AbRJHXym>; Mon, 8 Oct 2001 19:54:42 -0400
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:59142 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S277644AbRJHXye>; Mon, 8 Oct 2001 19:54:34 -0400
Date: Tue, 9 Oct 2001 01:54:49 +0200 (CEST)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Rik van Riel <riel@conectiva.com.br>,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>,
        Krzysztof Rusocki <kszysiu@main.braxis.co.uk>, linux-xfs@oss.sgi.com,
        linux-kernel@vger.kernel.org
Subject: Re: %u-order allocation failed
In-Reply-To: <Pine.LNX.4.33.0110081647550.1064-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.3.96.1011009015250.16178A-100000@artax.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Oct 2001, Linus Torvalds wrote:

> 
> On Tue, 9 Oct 2001, Mikulas Patocka wrote:
> >
> > Linus, what do you think: is it OK if fork randomly fails with very small
> > probability or not?
> 
> I've never seen it, I've never heard it reported, and I _know_ that
> vmalloc() causes slowdowns.
> 
> In short, I'm not switching to a vmalloc() fork.

The patch uses buddy by default and does vmalloc only if buddy fails.
Slowdown is not an issue here.

Mikulas

