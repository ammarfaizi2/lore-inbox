Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263325AbTLUQPI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 11:15:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263357AbTLUQPI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 11:15:08 -0500
Received: from ping.ovh.net ([213.186.33.13]:59593 "EHLO ping.ovh.net")
	by vger.kernel.org with ESMTP id S263325AbTLUQPF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 11:15:05 -0500
Date: Sun, 21 Dec 2003 17:13:24 +0100
From: Octave <oles@ovh.net>
To: Willy Tarreau <willy@w.ods.org>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Peter Zaitsev <peter@mysql.com>, linux-kernel@vger.kernel.org
Subject: Re: lot of VM problem with 2.4.23
Message-ID: <20031221161324.GN25043@ovh.net>
References: <20031221001422.GD25043@ovh.net> <1071999003.2156.89.camel@abyss.local> <Pine.LNX.4.58L.0312211235010.6632@logos.cnet> <20031221150312.GJ25043@ovh.net> <20031221154227.GB1323@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20031221154227.GB1323@alpha.home.local>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> one of my collegues had a server which occasionally crashed at night with
> mysql taking all the memory. I think it was with an old 2.4.18 kernel. He
> finally reinstalled all the machine and it never happened anymore. So
> eventhough it works for you with 2.4.22, perhaps 2.4.23 triggers a mysql
> bug which is fixed in more recent releases ?

Willy,
Hmm ... could be, but I don't think so. I use last mysql3 version and
I have this problem without mysql too.

For example on this box there is no mysql (Piv 2.4GHz/512Mo):
__alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
VM: killing process watchdog
__alloc_pages: 1-order allocation failed (gfp=0x1f0/0)
__alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
VM: killing process watchdog

# free
             total       used       free     shared    buffers     cached
Mem:        514468     508416       6052          0      11608     205464
-/+ buffers/cache:     291344     223124
Swap:       265032      77524     187508

When I swithed more that 700 servers 10-15 days ago to 2.4.23, I saw that 
servers swaped less that with 2.4.22. So I believe VM was modified. Cool.
Great job. Now servers begin to crash :/ 

Octave

