Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315570AbSECGdl>; Fri, 3 May 2002 02:33:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315571AbSECGdk>; Fri, 3 May 2002 02:33:40 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:42786 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S315570AbSECGdg>; Fri, 3 May 2002 02:33:36 -0400
Date: Fri, 3 May 2002 08:34:19 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Roman Zippel <zippel@linux-m68k.org>, Ralf Baechle <ralf@uni-koblenz.de>,
        Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: discontiguous memory platforms
Message-ID: <20020503083419.X11414@dualathlon.random>
In-Reply-To: <Pine.LNX.4.21.0205021539460.23113-100000@serv> <E173LNK-00027F-00@starship> <3CD19640.3B85BF76@linux-m68k.org> <E173MyQ-00028q-00@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 02, 2002 at 10:14:02PM +0200, Daniel Phillips wrote:
> mechanism.  We've been over the NUMA-Q and mips32 cases in detail, so I won't

I didn't hear the mips32 argument, but for NUMA-Q nonlinear is
definitely the last thing you want, there is no discontinuity in the ram
in each node. nonlinaer can make sense _only_ when there are ram holes
in the middle of the per-numa-node-mem_map. NUMA-Q has the need of
spreading the zone_normal over the different nodes and nonlinaer is
definitely not needed and it won't help in achieving that object, NUMA-Q
infact needs discontigmem topology description to allow the numa
optimizations so it cannot use nonlinear anyways to handle the holes
between the numa-nodes.

Andrea
