Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261519AbVEJE1W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261519AbVEJE1W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 00:27:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261551AbVEJE1W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 00:27:22 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:28269 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S261519AbVEJE1U
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 00:27:20 -0400
Date: Tue, 10 May 2005 06:28:28 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Kumar Gala <kumar.gala@freescale.com>
Cc: linuxppc-embedded list <linuxppc-embedded@ozlabs.org>,
       Tom Rini <trini@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       "<cpclark@xmission.com> <cpclark@xmission.com>" 
	<cpclark@xmission.com>
Subject: Re: PPC uImage build not reporting correctly
Message-ID: <20050510042828.GA8398@mars.ravnborg.org>
References: <Pine.LNX.4.63.0505061718380.6288@xmission.xmission.com> <b0aede90eb15562c0dd5a44c10d1b965@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0aede90eb15562c0dd5a44c10d1b965@freescale.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 09, 2005 at 10:19:01AM -0500, Kumar Gala wrote:
> 
> On May 6, 2005, at 6:22 PM, <cpclark@xmission.com> wrote:
> 
> >On Fri, 6 May 2005, Kumar Gala wrote:
> > > I tried the following w/o success:
> > >
> >> $(obj)/uImage: $(obj)/vmlinux.gz
> >>???????? $(Q)rm -f $@
> > >???????? $(call if_changed,uimage)
> >>???????? @echo '? Image: $@' $(shell if [ -f $@ ]; then echo 'is 
> >ready'; else
> > > echo 'not made'; fi)
> >
> >Couldn't you eliminate the ($shell ..) construct altogether, like 
> >this?:
> >
> >$(obj)/uImage: $(obj)/vmlinux.gz
> >??????? $(Q)rm -f $@
> > ??????? $(call if_changed,uimage)
> >??????? @echo -n '? Image: $@'
> > ??????? @if [ -f $@ ]; then echo 'is ready' ; else echo 'not made'; fi
> 
> Yes, and this seems to actually work.
> 
> Sam, does this look reasonable to you.  If so I will work up a patch.
Looks ok - but I do not see why use of $(shell ...) did not work out.
Please bring your working version forward.

	Sam
