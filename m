Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262706AbVGMLzS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262706AbVGMLzS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 07:55:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262788AbVGMLzS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 07:55:18 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:46804 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S262706AbVGMLzR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 07:55:17 -0400
Date: Wed, 13 Jul 2005 13:54:56 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: randy_dunlap <rdunlap@xenotime.net>
cc: Romain Lievin <roms@tilp.info>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: dependency bug in gconfig?
In-Reply-To: <20050712214647.447fdaf0.rdunlap@xenotime.net>
Message-ID: <Pine.LNX.4.61.0507131353090.3728@scrub.home>
References: <20050712214647.447fdaf0.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 12 Jul 2005, randy_dunlap wrote:

> This appears to be a dependency bug in gconfig to me.
> 
> If I enable NETCONSOLE to y, NETPOLL becomes y.  (OK)
> If I then disable NETCONSOLE to n, NETPOLL remains y.
> 
> If I enable NETCONSOLE to m, NETPOLL remains n.  Why is that?
> 
> config NETPOLL
> 	def_bool NETCONSOLE
> 
> Should this cause NETCONSOLE to track NETPOLL?

It should (although it doesn't show it immediately).
Did you compare the saved config files?

bye, Roman
