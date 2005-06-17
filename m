Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261917AbVFQEqb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261917AbVFQEqb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 00:46:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261918AbVFQEqb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 00:46:31 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:57100 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261917AbVFQEq1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 00:46:27 -0400
Date: Fri, 17 Jun 2005 06:46:20 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Lars Roland <lroland@gmail.com>
Cc: Christian Kujau <evil@g-house.de>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: tg3 in 2.6.12-rc6 and Cisco PIX SMTP fixup
Message-ID: <20050617044620.GG8907@alpha.home.local>
References: <4ad99e0505061605452e663a1e@mail.gmail.com> <42B1F5CB.9020308@g-house.de> <4ad99e0505061615143cc34192@mail.gmail.com> <42B21130.4000608@g-house.de> <4ad99e0505061617052f427ed6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ad99e0505061617052f427ed6@mail.gmail.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 17, 2005 at 02:05:28AM +0200, Lars Roland wrote:
> On 6/17/05, Christian Kujau <evil@g-house.de> wrote:
> > Lars Roland schrieb:
> > > It does not seams to be limited to braodcom cards. 3com and Intel e100
> > > cards does the exact same stunt on kernels never than 2.6.8.1. Intel
> > > e1000 and realtek 8139 cards do however work.
> > 
> > hm - tricky, i think. because no kernel oopses, nothing to look at in the
> > syslog (yes?),
> 
> Nothing anywhere, even tcpdump just seams to get cut off - I have not
> been debugging ethernet drivers for years, getting a little rusty at
> that, so nothing there yet.
> 
> > various nic drivers affected, others not...in cases like
> > these only Documentation/BUG-HUNTING comes to my mind: if 2.6.8.1 works,
> > and 2.6.12-rc6 does not, we'll need to find out the kernelversion which
> > introduced this behaviour.
> 
> That I can give you, kernel 2.6.8.1 works but 2.6.9 does not (at least
> not with tg3 and tulip cards).

Maybe some checksumming code has changed, and some of the packets which
are checksummed by the hardware get wrong on the wire ?

Willy

