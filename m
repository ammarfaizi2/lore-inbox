Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264779AbSKJKLX>; Sun, 10 Nov 2002 05:11:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264796AbSKJKLX>; Sun, 10 Nov 2002 05:11:23 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:8388 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S264779AbSKJKLW>;
	Sun, 10 Nov 2002 05:11:22 -0500
Date: Sun, 10 Nov 2002 11:17:30 +0100
From: Jens Axboe <axboe@suse.de>
To: Kjartan Maraas <kmaraas@online.no>
Cc: Con Kolivas <conman@kolivas.net>, Andrew Morton <akpm@digeo.com>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       marcelo@conectiva.com.br, Andrea Arcangeli <andrea@suse.de>
Subject: Re: [BENCHMARK] 2.4.{18,19{-ck9},20rc1{-aa1}} with contest
Message-ID: <20021110101730.GA14529@suse.de>
References: <200211091300.32127.conman@kolivas.net> <200211091612.08718.conman@kolivas.net> <20021109112135.GB31134@suse.de> <200211100009.55844.conman@kolivas.net> <20021109135446.GA2551@suse.de> <1036923167.2538.7.camel@sevilla.gnome.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1036923167.2538.7.camel@sevilla.gnome.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 10 2002, Kjartan Maraas wrote:
> lør, 2002-11-09 kl. 14:54 skrev Jens Axboe:
> 
> [SNIP]
> 
> > The default is 2048. How long does the io_load test take, or rather how
> 
> The default on my RH system with the latest errata kernel is as follows:
> 
> [root@sevilla kmaraas]# elvtune /dev/hda
> 
> /dev/hda elevator ID		0
> 	read_latency:		8192
> 	write_latency:		16384
> 	max_bomb_segments:	6
> 
> [root@sevilla kmaraas]# uname -a
> Linux sevilla.gnome.no 2.4.18-17.7.x #1 Tue Oct 8 13:33:14 EDT 2002 i686
> unknown
> [root@sevilla kmaraas]# 
> 
> Is this worth changing to lower values then? They seem to be an awful
> lot higher than the values mentioned below here.

As I mentioned in the email sent out a few minutes ago, you cannot
compare the values from 2.4.19 and earlier to 2.4.20-pre/rc at all. The
algorithm for determining when a request is starved has been changed to
be more correct, and that has invalidated these values.

-- 
Jens Axboe

