Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314657AbSEVVYj>; Wed, 22 May 2002 17:24:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313189AbSEVVYi>; Wed, 22 May 2002 17:24:38 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:61702 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S314657AbSEVVYg>; Wed, 22 May 2002 17:24:36 -0400
Date: Wed, 22 May 2002 14:23:39 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
cc: William Lee Irwin III <wli@holomorphy.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "M. Edward Borasky" <znmeb@aracnet.com>,
        <linux-kernel@vger.kernel.org>, <andrea@suse.de>, <riel@surriel.com>,
        <akpm@zip.com.au>
Subject: Re: Have the 2.4 kernel memory management problems on large machines
 been fixed?
In-Reply-To: <384590000.1022102334@flay>
Message-ID: <Pine.LNX.4.33.0205221421180.1531-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 22 May 2002, Martin J. Bligh wrote:
> 
> If we could get the apps (well, Oracle) to co-operate, we could just use
> clone ;-) Having this transparent for shmem segments would be really nice.

The thing is, we won't get Oracle to rewrite a lot for a completely
threaded system. And clone does _not_ come with a way to share only parts
of the VM, and never will - that's fundamentally against the way "struct 
mm_struct" works. 

Oracle is apparently already used to magic shmem-like things, so doing 
that is probably acceptable to them.

		Linus

