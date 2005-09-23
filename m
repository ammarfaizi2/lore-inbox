Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750967AbVIWNMR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750967AbVIWNMR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 09:12:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750970AbVIWNMR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 09:12:17 -0400
Received: from w241.dkm.cz ([62.24.88.241]:42445 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750965AbVIWNMQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 09:12:16 -0400
Date: Fri, 23 Sep 2005 15:12:14 +0200
From: Petr Baudis <pasky@suse.cz>
To: git@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] Cogito-0.15.1 (important bugfix)
Message-ID: <20050923131213.GE10255@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,

  I'm announcing the release of 0.15.1 of Cogito, the human-friendly UI
for Linus' GIT. You can find it at

	http://www.kernel.org/pub/software/scm/cogito/

when kernel.org mirroring will go through another short period of
actually working. ;-)

  I'm cc'ing the Linux Kernel mailing list since this release contains
a bugfix for an ugly potential data loss bug, which actually probably
covers nearly all Cogito users (it was introduced in cogito-0.11.2).
If you had some local uncommitted changes and merge new stuff (either
using cg-update or cg-merge), in some cases it would silently trash your
local changes. It was caused by a bogus git-checkout-cache invocation
pointed out by Linus.

  Other interesting stuff:

  * cg-clean -d would remove the arch/ and include/ subdirs in Linux
    kernel - just any directories containing only subdirectories
    (this isn't as horrible as it sounds since you didn't lose anything
    precious you didn't want to lose - you can recover by just doing
    cg-restore)
  * Support for fetching from URLs of the 'git' protocol scheme
  * cg-log -d filters based on date
  * cg-diff works on BSD now
  * Merge cg-(commit|parent|tree)-id to cg-object-id
  * Some significant documentation enhancements
  * Some new tests in the testsuite (for cg-merge ;-)
  * Usual squad of minor bugfixes

  Happy hacking,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
