Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423416AbWBBJjW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423416AbWBBJjW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 04:39:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423425AbWBBJjV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 04:39:21 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:29385 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1423416AbWBBJjV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 04:39:21 -0500
Date: Thu, 2 Feb 2006 10:38:59 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Nigel Cunningham <nigel@suspend2.net>,
       Pekka Enberg <penberg@cs.helsinki.fi>, linux-kernel@vger.kernel.org
Subject: Re: [ 01/10] [Suspend2] kernel/power/modules.h
Message-ID: <20060202093859.GA1884@elf.ucw.cz>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <84144f020602011345i2e395336s371786c441b9f5b2@mail.gmail.com> <200602020855.12392.nigel@suspend2.net> <200602020931.29796.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602020931.29796.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Its limitation , however, is that it requires a lot of memory for the system
> memory snapshot which may be impractical for systems with limited RAM,
> and that's where your solution may be required.

Actually, suspend2 has similar limitation. It still needs half a
memory free, but it does not count caches into that as it can save
them separately.

That means that on certain small systems (32MB RAM?), suspend2 is going to
have big advantage of responsivity after resume. But on the systems
where [u]swsusp can't suspend (6MB RAM?), suspend2 is not going to be
able to suspend, either. [Roughly; due to bugs and implementation
differences there may be some system size where one works and second
one does not, but they are pretty similar]

But that's probably not a problem as it is only going to fail on
*very* small system. Desktops with 6MB RAM are not too common these
days, fortunately. Not even in embedded space.
								Pavel
-- 
Thanks, Sharp!
