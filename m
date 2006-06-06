Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751357AbWFFXhP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751357AbWFFXhP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 19:37:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751359AbWFFXhP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 19:37:15 -0400
Received: from khc.piap.pl ([195.187.100.11]:36615 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S1751357AbWFFXhO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 19:37:14 -0400
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: paulkf@microgate.com, davej@redhat.com, akpm@osdl.org,
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
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Wed, 07 Jun 2006 01:37:11 +0200
In-Reply-To: <20060606160745.2f88ff9c.rdunlap@xenotime.net> (Randy Dunlap's message of "Tue, 6 Jun 2006 16:07:45 -0700")
Message-ID: <m3ejy1c0uw.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Randy.Dunlap" <rdunlap@xenotime.net> writes:

> I'm on x86-64 if it matters.
> My .config is attached.

Ok, reproduced.

The problem is that CONFIG_WAN is not set, the make system doesn't
read drivers/net/wan/Makefile at all, and nothing in drivers/net/wan
is being built.

Just another argument against random SELECTs.
-- 
Krzysztof Halasa
