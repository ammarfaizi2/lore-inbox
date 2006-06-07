Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750710AbWFGBJ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750710AbWFGBJ2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 21:09:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750749AbWFGBJ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 21:09:28 -0400
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:55445
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S1750710AbWFGBJ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 21:09:27 -0400
Subject: Re: [PATCH] fix missing hdlc symbols for synclink drivers
From: Paul Fulghum <paulkf@microgate.com>
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, davej@redhat.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org, zippel@linux-m68k.org
In-Reply-To: <m364jdbxu8.fsf@defiant.localdomain>
References: <20060603232004.68c4e1e3.akpm@osdl.org>
	 <20060605230248.GE3963@redhat.com>
	 <20060605184407.230bcf73.rdunlap@xenotime.net>
	 <1149622813.11929.3.camel@amdx2.microgate.com>
	 <m3u06yc9mr.fsf@defiant.localdomain>
	 <20060606134816.363cbeca.rdunlap@xenotime.net>
	 <20060606140822.c6f4ef37.rdunlap@xenotime.net>
	 <m3zmgpc3ba.fsf@defiant.localdomain>
	 <20060606160745.2f88ff9c.rdunlap@xenotime.net>
	 <m3ejy1c0uw.fsf@defiant.localdomain>
	 <1149638211.2633.21.camel@localhost.localdomain>
	 <m364jdbxu8.fsf@defiant.localdomain>
Content-Type: text/plain
Date: Tue, 06 Jun 2006 20:09:05 -0500
Message-Id: <1149642545.2633.49.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-06-07 at 02:42 +0200, Krzysztof Halasa wrote:
> I don't know what special flexibility are you thinking about.
> DEPENDing on a symbol is as flexible and causes no such problems.
> The user just needs to enable (in this case) WAN and HDLC
> manually ((s)he has to select HDLC_* manually anyway). It could
> even make SYNCLINK_*_HDLC unneeded, the added functionality could
> (optionally) be selected automagically.

That is close to the way it was working, but it
had build errors with synclink=y and hdlc=m which
is what started all of these patches.

I guess I could add an extra check for that broken config
case in all the individual source files using conditional compilation
and disable synclink HDLC support altogether if such
a broken selection of options occurs (through
a random config generation). Still messy, but
since there seems to be a consensus that using the 'select'
facility of kbuild is forbidden, that may be the more
politically palatable way to go.

--
Paul


