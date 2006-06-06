Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751371AbWFFXsv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751371AbWFFXsv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 19:48:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751372AbWFFXsv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 19:48:51 -0400
Received: from xenotime.net ([66.160.160.81]:1466 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751371AbWFFXsu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 19:48:50 -0400
Date: Tue, 6 Jun 2006 16:51:37 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: paulkf@microgate.com, davej@redhat.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org, zippel@linux-m68k.org
Subject: Re: [PATCH] fix missing hdlc symbols for synclink drivers
Message-Id: <20060606165137.cd94675b.rdunlap@xenotime.net>
In-Reply-To: <m3ejy1c0uw.fsf@defiant.localdomain>
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
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 07 Jun 2006 01:37:11 +0200 Krzysztof Halasa wrote:

> "Randy.Dunlap" <rdunlap@xenotime.net> writes:
> 
> > I'm on x86-64 if it matters.
> > My .config is attached.
> 
> Ok, reproduced.
> 
> The problem is that CONFIG_WAN is not set, the make system doesn't
> read drivers/net/wan/Makefile at all, and nothing in drivers/net/wan
> is being built.

Aha.  I commented about that early on in this thread
and sent a patch to SELECT WAN.  However:

> Just another argument against random SELECTs.

I agree with that and think that SYNCLINK should be using
"depends" instead of "select".

Paul, can you repost the current patch, please?

---
~Randy
