Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312031AbSCQNtb>; Sun, 17 Mar 2002 08:49:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312032AbSCQNtV>; Sun, 17 Mar 2002 08:49:21 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:1037 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S312031AbSCQNtM>;
	Sun, 17 Mar 2002 08:49:12 -0500
Date: Sun, 17 Mar 2002 10:48:54 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Cc: yodaiken@fsmlabs.com, Andi Kleen <ak@suse.de>,
        Paul Mackerras <paulus@samba.org>, <linux-kernel@vger.kernel.org>,
        <torvalds@transmeta.com>
Subject: Re: [Lse-tech] Re: 10.31 second kernel compile
In-Reply-To: <200203162105.g2GL5H914363@vindaloo.ras.ucalgary.ca>
Message-ID: <Pine.LNX.4.44L.0203171045490.2181-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Mar 2002, Richard Gooch wrote:

> And I can afford a few MiB of RAM for PTE's and such for *the one
> process which is mapping my huge data files*!

Once you have this, you might as well make that granularity
per VMA.

This gives you the advantage of being able to share the
mapping for libc.so ;)

>From what I can see, you'll basically want large pages
for:

1) Oracle and maybe other large shared memory situations
   where the page table overhead would otherwise be
   prohibitively high

2) scientific calculations and other programs with a huge
   dataset where TLB misses would be prohibitively slow

regards,

Rik
-- 
<insert bitkeeper endorsement here>

http://www.surriel.com/		http://distro.conectiva.com/

