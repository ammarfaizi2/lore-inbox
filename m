Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272142AbTG2W30 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 18:29:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272143AbTG2W30
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 18:29:26 -0400
Received: from fed1mtao04.cox.net ([68.6.19.241]:12715 "EHLO
	fed1mtao04.cox.net") by vger.kernel.org with ESMTP id S272142AbTG2W3Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 18:29:25 -0400
Date: Tue, 29 Jul 2003 15:29:21 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Bernardo Innocenti <bernie@develer.com>
Cc: Willy Tarreau <willy@w.ods.org>, Christoph Hellwig <hch@lst.de>,
       uClinux development list <uclinux-dev@uclinux.org>,
       linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [uClinux-dev] Kernel 2.6 size increase
Message-ID: <20030729222921.GK16051@ip68-0-152-218.tc.ph.cox.net>
References: <200307232046.46990.bernie@develer.com> <200307240007.15377.bernie@develer.com> <20030723222747.GF643@alpha.home.local> <200307242227.16439.bernie@develer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307242227.16439.bernie@develer.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 24, 2003 at 10:27:16PM +0200, Bernardo Innocenti wrote:
> On Thursday 24 July 2003 00:27, Willy Tarreau wrote:
> 
> > On Thu, Jul 24, 2003 at 12:07:15AM +0200, Bernardo Innocenti wrote:
> > >    text    data     bss     dec     hex filename
> > >  633028   37952  134260  805240   c4978 linux-2.4.x/linux-Os
> > >  819276   52460   78896  950632   e8168 linux-2.5.x/vmlinux-inline-Os
> > >  ^^^^^^
> > >        2.6 still needs a hard diet... :-/
> >
> > I did the same observation a few weeks ago on 2.5.74/gcc-2.95.3. I tried
> > to track down the responsible, to the point that I completely disabled
> > every driver, networking option and file-system, just to see, and got about
> > a 550 kB vmlinux compiled with -Os. 550 kB for nothing :-(
> 
> Some of the bigger 2.6 additions cannot be configured out.
> I wish sysfs and the different I/O schedulers could be removed.
> 
> There are probably many other things mostly useless for embedded
> systems that I'm not aware of.

Well, from Pat's talk at OLS, it seems like sysfs would be an important
part of 'sleep', which is something at least some embedded systems care
about.

... not that 2.6 doesn't need some good pruning options now, but maybe
CONFIG_EMBEDDED isn't the right place to put them all.

-- 
Tom Rini
http://gate.crashing.org/~trini/
