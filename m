Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264008AbUDQSJT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 14:09:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264009AbUDQSJT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 14:09:19 -0400
Received: from wilma.widomaker.com ([204.17.220.5]:24585 "EHLO
	wilma.widomaker.com") by vger.kernel.org with ESMTP id S264008AbUDQSJR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 14:09:17 -0400
Date: Sat, 17 Apr 2004 13:55:39 -0400
From: Charles Shannon Hendrix <shannon@widomaker.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: NFS and kernel 2.6.x
Message-ID: <20040417175538.GD2062@widomaker.com>
References: <20040416011401.GD18329@widomaker.com> <1082079061.7141.85.camel@lade.trondhjem.org> <20040416190126.GB408@widomaker.com> <1082144608.2581.156.camel@lade.trondhjem.org> <20040417000353.GA3750@widomaker.com> <1082179726.3012.7.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1082179726.3012.7.camel@lade.trondhjem.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fri, 16 Apr 2004 @ 22:28 -0700, Trond Myklebust said:

> It's an inevitable side-effect of the increased caching. 

OK.  That answers my question of: was making NFS bursty done on purpose.
Answer: no.

> If you are constantly writing out data, then you spread out the load
> a lot more than if you wait until the user actually requests a flush.
> On the other hand, it means that if your application reads/writs
> several times over the same page, then you only write it out once.

Usually, eliminating redundant writes in your application is a better
optimization than relying on the OS to do it for you.

I find bursty I/O is less desirable in most cases.


-- 
shannon "AT" widomaker.com -- ["The trade of governing has always been
monopolized by the most ignorant and the most rascally individuals of
mankind.  -- Thomas Paine"]
