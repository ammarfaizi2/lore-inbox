Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264811AbTFLKj7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 06:39:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264812AbTFLKj7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 06:39:59 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:42073 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S264811AbTFLKj6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 06:39:58 -0400
Date: Thu, 12 Jun 2003 03:54:42 -0700
From: Andrew Morton <akpm@digeo.com>
To: Christophe Saout <christophe@saout.de>
Cc: andyp@osdl.org, adam@yggdrasil.com, linux-kernel@vger.kernel.org
Subject: Re: ext[23]/lilo/2.5.{68,69,70} -- blkdev_put() problem?
Message-Id: <20030612035442.29345778.akpm@digeo.com>
In-Reply-To: <1055414558.565.4.camel@chtephan.cs.pocnet.net>
References: <1052507057.15923.31.camel@andyp.pdx.osdl.net>
	<1052510656.6334.8.camel@chtephan.cs.pocnet.net>
	<1052513725.15923.45.camel@andyp.pdx.osdl.net>
	<1055369326.1158.252.camel@andyp.pdx.osdl.net>
	<1055373692.16483.8.camel@chtephan.cs.pocnet.net>
	<1055377253.1222.8.camel@andyp.pdx.osdl.net>
	<20030611172958.5e4d3500.akpm@digeo.com>
	<1055414558.565.4.camel@chtephan.cs.pocnet.net>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Jun 2003 10:53:43.0457 (UTC) FILETIME=[E4175110:01C330D0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Saout <christophe@saout.de> wrote:
>
> Am Don, 2003-06-12 um 02.29 schrieb Andrew Morton:
> 
> > But sync() should certainly write everything out, and lilo does perform a
> > sync.
> 
> Yep.
> 
> > I'd be interested in seeing the contents of /proc/meminfo immediately after
> > the lilo run, see if there's any dirty memory left around.
> 
> Yes, one page. After running lilo, there are 4k diry, running sync
> doesn't get it below 4k.

That would tend to imply that a page got onto the wrong list.  But if that
were so, nothing would be able to write it.

> Only flushb /dev/hda does (or waiting several minutes).

What is flushb?

I use `lilo ; reboot -f' about 1000 times a day, no probs.  There's
something different.

Adam was doing strange things with an initrd and pivot_root.  Are you doing
anything unconventional?

> 
> BTW: I found out that now strace lilo freezes the machine...

Works OK here.  Try `strace strace lilo' ;)


