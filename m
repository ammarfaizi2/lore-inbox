Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265808AbUGZSyd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265808AbUGZSyd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 14:54:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265959AbUGZSyd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 14:54:33 -0400
Received: from fw.osdl.org ([65.172.181.6]:38285 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265808AbUGZQzl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 12:55:41 -0400
Date: Mon, 26 Jul 2004 09:55:05 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Pasi Sjoholm <ptsjohol@cc.jyu.fi>
Cc: Francois Romieu <romieu@fr.zoreil.com>,
       H?ctor Mart?n <hector@marcansoft.com>,
       Linux-Kernel <linux-kernel@vger.kernel.org>, <akpm@osdl.org>,
       <netdev@oss.sgi.com>, <brad@brad-x.com>
Subject: Re: ksoftirqd uses 99% CPU triggered by network traffic (maybe
 RLT-8139 related)
Message-Id: <20040726095505.2ddb3bec@dell_ss3.pdx.osdl.net>
In-Reply-To: <Pine.LNX.4.44.0407261745120.31123-100000@silmu.st.jyu.fi>
References: <20040725235927.B30025@electric-eye.fr.zoreil.com>
	<Pine.LNX.4.44.0407261745120.31123-100000@silmu.st.jyu.fi>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.10claws (GTK+ 1.2.10; i386-redhat-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Jul 2004 18:15:34 +0300 (EEST)
Pasi Sjoholm <ptsjohol@cc.jyu.fi> wrote:

> On Sun, 25 Jul 2004, Francois Romieu wrote:
> 
> > Pasi Sjoholm <ptsjohol@cc.jyu.fi> :
> > [...]
> > > I haven't been able to reproduce this with normal www-browsing or 
> > > ssh-connections but it's always reproducible when my eth0 is under heavy 
> > > load.
> > I guess it can be reproduced even if the binary (nvidia ?) module is never
> > loaded after boot, right ?
> 
> After 24 hours of hard working I can answer yes to this question. 
> Now I can reproduce this from 2 to 15 minutes with 2 cp-processes from 
> samba->workstation->nfs, some software building with make -j 3, playing 
> some mp3 via nfs to notice when kernel goes down.. =) and so on..
> 
> After that ksoftirqd takes almost all the cpu-time and the network is not 
> working at all.

Is network traffic still coming in? or perhaps there is a network packet
that causes some soft irq to go into an infinite loop. The recent iptables bug
with ip options would be an example.
