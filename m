Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751131AbWAYL0X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751131AbWAYL0X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 06:26:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751127AbWAYL0X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 06:26:23 -0500
Received: from ns.miraclelinux.com ([219.118.163.66]:46489 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1751122AbWAYL0V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 06:26:21 -0500
Date: Wed, 25 Jan 2006 20:26:25 +0900
To: linux-kernel@vger.kernel.org
Cc: Richard Henderson <rth@twiddle.net>,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Russell King <rmk@arm.linux.org.uk>, Ian Molton <spyro@f2s.com>,
       dev-etrax@axis.com, David Howells <dhowells@redhat.com>,
       Yoshinori Sato <ysato@users.sourceforge.jp>,
       Linus Torvalds <torvalds@osdl.org>, linux-ia64@vger.kernel.org,
       Hirokazu Takata <takata@linux-m32r.org>, linux-m68k@vger.kernel.org,
       Greg Ungerer <gerg@uclinux.org>, linux-mips@linux-mips.org,
       parisc-linux@parisc-linux.org, linuxppc-dev@ozlabs.org,
       linux390@de.ibm.com, linuxsh-dev@lists.sourceforge.net,
       linuxsh-shmedia-dev@lists.sourceforge.net, sparclinux@vger.kernel.org,
       ultralinux@vger.kernel.org, Miles Bader <uclinux-v850@lsi.nec.co.jp>,
       Andi Kleen <ak@suse.de>, Chris Zankel <chris@zankel.net>
Subject: [PATCH 0/6] RFC: use include/asm-generic/bitops.h
Message-ID: <20060125112625.GA18584@miraclelinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
From: mita@miraclelinux.com (Akinobu Mita)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Large number of boilerplate bit operations written in C-language
are scattered around include/asm-*/bitops.h.
These patch series gather them into include/asm-generic/bitops.h. And

- kill duplicated code and comment (about 4000lines)
- use better C-language equivalents
- help porting new architecture (now include/asm-generic/bitops.h is not
  referenced from anywhere)

