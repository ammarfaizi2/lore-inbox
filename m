Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751347AbWFFXWg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751347AbWFFXWg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 19:22:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751348AbWFFXWg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 19:22:36 -0400
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:61926
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S1751347AbWFFXWe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 19:22:34 -0400
Subject: Re: [PATCH] fix missing hdlc symbols for synclink drivers
From: Paul Fulghum <paulkf@microgate.com>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: Krzysztof Halasa <khc@pm.waw.pl>, davej@redhat.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org, zippel@linux-m68k.org
In-Reply-To: <20060606160745.2f88ff9c.rdunlap@xenotime.net>
References: <20060603232004.68c4e1e3.akpm@osdl.org>
	 <20060605230248.GE3963@redhat.com>
	 <20060605184407.230bcf73.rdunlap@xenotime.net>
	 <1149622813.11929.3.camel@amdx2.microgate.com>
	 <m3u06yc9mr.fsf@defiant.localdomain>
	 <20060606134816.363cbeca.rdunlap@xenotime.net>
	 <20060606140822.c6f4ef37.rdunlap@xenotime.net>
	 <m3zmgpc3ba.fsf@defiant.localdomain>
	 <20060606160745.2f88ff9c.rdunlap@xenotime.net>
Content-Type: text/plain
Date: Tue, 06 Jun 2006 18:22:22 -0500
Message-Id: <1149636142.2633.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-06-06 at 16:07 -0700, Randy.Dunlap wrote:
> On Wed, 07 Jun 2006 00:44:09 +0200 Krzysztof Halasa wrote:
> > Are you sure it's not a corrupted build tree or something like that?
> > Can I have a look at the complete .config? Or some other bugzilla #?
> 
> I did a make mrproper and got the same results.
> I'm on x86-64 if it matters.
> My .config is attached.

I just completed some builds including the setup you
indicated (though not your exact .config, which I will try next).
I'm also building x86-64.

Everything builds correctly using your patch, but
without the Makefile portion, so we can drop that.

It builds for

CONFIG_HDLC=m
CONFIG_SYNCLINK=m
CONFIG_SYNCLINK_HDLC=y
(all modules)

and

CONFIG_HDLC=m
CONFIG_SYNCLINK=y
CONFIG_SYNCLINK_HDLC=y
(all built-in, hdlc promoted to 'y')

--
Paul


