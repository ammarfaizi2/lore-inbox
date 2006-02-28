Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932418AbWB1TJJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932418AbWB1TJJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 14:09:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932420AbWB1TJJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 14:09:09 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:51718 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932418AbWB1TJI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 14:09:08 -0500
Date: Tue, 28 Feb 2006 20:08:43 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org, ak@suse.de
Subject: Re: [Patch 2/4] Basic reorder infrastructure
Message-ID: <20060228190843.GA10235@mars.ravnborg.org>
References: <1141053825.2992.125.camel@laptopd505.fenrus.org> <1141054054.2992.130.camel@laptopd505.fenrus.org> <49447.194.237.142.21.1141057876.squirrel@194.237.142.21> <1141060775.2992.149.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1141060775.2992.149.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2006 at 06:19:34PM +0100, Arjan van de Ven wrote:
> On Mon, 2006-02-27 at 17:31 +0100, sam@ravnborg.org wrote:
> > > This patch puts the infrastructure in place to allow for a reordering of
> > > functions based inside the vmlinux.
> > 
> > Can we make this general instead of x86_64 only?
> > Then we can use Kconfig to enable it for the architectures where we want it.
> 
> Actually Linus had pretty good arguments to make this per-architecture:
> the list will be different on each architecture.
> 
> (eg my first patch had it more generic; but Linus asked it to be per
> arch, and I agree with the reasons he gave)
The list should be per. architecture for - but I just wanted the rest to
be shared since I assume this will soon be adopted by others.
But on the other hand the rest is very few lines so it is not crucial.

> 
> Also I doubt it can be enabled "blindly" for all architectures; I expect
> more to need hacks similar to the x86_64 entry.S fix before it can
> work...
Which is why utilising Kconfig to enable it would make sense.

	Sam
