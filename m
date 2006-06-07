Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751411AbWFGAm0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751411AbWFGAm0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 20:42:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751412AbWFGAm0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 20:42:26 -0400
Received: from khc.piap.pl ([195.187.100.11]:21010 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S1751411AbWFGAmZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 20:42:25 -0400
To: Paul Fulghum <paulkf@microgate.com>
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, davej@redhat.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org, zippel@linux-m68k.org
Subject: Re: [PATCH] fix missing hdlc symbols for synclink drivers
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
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Wed, 07 Jun 2006 02:42:23 +0200
In-Reply-To: <1149638211.2633.21.camel@localhost.localdomain> (Paul Fulghum's message of "Tue, 06 Jun 2006 18:56:51 -0500")
Message-ID: <m364jdbxu8.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Fulghum <paulkf@microgate.com> writes:

> There is nothing random about these select statements.
> They are chosen specifically to fix the dependencies.

And they may work until someone changes something - like a CONFIG_*
name or directory structure.

> You may feel they are ugly, but 'select' is the only tool
> I know of that fixes these errors without losing flexibility.

I don't know what special flexibility are you thinking about.
DEPENDing on a symbol is as flexible and causes no such problems.
The user just needs to enable (in this case) WAN and HDLC
manually ((s)he has to select HDLC_* manually anyway). It could
even make SYNCLINK_*_HDLC unneeded, the added functionality could
(optionally) be selected automagically.

SELECTs are maybe good for small things but such inter-directory
ones are IMHO asking for trouble.
-- 
Krzysztof Halasa
