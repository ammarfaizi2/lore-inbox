Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289496AbSA2LCA>; Tue, 29 Jan 2002 06:02:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289511AbSA2LBv>; Tue, 29 Jan 2002 06:01:51 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:15110 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S289484AbSA2LAG>;
	Tue, 29 Jan 2002 06:00:06 -0500
Date: Tue, 29 Jan 2002 08:59:45 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Oliver Xymoron <oxymoron@waste.org>
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        Linus Torvalds <torvalds@transmeta.com>,
        Josh MacDonald <jmacd@CS.Berkeley.EDU>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        <reiserfs-list@namesys.com>, <reiserfs-dev@namesys.com>
Subject: Re: Note describing poor dcache utilization under high memory pressure
In-Reply-To: <Pine.LNX.4.44.0201281918050.18405-100000@waste.org>
Message-ID: <Pine.LNX.4.33L.0201290859040.32617-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jan 2002, Oliver Xymoron wrote:

> Somewhere in here, the pages have got to all be marked read-only or
> something. If they're not, then either parent or child writing to
> non-faulting addresses will be writing to shared memory.

Either that, or we don't populate the page tables of the
parent and the child at all and have the page tables
filled in at fault time.

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

