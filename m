Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263602AbUC3LUL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 06:20:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263612AbUC3LUL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 06:20:11 -0500
Received: from ecbull20.frec.bull.fr ([129.183.4.3]:46996 "EHLO
	ecbull20.frec.bull.fr") by vger.kernel.org with ESMTP
	id S263602AbUC3LUC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 06:20:02 -0500
Message-ID: <40695802.1F13AB0D@nospam.org>
Date: Tue, 30 Mar 2004 13:20:34 +0200
From: Zoltan Menyhart <Zoltan.Menyhart_AT_bull.net@nospam.org>
Reply-To: Zoltan.Menyhart@bull.net
Organization: Bull S.A.
X-Mailer: Mozilla 4.78 [en] (X11; U; AIX 4.3)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Hirokazu Takahashi <taka@valinux.co.jp>
CC: haveblue@us.ibm.com, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, iwamoto@valinux.co.jp
Subject: Re: Migrate pages from a ccNUMA node to another - patch
References: <4063F581.ACC5C511@nospam.org>
		<1080321646.31638.105.camel@nighthawk>
		<20040330082741.541B77054E@sv1.valinux.co.jp> <20040330.180523.08003015.taka@valinux.co.jp>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hirokazu Takahashi wrote:
> 
> Hello,
> 
> > > Have you considered any common ground your patch might share with the
> > > people doing memory hotplug?
> > >
> > >     http://people.valinux.co.jp/~iwamoto/mh.html
> > >
> > > They have a similar problem to your migration that occurs when a user
> > > wants to remove a whole or partial NUMA node.
> > > lhms-devel@lists.sourceforge.net
> >
> > Processes must be migrated to other nodes when a node is being
> > removed.  Conversely, processes may be migrated from other nodes when
> > a node is added.  I'm not familiar with NUMA things, and I think our
> > team doesn't have a particular solution.  If you have some idea,
> > that's great.
> >
> > BTW, it seems page migration can use my remap_onepage function.  Our
> > code can move most kinds of pages including hugetlbfs pages and page
> > caches.
> 
> I believe his patch will interest you since most of the code is
> independent of cpu architecture and it also covers mmaped files,
> shmem, ramdisk, mlocked pages and so on.
> 
> We will post new version of the memory hotplug patches in a week.
> 
> Thank you,
> Hirokazu Takahashi.

I am afraid the "remap_onepage()" function + the modifications necessary
at some other places are too much for me :-)

You do a couple of retries, waits. I cannot afford spending so much as
overhead due to some performance optimization.

I can understand that if you want to remove a node / memory module, then you
have to succeed by all means, you have to handle all kinds of pages,
the performance is not at a premium.

Regards,

Zoltán Menyhárt
