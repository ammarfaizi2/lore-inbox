Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289770AbSA2R0G>; Tue, 29 Jan 2002 12:26:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289775AbSA2RZ5>; Tue, 29 Jan 2002 12:25:57 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:60686 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S289769AbSA2RZv>; Tue, 29 Jan 2002 12:25:51 -0500
Date: Tue, 29 Jan 2002 15:25:26 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Oliver Xymoron <oxymoron@waste.org>
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        Linus Torvalds <torvalds@transmeta.com>,
        Josh MacDonald <jmacd@CS.Berkeley.EDU>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        <reiserfs-list@namesys.com>, <reiserfs-dev@namesys.com>
Subject: Re: Note describing poor dcache utilization under high memory pressure
In-Reply-To: <Pine.LNX.4.44.0201291044060.25443-100000@waste.org>
Message-ID: <Pine.LNX.4.33L.0201291524570.12225-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jan 2002, Oliver Xymoron wrote:

> Daniel's approach seems to be workable (once he's spelled out all the
> details) but it misses the big performance win for fork/exec, which is
> surely the common case. Given that exec will be throwing away all these
> mappings, we can safely assume that we will not be inheriting many shared
> mappings from parents of parents so Daniel's approach also still ends up
> marking most of the pages RO still.

It gets worse.  His approach also needs to adjust the reference
counts on all pages (and swap pages).

kind regards,

Rik
-- 
DMCA, SSSCA, W3C?  Who cares?  http://thefreeworld.net/

http://www.surriel.com/		http://distro.conectiva.com/

