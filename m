Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263107AbTI3FPg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 01:15:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263109AbTI3FPg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 01:15:36 -0400
Received: from pizda.ninka.net ([216.101.162.242]:29444 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S263107AbTI3FPd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 01:15:33 -0400
Date: Mon, 29 Sep 2003 22:11:29 -0700
From: "David S. Miller" <davem@redhat.com>
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Cc: bunk@fs.tum.de, netdev@oss.sgi.com, pekkas@netcore.fi,
       lksctp-developers@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: RFC: [2.6 patch] disallow modular IPv6
Message-Id: <20030929221129.7689e088.davem@redhat.com>
In-Reply-To: <20030929003229.GM1039@conectiva.com.br>
References: <20030928225941.GW15338@fs.tum.de>
	<20030928231842.GE1039@conectiva.com.br>
	<20030928232403.GX15338@fs.tum.de>
	<20030928233909.GG1039@conectiva.com.br>
	<20030929001439.GY15338@fs.tum.de>
	<20030929003229.GM1039@conectiva.com.br>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 Sep 2003 21:32:30 -0300
Arnaldo Carvalho de Melo <acme@conectiva.com.br> wrote:

> Em Mon, Sep 29, 2003 at 02:14:39AM +0200, Adrian Bunk escreveu:
> > On Sun, Sep 28, 2003 at 08:39:10PM -0300, Arnaldo Carvalho de Melo wrote:
> > What about the following solution (the names and help texts for the
> > config options might not be optimal, I hope you understand the
> > intention):
> > 
> > config IPV6_SUPPORT
> > 	bool "IPv6 support"
> > 
> > config IPV6_ENABLE
> > 	tristate "enable IPv6"
> > 	depends on IPV6_SUPPORT
> > 
> > IPV6_SUPPORT changes structs etc. and IPV6_ENABLE is responsible for 
> > ipv6.o .
> 
> Humm, and the idea is? This seems confusing, could you elaborate on why such
> scheme is a good thing?

I think the idea is totally broken.  At first, Adrian comments that
changing the layout of structs based upon a config option is broken,
then he proposes a config option that does nothing except change the
layout of structures.

The current situation is perfectly fine.
