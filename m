Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030487AbWJ3P1R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030487AbWJ3P1R (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 10:27:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030532AbWJ3P1R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 10:27:17 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:37033 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1030485AbWJ3P1P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 10:27:15 -0500
Message-ID: <45461BA0.9000405@sw.ru>
Date: Mon, 30 Oct 2006 18:34:56 +0300
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Eric Dumazet <dada1@cosmosbay.com>
CC: Vasily Averin <vvs@sw.ru>, Andrew Morton <akpm@osdl.org>,
       David Howells <dhowells@redhat.com>, Neil Brown <neilb@suse.de>,
       Jan Blunck <jblunck@suse.de>, Olaf Hering <olh@suse.de>,
       Balbir Singh <balbir@in.ibm.com>, Kirill Korotaev <dev@openvz.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       devel@openvz.org
Subject: Re: [PATCH 2.6.19-rc3] VFS: per-sb dentry lru list
References: <4541F2A3.8050004@sw.ru> <20061027110645.b906839f.akpm@osdl.org> <45460B16.7050201@sw.ru> <200610301608.25861.dada1@cosmosbay.com>
In-Reply-To: <200610301608.25861.dada1@cosmosbay.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Quick search maybe, but your patch adds 2 pointers to each dentry in the 
> system... That's pretty expensive, as dentries are already using a *lot* of 
> ram.
I don't see much problems with it... it is cache and it can be pruned if needed.
Some time ago, for example, my patch introducing the same list for inodes
was commited.

> Maybe an alternative would be to not have anymore a global dentry_unused, but 
> only per-sb unused dentries lists ?
I don't know global LRU implementation based on per-sb lists, do you?
If someone suggest the algorithm for more or less fair global LRU
based on non-global list we will implement it. However, so far,
AFAICS there were problems with it.

Thanks,
Kirill
