Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282667AbRK0AAU>; Mon, 26 Nov 2001 19:00:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282665AbRK0AAB>; Mon, 26 Nov 2001 19:00:01 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:23306 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S282664AbRKZX7t>;
	Mon, 26 Nov 2001 18:59:49 -0500
Date: Mon, 26 Nov 2001 21:59:27 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Nathan G. Grennan" <ngrennan@okcforum.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Unresponiveness of 2.4.16
In-Reply-To: <E168U3m-00077F-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33L.0111262156140.4079-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Nov 2001, Alan Cox wrote:

> > Any ideas of how to fix this for 2.4.16?
>
> If it is the VM then watch for a patch from Rik for 2.4.16 + RielVM.
> If that helps then we know its VM related , if not then we know to
> look at other suspects

The patch to 2.4.16 + rielvm (well, a merge between my VM and
Andrea's VM) is available on my home page and seems stable now.
FYI, my 64MB dual pentium test box seems to "happily" survive
a 'make -j bzImage' over NFS...

However, I suspect this unresponsiveness issue is related to
either IO scheduling or write throttling, and that code is
the same in both VMs. I'll take a look at smoothing out writes
so we can get this thing fixed in both VMs.

The patch is on http://www.surriel.com/patches/

regards,

Rik
-- 
Shortwave goes a long way:  irc.starchat.net  #swl

http://www.surriel.com/		http://distro.conectiva.com/

