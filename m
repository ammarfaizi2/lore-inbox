Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263766AbTLUS4H (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 13:56:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263836AbTLUS4H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 13:56:07 -0500
Received: from intra.cyclades.com ([64.186.161.6]:10887 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S263766AbTLUS4E
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 13:56:04 -0500
Date: Sun, 21 Dec 2003 16:45:38 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Octave <oles@ovh.net>
Cc: Willy Tarreau <willy@w.ods.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Peter Zaitsev <peter@mysql.com>, linux-kernel@vger.kernel.org
Subject: Re: lot of VM problem with 2.4.23
In-Reply-To: <20031221161324.GN25043@ovh.net>
Message-ID: <Pine.LNX.4.58L.0312211643470.6632@logos.cnet>
References: <20031221001422.GD25043@ovh.net> <1071999003.2156.89.camel@abyss.local>
 <Pine.LNX.4.58L.0312211235010.6632@logos.cnet> <20031221150312.GJ25043@ovh.net>
 <20031221154227.GB1323@alpha.home.local> <20031221161324.GN25043@ovh.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 21 Dec 2003, Octave wrote:

> > one of my collegues had a server which occasionally crashed at night with
> > mysql taking all the memory. I think it was with an old 2.4.18 kernel. He
> > finally reinstalled all the machine and it never happened anymore. So
> > eventhough it works for you with 2.4.22, perhaps 2.4.23 triggers a mysql
> > bug which is fixed in more recent releases ?
>
> Willy,
> Hmm ... could be, but I don't think so. I use last mysql3 version and
> I have this problem without mysql too.
>
> For example on this box there is no mysql (Piv 2.4GHz/512Mo):
> __alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
> VM: killing process watchdog
> __alloc_pages: 1-order allocation failed (gfp=0x1f0/0)
> __alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
> VM: killing process watchdog
>
> # free
>              total       used       free     shared    buffers     cached
> Mem:        514468     508416       6052          0      11608     205464
> -/+ buffers/cache:     291344     223124
> Swap:       265032      77524     187508
>
> When I swithed more that 700 servers 10-15 days ago to 2.4.23, I saw that
> servers swaped less that with 2.4.22. So I believe VM was modified. Cool.
> Great job. Now servers begin to crash :/

Octave,

Can you please "echo 1 > /proc/sys/vm_gfp_debug" (to turn VM debugging on)
and rerun the tests which crash the box.

Also run "vmstat 5" in the background and save that to a file.


