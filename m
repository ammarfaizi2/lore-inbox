Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312575AbSDENNn>; Fri, 5 Apr 2002 08:13:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312576AbSDENNd>; Fri, 5 Apr 2002 08:13:33 -0500
Received: from pizda.ninka.net ([216.101.162.242]:49300 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S312575AbSDENNX>;
	Fri, 5 Apr 2002 08:13:23 -0500
Date: Fri, 05 Apr 2002 05:07:06 -0800 (PST)
Message-Id: <20020405.050706.109220970.davem@redhat.com>
To: jurgen@pophost.eunet.be
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19-pre6 doesn't compile on Alpha and sparc64
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020405130224.GF22422@sparkie.is.traumatized.org>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Jurgen Philippaerts <jurgen@pophost.eunet.be>
   Date: Fri, 5 Apr 2002 15:02:24 +0200

   On Fri, Apr 05, 2002 at 03:00:11PM +0200, Jurgen Philippaerts wrote:
   > On Fri, Apr 05, 2002 at 02:00:14PM +0200, Alexander Viro wrote:
   > > 
   > > > init/do_mounts.c:45: parse error before `mount_initrd'
   > > [snip]
   > > 
   > > Looks like a missing init.h - sorry, this sucker didn't get caught (on
   > > x86 slab.h ends up pulling it in, on alpha it doesn't).
   > > 
   > > Fix: add #include <linux/init.h> in init/do_mounts.c
   > 
   > same on sparc64.
   > adding the extra #include fixes it.
   
   but then it goes wrong with `make modules`
   
Add include of linux/init.h, fix declarations of TS_open and
TS_release to return int instead of ssize_t.

Franks a lot,
David S. Miller
davem@redhat.com
