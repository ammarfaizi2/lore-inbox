Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129771AbRACWcT>; Wed, 3 Jan 2001 17:32:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130319AbRACWcK>; Wed, 3 Jan 2001 17:32:10 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:55786 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S129226AbRACWby>;
	Wed, 3 Jan 2001 17:31:54 -0500
Date: Wed, 3 Jan 2001 17:31:30 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Dan Hollis <goemon@anime.net>
cc: Dan Aloni <karrde@callisto.yi.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, mark@itsolve.co.uk
Subject: Re: [RFC] prevention of syscalls from writable segments, breaking
 bug exploits
In-Reply-To: <Pine.LNX.4.30.0101031406160.31664-100000@anime.net>
Message-ID: <Pine.GSO.4.21.0101031716000.17363-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 3 Jan 2001, Dan Hollis wrote:

> On Wed, 3 Jan 2001, Alexander Viro wrote:
> > On Wed, 3 Jan 2001, Dan Aloni wrote:
> > > without breaking anything. It also reports of such calls by using printk.
> > Get real.
> 
> Why do you always have to be insulting alex? Sheesh.

Sigh... Not intended to be an insult. Plain and simple advice. Idea is
broken for absolutely obvious reasons (namely, every real-life program
contains at least one syscall that it _can_ execute). Expecting _any_
part of userland to be rewritten into the form that would not have
such places (i.e. all IO is done by trusted processes that poll
memory areas shared with the programs needing said IO, exit is done
either by explicit kill() from another process or by dumping core, signals
are done by putting request into shared area and letting a trusted process
do the thing, etc.) warrants such suggestion, doesn't it? If somebody
seriously believes that it can be done (and that's the only way how this
patch could give any protection)... Well, scratch "get real", I've got a
nice bridge for sale.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
