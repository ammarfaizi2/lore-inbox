Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271064AbTHKJdH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 05:33:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271380AbTHKJdH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 05:33:07 -0400
Received: from mail3.ithnet.com ([217.64.64.7]:55977 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S271064AbTHKJdF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 05:33:05 -0400
X-Sender-Authentication: SMTPafterPOP by <info@euro-tv.de> from 217.64.64.14
Date: Mon, 11 Aug 2003 11:33:02 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: marcelo@conectiva.com.br, akpm@osdl.org, andrea@suse.de,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: 2.4.22-pre lockups (now decoded oops for pre10)
Message-Id: <20030811113302.6f30a256.skraw@ithnet.com>
In-Reply-To: <16182.54248.868067.968522@gargle.gargle.HOWL>
References: <20030808170536.23118033.skraw@ithnet.com>
	<Pine.LNX.4.44.0308081232430.8384-100000@logos.cnet>
	<20030810233526.0f7bf65b.skraw@ithnet.com>
	<16182.54248.868067.968522@gargle.gargle.HOWL>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Aug 2003 09:23:20 +1000
Neil Brown <neilb@cse.unsw.edu.au> wrote:

> On Sunday August 10, skraw@ithnet.com wrote:
> > 
> > From looking at the tests so far I would say the setup is remarkably slower
> > in terms of writing to ext3 via nfs and sync option set. I think especially
> > the"sync" is very visible - unlike reiserfs.
> 
>   data=journal
> makes nfsd go noticable faster over ext3.  Having an external journal
> is even better.

Uh, forgive my ignorance. "journal" means metadata+data journaling. If I have
large data movement, how can that be even faster? Ok, I see the facts around
sync'ing the fs. But anyway the data size written should be nearly doubled
compared to data=ordered. Reiserfs journaling has to be real incredible in
comparison to ext3(ordered). I have the impression that large files are hit
most.


Regards,
Stephan
