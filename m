Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932162AbVLCWfc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932162AbVLCWfc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 17:35:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932156AbVLCWfc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 17:35:32 -0500
Received: from mail.gmx.net ([213.165.64.20]:35798 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932157AbVLCWfb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 17:35:31 -0500
X-Authenticated: #428038
Date: Sat, 3 Dec 2005 23:35:28 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Golden rule: don't break userland (was Re: RFC: Starting a stable kernel series off the 2.6 kernel)
Message-ID: <20051203223528.GD25722@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20051203135608.GJ31395@stusta.de> <1133620598.22170.14.camel@laptopd505.fenrus.org> <20051203152339.GK31395@stusta.de> <4391E764.7050704@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4391E764.7050704@pobox.com>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Userland isn't the same.  IMO sysfs hackers have forgotten this. 
> Anytime you change or remove sysfs attributes these days, you have the 
> potential to break userland, which breaks one of the grand axioms of 
> Linux.  Everybody knows "the rules" when it comes to removing system 
> calls, but forgets/ignores them when it comes to ioctls, sysfs 
> attributes, and the like.

procfs needs to be mentioned in a main clause (rather than parenthesized
and in a subordinate clause), too. I don't recall if breakage happened
at 2.6.0 or some other time, this however is pretty annoying, as much as
the need to use unstable and undocumented 0.X version kernel support
libraries or daemons utilities.

One /proc example: The removal of /proc/scsi/$DRIVER/$CARD broke for
instance the 3ware Escalade 6000/7000/8000 series 3DM tools - and the
driver IS open source.

OK, in this case it doesn't hurt because the 9000 series 3DM2 tools
work, but it takes a while to figure *that* out.

> Offhand, once implemented and out in the field, I would say a userland 
> interface should live at least 1-2 years after the "we are removing this 
> interface" warning is given.
> 
> Yes, 1-2 years.  Maybe even that is too small.  We still have old_mmap 
> syscall around :)

It should be "2 years or next kernel minor release, whatever comes
later". I understand that to developers, keeping old gears and wheels
around is an annoyance, but knowing one is in to support this for three
years or so makes some people think twice about adding things or
changing things in incompatible ways. And making people think twice can
only improve quality.

-- 
Matthias Andree
