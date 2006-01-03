Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751075AbWACKGt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751075AbWACKGt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 05:06:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751139AbWACKGt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 05:06:49 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:6587 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751075AbWACKGt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 05:06:49 -0500
Date: Tue, 3 Jan 2006 11:06:32 +0100
From: Ingo Molnar <mingo@elte.hu>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>, Nicolas Pitre <nico@cam.org>,
       Jes Sorensen <jes@trained-monkey.org>, Al Viro <viro@ftp.linux.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: [patch 00/19] mutex subsystem, -V11
Message-ID: <20060103100632.GA23154@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


this is version -V11 of the generic mutex subsystem, against v2.6.15.
It consists of the following 19 patches:

  add-atomic-xchg.patch
  add-function-typecheck.patch

  mutex-generic-asm-implementations.patch
  mutex-asm-mutex.h-i386.patch
  mutex-asm-mutex.h-x86_64.patch
  mutex-asm-mutex.h-arm.patch
  mutex-arch-mutex-h.patch
  mutex-core.patch

  mutex-docs.patch
  mutex-debug.patch
  mutex-debug-more.patch

  sem2mutex-xfs.patch
  sem2mutex-vfs-i-sem.patch
  sem2mutex-vfs-i-sem-more.patch
  sem2mutex-simple-ones.patch

  sem2completion-sx8.patch
  sem2completion-cpu5wdt.patch
  sem2completion-ide-gendev.patch
  sem2completion-loop.patch

the patches should work fine on every Linux architecture. They can also 
be downloaded from:

  http://redhat.com/~mingo/generic-mutex-subsystem/

Changes since -V10:

  38 files changed, 99 insertions(+), 94 deletions(-)

- export mutex_trylock() too (reported by Antti Salmela)

- fixed attribution From: lines

- finished the i_sem -> i_mutex conversion: fixed up all affected 
  documentation as well, and rarely used code. It builds fine under
  allyesconfig.

- DECLARE_MUTEX -> DEFINE_MUTEX in cpufreq

- small cleanups

	Ingo
