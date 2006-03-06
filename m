Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750771AbWCFQsV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750771AbWCFQsV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 11:48:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751252AbWCFQsU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 11:48:20 -0500
Received: from mx2.suse.de ([195.135.220.15]:11176 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750771AbWCFQsU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 11:48:20 -0500
Date: Mon, 6 Mar 2006 17:48:18 +0100
From: Olaf Hering <olh@suse.de>
To: Paul Mackerras <paulus@samba.org>
Cc: Linus Torvalds <torvalds@osdl.org>, linuxppc-dev@ozlabs.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.6.16-rc5
Message-ID: <20060306164818.GA2523@suse.de>
References: <Pine.LNX.4.64.0602262122000.22647@g5.osdl.org> <20060305140932.GA17132@suse.de> <20060305185923.GA21519@suse.de> <Pine.LNX.4.64.0603051147590.13139@g5.osdl.org> <20060305204231.GA22002@suse.de> <17419.23860.883220.80199@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <17419.23860.883220.80199@cargo.ozlabs.ibm.com>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Mon, Mar 06, Paul Mackeras wrote:

> There are also commits from Ben H that change the way we parse
> addresses from the OF device tree.  If you can bisect a bit further
> that would be good, although you may strike problems between the 401d
> and 6237 commits I mentioned above.

What I have right now is this, which got me in a non-compiling state.
I will pick the udbg stuff and apply the relevant changes to -git5.

==> .git/HEAD <==
463ce0e103f419f51b1769111e73fe8bb305d0ec

==> .git/refs/bisect/bad <==
51d3082fe6e55aecfa17113dbe98077c749f724c

==> .git/refs/bisect/good-5367f2d67c7d0bf1faae90e6e7b4e2ac3c9b5e0f <==
5367f2d67c7d0bf1faae90e6e7b4e2ac3c9b5e0f

==> .git/refs/bisect/good-d1405b869850982f05c7ec0d3f137ca27588192f <==
d1405b869850982f05c7ec0d3f137ca27588192f

==> .git/BISECT_LOG <==
git-bisect start
# good: [5367f2d67c7d0bf1faae90e6e7b4e2ac3c9b5e0f] Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/roland/infiniband
git-bisect good 5367f2d67c7d0bf1faae90e6e7b4e2ac3c9b5e0f
# bad: [977127174a7dff52d17faeeb4c4949a54221881f] Merge master.kernel.org:/pub/scm/linux/kernel/git/gregkh/pci-2.6
git-bisect bad 977127174a7dff52d17faeeb4c4949a54221881f
# bad: [93b47684f60cf25e8cefe19a21d94aa0257fdf36] drivers/*rest*: Replace pci_module_init() with pci_register_driver()
git-bisect bad 93b47684f60cf25e8cefe19a21d94aa0257fdf36
# bad: [03929c76f3e5af919fb762e9882a9c286d361e7d] ppc32: cpm_uart: fix xchar sending
git-bisect bad 03929c76f3e5af919fb762e9882a9c286d361e7d
# bad: [d4e4b3520c4df46cf1d15a56379a6fa57e267b7d] powerpc: fix for "Update OF address parsers"
git-bisect bad d4e4b3520c4df46cf1d15a56379a6fa57e267b7d
# bad: [404849bbd2bfd62e05b36f4753f6e1af6050a824] powerpc: Remove some unneeded fields from the paca
git-bisect bad 404849bbd2bfd62e05b36f4753f6e1af6050a824
# good: [d1405b869850982f05c7ec0d3f137ca27588192f] powerpc: Add OF address parsing code (#2)
git-bisect good d1405b869850982f05c7ec0d3f137ca27588192f
# bad: [e199500c6280aadf98c185db99fd24ab61ebe0c7] powerpc: partly merge iseries do_IRQ
git-bisect bad e199500c6280aadf98c185db99fd24ab61ebe0c7
# bad: [2c5bd01f8f5d7c655d9d1aa60b696d980947e3be] powerpc: convert macio_asic to use prom_parse
git-bisect bad 2c5bd01f8f5d7c655d9d1aa60b696d980947e3be
# bad: [51d3082fe6e55aecfa17113dbe98077c749f724c] powerpc: Unify udbg (#2)
git-bisect bad 51d3082fe6e55aecfa17113dbe98077c749f724c


