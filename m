Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132110AbRCYQsk>; Sun, 25 Mar 2001 11:48:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132117AbRCYQsa>; Sun, 25 Mar 2001 11:48:30 -0500
Received: from smtp1.cern.ch ([137.138.128.38]:27914 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S132110AbRCYQsO>;
	Sun, 25 Mar 2001 11:48:14 -0500
Date: Sun, 25 Mar 2001 18:47:25 +0200
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Jakob Østergaard <jakob@unthought.net>,
        Kevin Buhr <buhr@stat.wisc.edu>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.2 fails to merge mmap areas, 700% slowdown.
Message-ID: <20010325184724.A16840@pcep-jamie.cern.ch>
In-Reply-To: <Pine.LNX.4.31.0103201042360.1990-100000@penguin.transmeta.com> <vba1yrr7w9v.fsf@mozart.stat.wisc.edu> <15032.1585.623431.370770@pizda.ninka.net> <vbay9ty50zi.fsf@mozart.stat.wisc.edu> <vbaelvp3bos.fsf@mozart.stat.wisc.edu> <20010322193549.D6690@unthought.net> <vbawv9hyuj0.fsf@mozart.stat.wisc.edu> <20010324104849.B9686@unthought.net> <vbabsqrvt6o.fsf@mozart.stat.wisc.edu> <20010325051738.A11943@unthought.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010325051738.A11943@unthought.net>; from jakob@unthought.net on Sun, Mar 25, 2001 at 05:17:38AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jakob Østergaard wrote:
> But the bad case was a garbage collector in GCC.  The mmap tricks seem like
> some you may be inclined to actually use in something like garbage collectors.
> Are we sure that the developers of all other garbage collectors out there
> foresaw this problem and didn't do mmap tricks ?

On this theme, some garbage collectors like to write-protect individual
pages, to detect which pages are modified between generations.  The
kernel has never handled this especially well.  It could be argued that
mprotect() and signal() aren't the right way to get this information
though, and it would be better to add a different mechanism.

-- Jamie
