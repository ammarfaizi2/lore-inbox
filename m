Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261796AbTIPIVS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 04:21:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261797AbTIPIVS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 04:21:18 -0400
Received: from mail3.ithnet.com ([217.64.64.7]:18648 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S261796AbTIPIVP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 04:21:15 -0400
X-Sender-Authentication: net64
Date: Tue, 16 Sep 2003 10:21:13 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>
Cc: neilb@cse.unsw.edu.au, linux-kernel@vger.kernel.org
Subject: Re: experiences beyond 4 GB RAM with 2.4.22
Message-Id: <20030916102113.0f00d7e9.skraw@ithnet.com>
In-Reply-To: <Pine.LNX.4.44.0309151847160.2914-100000@logos.cnet>
References: <20030912085435.6a26fec4.skraw@ithnet.com>
	<Pine.LNX.4.44.0309151847160.2914-100000@logos.cnet>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Sep 2003 19:01:42 -0300 (BRT)
Marcelo Tosatti <marcelo.tosatti@cyclades.com.br> wrote:

> > I already thought about that and tried. In fact it is as fast and fine as 2
> > GB setup. It runs really smooth. 
> > The really simple test for the problem is running "updatedb" (find over the
> > whole filesystem). The box comes to a crawl while this is running, network
> > is absolutely bad, interactivity is rather dead, very often not even a ssh
> > login works.
> 
> Does -pre4 (with the VM changes from Andrea) show any difference? There 
> are significant changes in the per-zone decisions which might help.

Hello Marcelo,

it looks like -pre4 performs not well even in 4 GB environment. After few days
of running I find hanging 2.4.22 nfs-clients on a 2.4.23-pre4 server. 

On the client I get a bunch of those:

Sep 16 03:02:00 brenda kernel: nfs: server 192.168.1.1 OK
Sep 16 03:02:32 brenda kernel: nfs: server 192.168.1.1 not responding, still
trying
Sep 16 03:02:32 brenda kernel: nfs: server 192.168.1.1 OK
Sep 16 03:02:37 brenda kernel: nfs: server 192.168.1.1 not responding, still
trying
Sep 16 03:02:37 brenda last message repeated 3 times
Sep 16 03:02:37 brenda kernel: nfs: server 192.168.1.1 OK 
Sep 16 03:02:37 brenda last message repeated 3 times
Sep 16 03:02:38 brenda kernel: nfs: server 192.168.1.1 not responding, still
trying
Sep 16 03:02:38 brenda last message repeated 6 times
Sep 16 03:02:38 brenda kernel: nfs: server 192.168.1.1 OK 
Sep 16 03:02:38 brenda last message repeated 6 times
Sep 16 03:02:41 brenda kernel: nfs: server 192.168.1.1 not responding, still
trying
Sep 16 03:02:41 brenda kernel: nfs: server 192.168.1.1 OK
Sep 16 03:02:41 brenda kernel: nfs: server 192.168.1.1 not responding, still
trying
Sep 16 03:02:41 brenda kernel: nfs: server 192.168.1.1 OK
Sep 16 03:02:42 brenda kernel: nfs: server 192.168.1.1 not responding, still
trying
Sep 16 03:02:42 brenda last message repeated 2 times
Sep 16 03:02:42 brenda kernel: nfs: server 192.168.1.1 OK 
Sep 16 03:02:42 brenda last message repeated 2 times
Sep 16 03:02:43 brenda kernel: nfs: server 192.168.1.1 not responding, still
trying
Sep 16 03:02:43 brenda last message repeated 8 times
Sep 16 03:02:43 brenda kernel: nfs: server 192.168.1.1 OK 
Sep 16 03:03:08 brenda last message repeated 7 times
Sep 16 03:03:09 brenda kernel: nfs: server 192.168.1.1 not responding, still
trying
Sep 16 03:03:09 brenda last message repeated 2 times
Sep 16 03:03:09 brenda kernel: nfs: server 192.168.1.1 OK 
Sep 16 03:03:10 brenda last message repeated 2 times

And then the nfs-action is dead. Process hangs. This has not happened with
2.4.22 as a server. It showed up after a day of creating 4,7 GB dvd iso images.
Creating theses isos was ok, no error or so during the action.
Is it possible that pre4 does not recover all that well from former memory
pressure?
 
> Have you tried 2.4.22-aa?

Sorry, not yet.
I will go back to 2.4.22 and stress it to see if these effects show up.


Regards,
Stephan
