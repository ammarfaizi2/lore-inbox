Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291086AbSBGCkw>; Wed, 6 Feb 2002 21:40:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291085AbSBGCkm>; Wed, 6 Feb 2002 21:40:42 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:40943 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S291080AbSBGCkg>;
	Wed, 6 Feb 2002 21:40:36 -0500
Date: Wed, 6 Feb 2002 21:40:35 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Andi Kleen <ak@muc.de>
cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix page cache limit wrapping in filesystems
In-Reply-To: <20020207033342.A2032@averell>
Message-ID: <Pine.GSO.4.21.0202062140130.22680-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 7 Feb 2002, Andi Kleen wrote:

> 
> Several file systems in tree that nominally support files >2GB set their
> s_maxbytes value to ~0ULL. This has the nasty side effect on 32bit machines
> that when a file write reaches the page cache limit (e.g. 2^43) it'll silently
> wrap and destroy data at the beginning of the file.
> 
> This patch changes the file systems in question to fill in a proper limit. 
> 
> I also have an alternate patch that adds a check for this generically
> in super.c, but preliminary comments from Al suggested that he prefered
> to do it in the file systems, so it is done this way way.
> 
> Patch for 2.5.4pre1. Please consider applying.

Looks OK.

