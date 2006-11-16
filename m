Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161947AbWKPHEv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161947AbWKPHEv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 02:04:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161948AbWKPHEv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 02:04:51 -0500
Received: from ns2.suse.de ([195.135.220.15]:34277 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1161947AbWKPHEu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 02:04:50 -0500
From: Andi Kleen <ak@suse.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [discuss] Re: 2.6.19-rc5: known regressions (v3)
Date: Thu, 16 Nov 2006 08:04:31 +0100
User-Agent: KMail/1.9.5
Cc: Linus Torvalds <torvalds@osdl.org>, discuss@x86-64.org,
       William Cohen <wcohen@redhat.com>, Eric Dumazet <dada1@cosmosbay.com>,
       Komuro <komurojun-mbn@nifty.com>, Ernst Herzberg <earny@net4u.de>,
       Andre Noll <maan@systemlinux.org>, oprofile-list@lists.sourceforge.net,
       Jens Axboe <jens.axboe@oracle.com>,
       linux-usb-devel@lists.sourceforge.net, phil.el@wanadoo.fr,
       Adrian Bunk <bunk@stusta.de>, Ingo Molnar <mingo@redhat.com>,
       Alan Stern <stern@rowland.harvard.edu>,
       linux-pci@atrey.karlin.mff.cuni.cz,
       Stephen Hemminger <shemminger@osdl.org>,
       Prakash Punnoor <prakash@punnoor.de>, Len Brown <len.brown@intel.com>,
       Alex Romosan <romosan@sycorax.lbl.gov>, gregkh@suse.de,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Andrey Borzenkov <arvidjaar@mail.ru>
References: <Pine.LNX.4.64.0611071829340.3667@g5.osdl.org> <20061116032109.GG9579@bingen.suse.de> <20061115210501.feaf230c.akpm@osdl.org>
In-Reply-To: <20061115210501.feaf230c.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611160804.31806.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 16 November 2006 06:05, Andrew Morton wrote:
> On Thu, 16 Nov 2006 04:21:09 +0100
> Andi Kleen <ak@suse.de> wrote:
> 
> > > 
> > > If it's really true that oprofile is simply busted then that's a serious
> > > problem and we should find some way of unbusting it.  If that means just
> > > adding a dummy "0" entry which always returns zero or something like that,
> > > then fine.
> > 
> > That could be probably done.
> 
> I'm told that this is exactly what it was doing before it got changed.

Hmm, ok perhaps that can be arranged again.

The trouble is that I want to use this performance counter for
other purposes too, so we would run into trouble again 
if oprofile keeps stealing it.

> > > But we can't just go and bust it.
> > 
> > It just did something unbelievable broken before.
> 
> What did it do?

Silently kill the nmi watchdog.

> 
> > I would say it busted
> > itself.
> 
> It gave profiles, which was fairly handy.

I'm sure it can be fixed there. Ok ok I keep sounding like a sysfs maintainer
now @)

-Andi
