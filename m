Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317131AbSEXPGF>; Fri, 24 May 2002 11:06:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317135AbSEXPGE>; Fri, 24 May 2002 11:06:04 -0400
Received: from pizda.ninka.net ([216.101.162.242]:15341 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S317131AbSEXPGD>;
	Fri, 24 May 2002 11:06:03 -0400
Date: Fri, 24 May 2002 07:51:33 -0700 (PDT)
Message-Id: <20020524.075133.118235229.davem@redhat.com>
To: torvalds@transmeta.com
Cc: andrea@suse.de, linux-kernel@vger.kernel.org, viro@math.psu.edu
Subject: Re: negative dentries wasting ram
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0205240737400.26171-100000@home.transmeta.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Linus Torvalds <torvalds@transmeta.com>
   Date: Fri, 24 May 2002 07:43:32 -0700 (PDT)
   
   However, you're right that it probably doesn't help to do this after
   "unlink()" - it's probably only worth doing when actually doing a
   "lookup()" that fails.

There was some stupidity in how rm -rf * works that I remember from
some NFS hacking, but it may not be effected by this.
