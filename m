Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270649AbTGUSdQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 14:33:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270651AbTGUSdQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 14:33:16 -0400
Received: from dhcp176.linuxsymposium.org ([209.151.19.176]:31872 "EHLO
	x30.random") by vger.kernel.org with ESMTP id S270649AbTGUSdL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 14:33:11 -0400
Date: Mon, 21 Jul 2003 12:20:33 -0400
From: Andrea Arcangeli <andrea@suse.de>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: marcelo@conectiva.com.br, mason@suse.com, riel@redhat.com,
       linux-kernel@vger.kernel.org, maillist@jg555.com
Subject: Re: Bug Report: 2.4.22-pre5: BUG in page_alloc (fwd)
Message-ID: <20030721162033.GA4677@x30.linuxsymposium.org>
References: <Pine.LNX.4.55L.0307150859130.5146@freak.distro.conectiva> <1058297936.4016.86.camel@tiny.suse.com> <Pine.LNX.4.55L.0307160836270.30825@freak.distro.conectiva> <20030718112758.1da7ab03.skraw@ithnet.com> <Pine.LNX.4.55L.0307180921120.6642@freak.distro.conectiva> <20030718145033.5ff05880.skraw@ithnet.com> <Pine.LNX.4.55L.0307181109220.7889@freak.distro.conectiva> <20030721104906.34ae042a.skraw@ithnet.com> <20030721170517.1dd1f910.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030721170517.1dd1f910.skraw@ithnet.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 21, 2003 at 05:05:17PM +0200, Stephan von Krawczynski wrote:
> On Mon, 21 Jul 2003 10:49:06 +0200
> Stephan von Krawczynski <skraw@ithnet.com> wrote:
> 
> > On Fri, 18 Jul 2003 11:14:15 -0300 (BRT)
> > Marcelo Tosatti <marcelo@conectiva.com.br> wrote:
> > 
> > > 
> > > I have just started stress testing a 8way OSDL box to see if I can
> > > reproduce the problem. I'm using pre6+axboes BH_Sync patch.
> > > 
> > > I'm running 50 dbench clients on aic7xxx (ext2) and 50 dbench clients on
> > > DAC960 (ext3). Lets see what happens.
> > > 
> > > After lunch I'll keep looking at the oopses. During the morning I only had
> > > time to setup the OSDL box and start the tests.
> > 
> > Hello Marcelo,
> > 
> > have you seen anything in your tests? My box just froze again after 3 days
> > during NFS action. This was with pre6, I am switching over to pre7.
> 
> I managed to freeze the pre7 box within these few hours. There was no nfs
> involved, only tar-to-tape.
> I switched back to 2.4.21 to see if it is still stable.
> Is there a possibility that the i/o-scheduler has another flaw somewhere (just
> like during mount previously) ...

is it a scsi tape? Is the tape always involved? there are st.c updates
between 2.4.21 to 22pre7. you can try to back them out.

If only the BKCVS would provide the tags in all files and not only in
the file ChangeSets it would be very easy again to extract all the st.c
updates. What happened to the BKCVS, why aren't the tags present in all
the files anymore? Is it a mistake or intentional?

You should also provide a SYSRQ+P/T of the hang or we can't debug it at
all.

Andrea
