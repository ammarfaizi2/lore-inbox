Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281166AbRKTXg3>; Tue, 20 Nov 2001 18:36:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281162AbRKTXgU>; Tue, 20 Nov 2001 18:36:20 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:40719 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S281166AbRKTXgF>;
	Tue, 20 Nov 2001 18:36:05 -0500
Date: Tue, 20 Nov 2001 21:35:40 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: "David S. Miller" <davem@redhat.com>
Cc: <akpm@zip.com.au>, <dmaas@dcine.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Swap
In-Reply-To: <20011120.150154.46465259.davem@redhat.com>
Message-ID: <Pine.LNX.4.33L.0111202134550.4079-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Nov 2001, David S. Miller wrote:
>    From: Andrew Morton <akpm@zip.com.au>
>    Date: Tue, 20 Nov 2001 14:23:38 -0800
>
>    Could you please explain further?  What's more expensive
>    than the copy?
>
> TLB misses add to the cost, and this overhead is more than
> "noise".

Well, this could have something to do with the fact
that our page fault handler only maps in _1_ page at
a time, so we're trapping into the pagefault handler
every 4kB...

Rik
-- 
Shortwave goes a long way:  irc.starchat.net  #swl

http://www.surriel.com/		http://distro.conectiva.com/

