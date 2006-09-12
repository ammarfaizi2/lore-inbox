Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751396AbWILHOb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751396AbWILHOb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 03:14:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751393AbWILHOb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 03:14:31 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:28054 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751391AbWILHOa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 03:14:30 -0400
Date: Tue, 12 Sep 2006 08:14:29 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       "David S. Miller" <davem@davemloft.net>, linux-audit@redhat.com
Subject: Re: [git pull] audit updates and fixes
Message-ID: <20060912071429.GB29920@ftp.linux.org.uk>
References: <E1GMpjB-0002Ek-NP@ZenIV.linux.org.uk> <20060911180346.c4bfd211.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060911180346.c4bfd211.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Duh...  Two trivial fixes:
* make sure that all non-biarch targets get hookup.
* deal with sparc64 correctly.

[ObGit: git-diff after git-mv + modify a couple of lines generates
deletion+new file instead of rename.  Weird...]

Please, pull from
git.kernel.org/pub/scm/linux/kernel/git/viro/audit-current.git/ audit.b29

Al Viro:
      syscall class hookup for all normal targets
      sparc64 audit syscall classes hookup

 arch/i386/kernel/audit.c             |   51 ---------------------------
 b/arch/i386/kernel/Makefile          |    1
 b/arch/ia64/Kconfig                  |    4 ++
 b/arch/powerpc/Kconfig               |    4 ++
 b/arch/s390/Kconfig                  |    4 ++
 b/arch/sparc64/Kconfig               |    4 ++
 b/arch/sparc64/kernel/Makefile       |    3 +
 b/arch/sparc64/kernel/audit.c        |   66 +++++++++++++++++++++++++++++++++++
 b/arch/sparc64/kernel/compat_audit.c |   37 +++++++++++++++++++
 b/arch/x86_64/Kconfig                |    4 ++
 b/lib/Kconfig                        |    5 ++
 b/lib/Makefile                       |    1
 b/lib/audit.c                        |   53 ++++++++++++++++++++++++++++
 13 files changed, 185 insertions(+), 52 deletions(-)
