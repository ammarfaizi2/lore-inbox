Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271932AbTHNIpW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 04:45:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272229AbTHNIpW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 04:45:22 -0400
Received: from angband.namesys.com ([212.16.7.85]:45210 "EHLO
	angband.namesys.com") by vger.kernel.org with ESMTP id S271932AbTHNIpU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 04:45:20 -0400
Date: Thu, 14 Aug 2003 12:45:18 +0400
From: Oleg Drokin <green@namesys.com>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: marcelo@conectiva.com.br, akpm@osdl.org, andrea@suse.de,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org, mason@suse.com
Subject: Re: 2.4.22-pre lockups (now decoded oops for pre10)
Message-ID: <20030814084518.GA5454@namesys.com>
References: <20030813125509.360c58fb.skraw@ithnet.com> <Pine.LNX.4.44.0308131143570.4279-100000@localhost.localdomain> <20030813145940.GC26998@namesys.com> <20030813171224.2a13b97f.skraw@ithnet.com> <20030813153009.GA27209@namesys.com> <20030813163452.GC27515@namesys.com> <20030814001953.1505bda4.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030814001953.1505bda4.skraw@ithnet.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> > You seem to be getting corruptions in at least 2 days for now, though.
> > And reiserfs seems to trigger the problem even faster (and may be
> > even more faster if you enable CONFIG_REISERFS_CHECK).
> well, I have an idea how to find out more about these verify problem. Basically
> I would try to patch tar to ouput the differing areas to stdout in hexdump
> format or the like. Only I need some time to make this work out. I hope to find
> some pattern about this corruption. 

Yes, that would be interesting.

> > > If we can add "ext3 does not crash" to the list, then I really hope we can
> > > use some brain and give good selection of patches between 2.4.20 and 2.4.21
> > > that may cause the troubles.
> > There were not much changes in reiserfs. All those patches can easily be
> > reverted just for verification purposes. Let me know when you are ready/want
> > to test this variant and I will send you a diff.
> Hm, my primary belief is that something _around_ reiserfs has changed
> semantics.

Well. Might be, but this is unlikely. And I do not remember anything like that.
I will take a closer look, though.

> > > If possible I can then patch out all of them and retry. So there is much
> > > less time spent for testing. 
> > > I mean, have you looked at the length of this thread already?
> > Yes, I did.
> > Now if only we can get someone to reproduce your problems...
> Hm, I believe nobody in fact tried a setup like mine. As I have clear
> indication that I can trigger it simply by using an SMP box, installing SuSE
> 8.2, compiling stock 2.4.22-rc2 kernel exporting some reiserfs to a nfs-client
> of your choice and starting copying data with sizes around 100GB back and
> forth.

sounds like quite typical setup for some tasks (like clusters I guess).

> > > > Probably it would be easier for you to make it crash (if there are crash
> > > > possibility at all) if you enable JBD debugging.
> > > I have never seen this in real life. Is it possible to turn this on when
> > > handling >100 GB of data or will some debug output flood the box?
> > It only enables some more checks, not debug output.
> Does this work for ext3, reiserfs or both?

This works for ext3
For reiserfs we have similar compile time option that is called
CONFIG_REISERFS_CHECK 

Thank you for all the time and efforts you are putting into finding out
the cause.

Bye,
    Oleg
