Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266076AbTLIRFj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 12:05:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266078AbTLIRFj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 12:05:39 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:8672
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S266076AbTLIRFe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 12:05:34 -0500
Date: Tue, 9 Dec 2003 18:06:53 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Kristian Peters <kristian.peters@korseby.net>,
       linux-kernel@vger.kernel.org,
       "Robert L. Harris" <Robert.L.Harris@rdlg.net>
Subject: Re: oom killer in 2.4.23
Message-ID: <20031209170653.GO12532@dualathlon.random>
References: <Z6Iv-7O2-29@gated-at.bofh.it> <Z8Ag-3BK-3@gated-at.bofh.it> <Zbyn-23P-29@gated-at.bofh.it> <20031205140520.39289a3a.kristian.peters@korseby.net> <20031205195800.GB2121@dualathlon.random> <20031206103143.027ba4ec.kristian.peters@korseby.net> <20031209142151.GB12532@dualathlon.random> <Pine.LNX.4.53.0312090942470.8772@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0312090942470.8772@chaos>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 09, 2003 at 09:52:13AM -0500, Richard B. Johnson wrote:
> On Tue, 9 Dec 2003, Andrea Arcangeli wrote:
> 
> > On Sat, Dec 06, 2003 at 10:31:43AM +0100, Kristian Peters wrote:
> > > Andrea Arcangeli <andrea@suse.de> schrieb:
> > > > what you're complaining is the 'selection of the task to be killed'.
> > > > That's not solvable. the kernel can't read your brain period. Only if
> > > > the kernel could read the brain of the adminstrator then you would be
> > > > happy, there is no way the kernel can know which is the task you really
> > > > want to have killed first.
> > >
> > > I agree. On a server the most likely application to be killed would be the service with the most pages in memory. And those services tend to be the important ones.
> > >
> > > However, for a simple desktop-linux that statistical approach seems to
> > > be wrong. Your vm has even killed /sbin/getty sometimes, so that I
> > > can't login via a simple console.
> >
> 
> Not true! Killing a getty or agetty or any other login
> program cannot prevent a login! Init will just start another

killing getty is a very very lucky scenario indeed. the way I read it
was that agetty can hardly be a mem eater, and in turn the same way
agetty was killed, it could have been ssh or X to be killed. That's
true, but the same issues on the desktop will happen if you have no swap
if you enable the old oom killer, the vm will go nuts even if you don't
run oom, and there will be all other sort of troubles mentioned a few
times already.
