Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261914AbSIYEzb>; Wed, 25 Sep 2002 00:55:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261915AbSIYEzb>; Wed, 25 Sep 2002 00:55:31 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:20849 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S261914AbSIYEza>; Wed, 25 Sep 2002 00:55:30 -0400
Date: Wed, 25 Sep 2002 01:00:44 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
To: mingo@redhat.com, torvalds@transmeta.com
Cc: Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org
Subject: cmpxchg in 2.5.38
Message-ID: <20020925010044.A4464@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The cmpxchg() is used in kernel/pid.c:next_free_map():

                        if (cmpxchg(&map->page, NULL, (void *) page))
                                free_page(page);

It is implemented on alpha, i386, ia64, ppc64, ppc, sparc64,
x86_64, but not on mips, cris, arm, s390, s390x, sparc, sh, parisc.
Do all architectures have to have it?

-- Pete
