Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263538AbTIIP4y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 11:56:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264172AbTIIP4y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 11:56:54 -0400
Received: from fw.osdl.org ([65.172.181.6]:63689 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263538AbTIIP4w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 11:56:52 -0400
Date: Tue, 9 Sep 2003 08:54:10 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: =?iso-8859-1?Q?=C9ric?= Brunet <Eric.Brunet@lps.ens.fr>
cc: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Power Management Update
In-Reply-To: <20030909105323.GA14859@lps.ens.fr>
Message-ID: <Pine.LNX.4.33.0309090842500.919-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 9 Sep 2003, Éric Brunet wrote:

> On Mon, Sep 08, 2003 at 12:54:12PM -0700, Patrick Mochel wrote:
> > > * swsusp doesn't like accelerated graphics. If the following modules are
> > >   loaded:
> > >     i830                   68120  20
> > >     intel_agp              14744  1
> > >     agpgart                25640  3 intel_agp
> > >   resuming fails. (Different kind of failures, from spontaneous reboot to
> > 
> > This is not suprising, and likely something that many people will run 
> > into. There is a lot of driver work that needs to be done, especially WRT 
> > video devices, as many of them are not tied into the new driver model at 
> > all. 
> 
> If you want more testers and interesting bug reports, that should be some
> kinfd of priority, no ? Everybody is running with accelerated graphics
> modules, nowadays.

It is a priority, but they pose a stiff challenge that not many know how 
to resolve, including yours truly. We'll get there.. 

> agpgart		i830		hid+uhci+ehci	eth1	  | suspend+resume
> +intel_agp						  |
> ----------------------------------------------------------+--
> unloaded	unloaded	loaded		loaded+up | works but
> 							  | mouse+eth1 fail
> 
> loaded		unloaded	unloaded	unloaded  | works and
> 							  | mouse+eth1 can be
> 							  | recovered
> 
> loaded		unloaded	partially	loaded	  | does not work.
> 				loaded		but down
> 
> What this probably means is that one of my succes was a piece of luck,
> non reliably reproducible. Unfortunately, my wife came back from her
> trip, and I now have much less time for testing...

Heh, thanks for testing this so far. This is definitely helpful in 
pointing out some trouble areas. 


	Pat

