Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750746AbWANXgV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750746AbWANXgV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 18:36:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750817AbWANXgV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 18:36:21 -0500
Received: from mx1.redhat.com ([66.187.233.31]:27588 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750746AbWANXgU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 18:36:20 -0500
Subject: Re: wireless: recap of current issues (stack)
From: Dan Williams <dcbw@redhat.com>
To: Simon Kelley <simon@thekelleys.org.uk>
Cc: Chase Venters <chase.venters@clientec.com>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, Jiri Benc <jbenc@suse.cz>,
       Stefan Rompf <stefan@loplof.de>,
       Mike Kershaw <dragorn@kismetwireless.net>,
       Krzysztof Halasa <khc@pm.waw.pl>, Robert Hancock <hancockr@shaw.ca>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Dominik Brodowski <linux@dominikbrodowski.net>,
       Denis Vlasenko <vda@ilport.com.ua>,
       Danny van Dyk <kugelfang@gentoo.org>,
       Stephen Hemminger <shemminger@osdl.org>, feyd <feyd@nmskb.cz>,
       Andreas Mohr <andim2@users.sourceforge.net>,
       Bas Vermeulen <bvermeul@blackstar.nl>, Jean Tourrilhes <jt@hpl.hp.com>,
       Daniel Drake <dsd@gentoo.org>, Ulrich Kunitz <kune@deine-taler.de>,
       Phil Dibowitz <phil@ipom.com>, Michael Buesch <mbuesch@freenet.de>,
       Marcel Holtmann <marcel@holtmann.org>,
       Patrick McHardy <kaber@trash.net>, Ingo Oeser <netdev@axxeo.de>,
       Harald Welte <laforge@gnumonks.org>,
       Ben Greear <greearb@candelatech.com>, Thomas Graf <tgraf@suug.ch>
In-Reply-To: <43C8D685.70805@thekelleys.org.uk>
References: <20060113195723.GB16166@tuxdriver.com>
	 <20060113212605.GD16166@tuxdriver.com>
	 <20060113213200.GG16166@tuxdriver.com>
	 <200601131703.29677.chase.venters@clientec.com>
	 <43C8D685.70805@thekelleys.org.uk>
Content-Type: text/plain
Date: Sat, 14 Jan 2006 18:29:59 -0500
Message-Id: <1137281400.27849.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.4 (2.5.4-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-01-14 at 10:46 +0000, Simon Kelley wrote:
> Chase Venters wrote:
> 
> > As an aside to this whole thing, I know we're talking about *kernel* wireless 
> > but it's worthless to most people without good userland support as well. 
> > Anyone have any thoughts and feelings on what things look like on the 
> > desktop? I think if we work closely with some desktop people, we can shepard 
> > in some wonderful new desktop support on top of the new netlink API.
> > 
> 
> An obvious place to start is the NetworkManager project. They should be 
> asked the obvious "what do you need" and "does this provide it" 
> questions. Dan Williams has been active recently producing small kernel 
> patches which make the kernel side stuff work better with NM, so he 
> might be a good contact to start with.

We are actually moving NM on top of wpa_supplicant for the actual
connection process.  So essentially, while NM does talk to the card for
information and scanning, wpa_supplicant provides the bulk of the actual
connection process control.  Any card that works with wpa_supplicant
should then work with NetworkManager.

Novel's is working on a KDE applet for NM which should hit CVS soon, I
think.

Dan


