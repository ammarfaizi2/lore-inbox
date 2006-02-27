Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751726AbWB0TG3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751726AbWB0TG3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 14:06:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751730AbWB0TG2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 14:06:28 -0500
Received: from digitalimplant.org ([64.62.235.95]:16574 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S1751725AbWB0TG1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 14:06:27 -0500
Date: Mon, 27 Feb 2006 11:06:21 -0800 (PST)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: Pavel Machek <pavel@ucw.cz>
cc: Greg KH <greg@kroah.com>, "" <torvalds@osdl.org>, "" <akpm@osdl.org>,
       "" <linux-pm@osdl.org>, "" <linux-kernel@vger.kernel.org>
Subject: Re: [linux-pm] [PATCH 3/5] [pm] Respect the actual device power
 states in sysfs interface
In-Reply-To: <20060221112525.GA22068@elf.ucw.cz>
Message-ID: <Pine.LNX.4.50.0602271105100.28882-100000@monsoon.he.net>
References: <Pine.LNX.4.50.0602171758160.30811-100000@monsoon.he.net>
 <20060218155543.GE5658@openzaurus.ucw.cz> <Pine.LNX.4.50.0602191557520.8676-100000@monsoon.he.net>
 <20060220004635.GA22576@kroah.com> <Pine.LNX.4.50.0602200955030.12708-100000@monsoon.he.net>
 <20060220220404.GA25746@kroah.com> <Pine.LNX.4.50.0602201655580.21145-100000@monsoon.he.net>
 <20060221105711.GK21557@elf.ucw.cz> <Pine.LNX.4.50.0602210312020.10683-100000@monsoon.he.net>
 <20060221112525.GA22068@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 21 Feb 2006, Pavel Machek wrote:

> Hi!
>
> > > > However, there are a couple of things to note:
> > > >
> > > > - These patches don't create a new API; they fix the semantics of an
> > > >   existing API by restoring them to its originally designed semantics.
> > >
> > > They may reintroduce "original" semantics, but they'll break
> > > applications needing 2.6.15 semantic (where 2 meant D3hot).
> >
> > Like what?
>
> Like:
>
> http://article.gmane.org/gmane.linux.kernel/364195/match=pavel+2+sys+power+state+pcmcia

Thanks, but recall that that is PCMCIA. The point of the patch was to pass
the value to the bus drivers, so that they could decide what were valid
values. In the case of PCMCIA, they had adapted to "2", so they could
still receive "2", if the user process wrote that..

Thanks,


	Patrick

