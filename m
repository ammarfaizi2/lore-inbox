Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312740AbSDFTPE>; Sat, 6 Apr 2002 14:15:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312748AbSDFTPD>; Sat, 6 Apr 2002 14:15:03 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:43769 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S312740AbSDFTPC>; Sat, 6 Apr 2002 14:15:02 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20020406093046.F6087@work.bitmover.com> 
To: Larry McVoy <lm@bitmover.com>
Cc: Dave Jones <davej@suse.de>, Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.5.8-pre1 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 06 Apr 2002 20:14:54 +0100
Message-ID: <28109.1018120494@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


lm@bitmover.com said:
> bk pull the two repositories together, run bk -r check -ap and watch
> it  get unhappy.

> Mutter darkly that people really seem to not understand it's a
> distributed, replicated system and playing with the datastructures
> will make it unhappy.

Hehe yeah - but as I said, I'd just committed it to the wrong repository, 
so the next step was to undo the changeset from that one anyway. 

Then as a sanity check, 'bk send' it from the repository to which I'd
transplanted it, compare with the original results of 'bk send' of the 
same changeset from the original tree, blow away everything and 
'bk receive' the changeset into a fresh clone of the proper tree.

Mutter ye not - at least I ditched the idea of copying the SCCS files, 
removing the 'dD' lines which seem to mean they're part of a committed 
changeset, then making a new changeset from the 'pending' deltas :)

--
dwmw2


