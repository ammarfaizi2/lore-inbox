Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261915AbSIYE75>; Wed, 25 Sep 2002 00:59:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261916AbSIYE75>; Wed, 25 Sep 2002 00:59:57 -0400
Received: from pizda.ninka.net ([216.101.162.242]:43720 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261915AbSIYE75>;
	Wed, 25 Sep 2002 00:59:57 -0400
Date: Tue, 24 Sep 2002 21:54:58 -0700 (PDT)
Message-Id: <20020924.215458.66723020.davem@redhat.com>
To: zaitcev@redhat.com
Cc: mingo@redhat.com, torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: cmpxchg in 2.5.38
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020925010044.A4464@devserv.devel.redhat.com>
References: <20020925010044.A4464@devserv.devel.redhat.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Pete Zaitcev <zaitcev@redhat.com>
   Date: Wed, 25 Sep 2002 01:00:44 -0400

   The cmpxchg() is used in kernel/pid.c:next_free_map():
   
                           if (cmpxchg(&map->page, NULL, (void *) page))
                                   free_page(page);
   
   It is implemented on alpha, i386, ia64, ppc64, ppc, sparc64,
   x86_64, but not on mips, cris, arm, s390, s390x, sparc, sh, parisc.
   Do all architectures have to have it?
   
Indeed, we can't really make cmpxchg a requirement, many
cpus lack it.
