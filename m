Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135536AbRDSDhe>; Wed, 18 Apr 2001 23:37:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135539AbRDSDhZ>; Wed, 18 Apr 2001 23:37:25 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:16401 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S135536AbRDSDhJ>;
	Wed, 18 Apr 2001 23:37:09 -0400
Date: Thu, 19 Apr 2001 00:35:19 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Alexander Viro <viro@math.psu.edu>
Cc: Daniel Phillips <phillips@nl.linux.org>, linux-kernel@vger.kernel.org,
        adilger@turbolinux.com, ext2-devel@lists.sourceforge.net
Subject: Re: Ext2 Directory Index - Delete Performance
In-Reply-To: <Pine.GSO.4.21.0104182319100.15153-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.21.0104190031450.1685-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Apr 2001, Alexander Viro wrote:

> Sorry, but that's just plain wrong. We shouldn't keep inode table in
> buffer-cache at all.

Then tell me, how exactly DO you plan to do write clustering
of inodes when you want to flush them to disk ?

If you don't keep them in the buffer cache for a while (or in
the page cache, for that matter), there's no way you can get
efficient IO clustering done...

Also, the buffer cache referenced bit will be extremely useful
for things like indirect blocks, etc...

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

