Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282338AbRK2DbO>; Wed, 28 Nov 2001 22:31:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282339AbRK2DbE>; Wed, 28 Nov 2001 22:31:04 -0500
Received: from zero.tech9.net ([209.61.188.187]:55050 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S282338AbRK2Daq>;
	Wed, 28 Nov 2001 22:30:46 -0500
Subject: Re: Linux 2.4.17-pre1
From: Robert Love <rml@tech9.net>
To: Ken Brownfield <brownfld@irridia.com>, marcelo@conectiva.com.br
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20011128211327.A27177@asooo.flowerfire.com>
In-Reply-To: <Pine.LNX.4.21.0111281340210.15491-100000@freak.distro.conectiva>
	<20011128185601.A784@mikef-linux.matchmail.com> 
	<20011128211327.A27177@asooo.flowerfire.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.2 (Preview Release)
Date: 28 Nov 2001 22:30:46 -0500
Message-Id: <1007004647.813.15.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2001-11-28 at 22:13, Ken Brownfield wrote:>
> Seconded.  Off by default and with appropriate security caveats in the
> Configure.help section, which Robert has already mentioned.
> 
> It's pretty critical given the burgeoning amount of cryptography in
> production environments where entropy from disk I/O is essentially
> non-existent.  The security concerns are very valid, but many trade-offs
> are worth it, IMHO.  I will most likely be dead in the water soon unless
> I start using this patch in certain places.

For those interested, the patch is at
	ftp://ftp.kernel.org/pub/linux/kernel/people/rml/netdev-random

I want to point out that _without_ this patch, there are network devices
that feed the entropy pool.  In other words, this patch standardizes the
situation.

If you don't want net devices contributing, accept the default.

If you do, enable the configure setting and they all will contribute to
/dev/random.  This has uses in diskless/headless configurations, etc.

> On Wed, Nov 28, 2001 at 06:56:01PM -0800, Mike Fedyk wrote:
> | Any chance you'll merge Robert's netdev-random uniformity cleanup
> | patch with the default to "no"?

	Robert Love

