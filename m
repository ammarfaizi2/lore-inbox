Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291254AbSBLX3g>; Tue, 12 Feb 2002 18:29:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291263AbSBLX31>; Tue, 12 Feb 2002 18:29:27 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:39694 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S291254AbSBLX3S>;
	Tue, 12 Feb 2002 18:29:18 -0500
Date: Tue, 12 Feb 2002 21:29:06 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@zip.com.au>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] sys_sync livelock fix
In-Reply-To: <E16amOF-0003Rk-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33L.0202122128151.12554-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Feb 2002, Alan Cox wrote:

> > Given that /bin/sync calls write_unlocked_buffers() three times,
> > that's good enough.  sync still takes aaaaaages, but it terminates.
>
> Whats wrong with sync not terminating when there is permenantly I/O
> left ?

I've seen it get stuck for half an hour.  This was not
during a test, but on a real server which was in a busy
period...

> Its seems preferably to suprise data loss

The data isn't lost, it'll simply get written out to
disk later.

cheers,

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

