Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262389AbVGMS6x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262389AbVGMS6x (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 14:58:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262226AbVGMS6k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 14:58:40 -0400
Received: from chretien.genwebhost.com ([209.59.175.22]:50586 "EHLO
	chretien.genwebhost.com") by vger.kernel.org with ESMTP
	id S262417AbVGMS6L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 14:58:11 -0400
Date: Wed, 13 Jul 2005 11:58:05 -0700
From: randy_dunlap <rdunlap@xenotime.net>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: roms@tilp.info, linux-kernel@vger.kernel.org
Subject: Re: dependency bug in gconfig?
Message-Id: <20050713115805.3d613c1e.rdunlap@xenotime.net>
In-Reply-To: <Pine.LNX.4.61.0507131353090.3728@scrub.home>
References: <20050712214647.447fdaf0.rdunlap@xenotime.net>
	<Pine.LNX.4.61.0507131353090.3728@scrub.home>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClamAntiVirus-Scanner: This mail is clean
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - chretien.genwebhost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - xenotime.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jul 2005 13:54:56 +0200 (CEST) Roman Zippel wrote:

> Hi,
> 
> On Tue, 12 Jul 2005, randy_dunlap wrote:
> 
> > This appears to be a dependency bug in gconfig to me.
> > 
> > If I enable NETCONSOLE to y, NETPOLL becomes y.  (OK)
> > If I then disable NETCONSOLE to n, NETPOLL remains y.
> > 
> > If I enable NETCONSOLE to m, NETPOLL remains n.  Why is that?
> > 
> > config NETPOLL
> > 	def_bool NETCONSOLE
> > 
> > Should this cause NETCONSOLE to track NETPOLL?
> 
> It should (although it doesn't show it immediately).
> Did you compare the saved config files?

If I disable NETCONSOLE but NETPOLL is still presented as enabled,
and then save and exit gconfig, both NETCONOLE and NETPOLL are
disabled in the .config file, as it should be, so it appears (to me)
to just be a presentation problem in gconfig.

---
~Randy
