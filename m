Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263552AbUC3JEh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 04:04:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263551AbUC3JEg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 04:04:36 -0500
Received: from sv1.valinux.co.jp ([210.128.90.2]:7400 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S263538AbUC3JE1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 04:04:27 -0500
Date: Tue, 30 Mar 2004 18:05:23 +0900 (JST)
Message-Id: <20040330.180523.08003015.taka@valinux.co.jp>
To: Zoltan.Menyhart@bull.net
Cc: haveblue@us.ibm.com, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, iwamoto@valinux.co.jp
Subject: Re: Migrate pages from a ccNUMA node to another - patch
From: Hirokazu Takahashi <taka@valinux.co.jp>
In-Reply-To: <20040330082741.541B77054E@sv1.valinux.co.jp>
References: <4063F581.ACC5C511@nospam.org>
	<1080321646.31638.105.camel@nighthawk>
	<20040330082741.541B77054E@sv1.valinux.co.jp>
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> > Have you considered any common ground your patch might share with the
> > people doing memory hotplug?
> > 
> > 	http://people.valinux.co.jp/~iwamoto/mh.html
> > 
> > They have a similar problem to your migration that occurs when a user
> > wants to remove a whole or partial NUMA node.  
> > lhms-devel@lists.sourceforge.net
> 
> Processes must be migrated to other nodes when a node is being
> removed.  Conversely, processes may be migrated from other nodes when
> a node is added.  I'm not familiar with NUMA things, and I think our
> team doesn't have a particular solution.  If you have some idea,
> that's great.
> 
> BTW, it seems page migration can use my remap_onepage function.  Our
> code can move most kinds of pages including hugetlbfs pages and page
> caches.

I believe his patch will interest you since most of the code is
independent of cpu architecture and it also covers mmaped files,
shmem, ramdisk, mlocked pages and so on.

We will post new version of the memory hotplug patches in a week.

Thank you,
Hirokazu Takahashi.
