Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261842AbTIPMGE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 08:06:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261850AbTIPMGE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 08:06:04 -0400
Received: from mail3.ithnet.com ([217.64.64.7]:7147 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S261842AbTIPMF7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 08:05:59 -0400
X-Sender-Authentication: net64
Date: Tue, 16 Sep 2003 14:05:57 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: marcelo.tosatti@cyclades.com.br, neilb@cse.unsw.edu.au,
       linux-kernel@vger.kernel.org
Subject: Re: experiences beyond 4 GB RAM with 2.4.22
Message-Id: <20030916140557.663b26b4.skraw@ithnet.com>
In-Reply-To: <20030916102113.0f00d7e9.skraw@ithnet.com>
References: <20030912085435.6a26fec4.skraw@ithnet.com>
	<Pine.LNX.4.44.0309151847160.2914-100000@logos.cnet>
	<20030916102113.0f00d7e9.skraw@ithnet.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Sep 2003 10:21:13 +0200
Stephan von Krawczynski <skraw@ithnet.com> wrote:

> On Mon, 15 Sep 2003 19:01:42 -0300 (BRT)
> Marcelo Tosatti <marcelo.tosatti@cyclades.com.br> wrote:
> 
> > > I already thought about that and tried. In fact it is as fast and fine as
> > > 2 GB setup. It runs really smooth. 
> > > The really simple test for the problem is running "updatedb" (find over
> > > the whole filesystem). The box comes to a crawl while this is running,
> > > network is absolutely bad, interactivity is rather dead, very often not
> > > even a ssh login works.
> > 
> > Does -pre4 (with the VM changes from Andrea) show any difference? There 
> > are significant changes in the per-zone decisions which might help.
> 
> Hello Marcelo,
> 
> it looks like -pre4 performs not well even in 4 GB environment. After few
> days of running I find hanging 2.4.22 nfs-clients on a 2.4.23-pre4 server. 
> 
> On the client I get a bunch of those:
> 
> Sep 16 03:02:00 brenda kernel: nfs: server 192.168.1.1 OK
> [...]

Hello again,

you will love to hear that you can drop the above statement completely. After
digging deeper into the case I found out that it was caused by a dead switch.
So this is no -pre4 problem, but a hardware issue. The switch corrupted about
every 20th packet.
So I can tell nothing negative so far about -pre4 with 4 GB.
I'll try with 6 GB now.

Regards,
Stephan

 
