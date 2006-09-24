Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751239AbWIXWNN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751239AbWIXWNN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 18:13:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751258AbWIXWNN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 18:13:13 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:55468 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751239AbWIXWNM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 18:13:12 -0400
Subject: Re: [2.6.18-rc7-mm1] slow boot
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: Tilman Schmidt <tilman@imap.cc>, linux-kernel@vger.kernel.org,
       Chris Mason <mason@suse.com>, ext2-devel@lists.sourceforge.net,
       reiserfs-dev@namesys.com
In-Reply-To: <20060924145337.ae152efd.akpm@osdl.org>
References: <4516B966.3010909@imap.cc>
	 <20060924145337.ae152efd.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 24 Sep 2006 23:36:41 +0100
Message-Id: <1159137402.11049.40.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Sul, 2006-09-24 am 14:53 -0700, ysgrifennodd Andrew Morton:
> I've *never* seen any reports of any problems being caused by disk
> writeback caching.  Yes, it's a theoretical problem but for some reason it
> just doesn't seem to be a problem in practice.  Hence I'm really reluctant
> to go and slow everyone's machines down so much in this manner.

It happens in some cases, the usual one is sudden loss of power. In the
crashed box cases the disk still gets to write data back and in the
Linux power off sanely cases we explicitly cache flush. Its the sudden
loss of power case that is nasty.

We are also helped of course by the fact the cache is never more than
can be flushed in about 7 seconds because of other-os features.

