Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272162AbTG2XHB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 19:07:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272168AbTG2XHB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 19:07:01 -0400
Received: from fed1mtao08.cox.net ([68.6.19.123]:55440 "EHLO
	fed1mtao08.cox.net") by vger.kernel.org with ESMTP id S272162AbTG2XG6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 19:06:58 -0400
Date: Tue, 29 Jul 2003 16:06:57 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Bernardo Innocenti <bernie@develer.com>, Willy Tarreau <willy@w.ods.org>,
       Christoph Hellwig <hch@lst.de>,
       uClinux development list <uclinux-dev@uclinux.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [uClinux-dev] Kernel 2.6 size increase
Message-ID: <20030729230657.GL16051@ip68-0-152-218.tc.ph.cox.net>
References: <200307232046.46990.bernie@develer.com> <200307240007.15377.bernie@develer.com> <20030723222747.GF643@alpha.home.local> <200307242227.16439.bernie@develer.com> <20030729222921.GK16051@ip68-0-152-218.tc.ph.cox.net> <1059518889.6838.19.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1059518889.6838.19.camel@dhcp22.swansea.linux.org.uk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 29, 2003 at 11:48:10PM +0100, Alan Cox wrote:
> On Maw, 2003-07-29 at 23:29, Tom Rini wrote:
> > 
> > Well, from Pat's talk at OLS, it seems like sysfs would be an important
> > part of 'sleep', which is something at least some embedded systems care
> > about.
> 
> sysfs is relevant for bigger systems but for small embedded stuff the whole
> PM layer is fairly "so what". At that level your hardware is tightly defined
> and you *know* the power management ordering. Policy becomes critical for 
> performance and gets done at a very fine grained level - things like waking
> up the flash for a read then turning it back off on a timer for example.

And wouldn't it be nice to have one 'policy enforcing tool' or whatever
that you feed it policy_desktop.txt, policy_embedded_in_my_fridge.txt or
policy_enterprise.txt ?

And while you know the ordering for your one board, it's not the same as
that other board there, nor that third board just behind you, and so on.
So getting passed in some sort of tree (or more correctly DAG) and
dealing with it with some more generic code sure sounds nice.

-- 
Tom Rini
http://gate.crashing.org/~trini/
