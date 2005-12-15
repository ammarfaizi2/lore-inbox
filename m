Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965078AbVLOAl1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965078AbVLOAl1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 19:41:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965096AbVLOAl1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 19:41:27 -0500
Received: from mx1.redhat.com ([66.187.233.31]:1221 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965078AbVLOAl0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 19:41:26 -0500
Date: Wed, 14 Dec 2005 19:40:06 -0500
From: Dave Jones <davej@redhat.com>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] offer CC_OPTIMIZE_FOR_SIZE only if EXPERIMENTAL
Message-ID: <20051215004006.GA19354@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Jesper Juhl <jesper.juhl@gmail.com>, Adrian Bunk <bunk@stusta.de>,
	Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
	linux-kernel@vger.kernel.org
References: <20051214191006.GC23349@stusta.de> <20051214140531.7614152d.akpm@osdl.org> <20051214221304.GE23349@stusta.de> <9a8748490512141418w2a3811a9iffe83b5f285e2910@mail.gmail.com> <9a8748490512141428q29f39ca5x66d2c52e22aa9208@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a8748490512141428q29f39ca5x66d2c52e22aa9208@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2005 at 11:28:13PM +0100, Jesper Juhl wrote:

 > I should probably back this up with *why* it boggles my mind.
 > 
 > -Os has been in EMBEDDED for ages, so it's not been tested by the
 > majority of users with the wide range of compilers etc that people
 > use.

Fedora has had this enabled most of the time for x86, x86-64, ia64,
s390, s390x, ppc32 and ppc64 for a long time.  From time to time
when a gcc bug has been tickled it's been disabled again until its
been worked out, but for the most part, it's been a complete non-event
wrt regressions.  In the ~2 years that we've had it enabled I recall
2-3 occasions where it broke something badly (and it was really noticable,
like "networking doesn't work any more", or "x86-64 stopped booting"[1]),
and once or twice when moving to a newer gcc point release, it tripped an ICE.

The RHEL4 kernel has also been built this way since day 1.

		Dave

[1] In that particular case, it was broken asm-x86-64/ macros that 
    just happened to work at -O2 by chance, so it actually found latent bugs.

