Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262714AbTFXWHF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 18:07:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263212AbTFXWHE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 18:07:04 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:23305 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S262714AbTFXWFo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 18:05:44 -0400
Date: Wed, 25 Jun 2003 00:03:31 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: Willy Tarreau <willy@w.ods.org>, linux-kernel@vger.kernel.org,
       marcelo@conectiva.com.br, kpfleming@cox.net, stoffel@lucent.com,
       gibbs@scsiguy.com, green@namesys.com
Subject: Re: Undo aic7xxx changes (now rc7+aic20030603)
Message-ID: <20030624220331.GB2019@alpha.home.local>
References: <20030509150207.3ff9cd64.skraw@ithnet.com> <41560000.1055306361@caspian.scsiguy.com> <20030611222346.0a26729e.skraw@ithnet.com> <16103.39056.810025.975744@gargle.gargle.HOWL> <20030613114531.2b7235e7.skraw@ithnet.com> <20030624174331.GA31650@alpha.home.local> <20030624232609.5887c159.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030624232609.5887c159.skraw@ithnet.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 24, 2003 at 11:26:09PM +0200, Stephan von Krawczynski wrote:
 
> sorry, you probably misunderstood my flaky explanation. What I meant was not a
> cached block from the _tape_ (obviously indeed a char-type device) but from the
> 3ware disk (i.e. the other side of the verification). Consider the tape
> completely working, but the disk data corrupt (possibly not from real reading
> but from corrupted cache).

Ah, OK ! I didn't understand this. You're right, this is also a possibility.
Perhaps a tar cf - /mnt/3ware | chkblk would get evidence of somme corruption ?

<...snip... OK for these points ...>
 
> Hm, interestingly the former freeze bug (solved by marcelo through backout of
> some patch in rc8) did not show up in UP. Since then I did not test UP any
> more. The problem itself does not necessarily point to flaky hardware, as I
> would have no idea how bad cache can only show up during a tape verification,
> that does not sound all that reasonable.

OK, I agree. And right after posting, I remembered that if this was the case,
you should also see some MCEs which doesn't seem to be your case.

> More likely could be a SMP race anywhere from nfs-server, 3ware disk driver to
> page cache, or not?

fairly possible. That's also what Justin suggested in the past, BTW :-)

Cheers,
Willy

