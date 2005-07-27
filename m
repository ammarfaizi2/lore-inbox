Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262095AbVG0Jk4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262095AbVG0Jk4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 05:40:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262108AbVG0Jkz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 05:40:55 -0400
Received: from baythorne.infradead.org ([81.187.226.107]:64186 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S262080AbVG0Jkt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 05:40:49 -0400
Subject: Re: Linux BKCVS kernel history git import..
From: David Woodhouse <dwmw2@infradead.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: tglx@linutronix.de, Git Mailing List <git@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0507261136280.19309@g5.osdl.org>
References: <Pine.LNX.4.58.0507261136280.19309@g5.osdl.org>
Content-Type: text/plain
Date: Wed, 27 Jul 2005 10:40:38 +0100
Message-Id: <1122457238.3027.37.camel@baythorne.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by baythorne.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-07-26 at 11:57 -0700, Linus Torvalds wrote:
> If somebody adds some logic to "parse_commit()" to do the "fake parent"
> thing, you can stitch the histories together and see the end result as one
> big tree. Even without that, you can already do things like
> 
>         git diff v2.6.10..v2.6.12

That's a bit of a hack which really doesn't belong in the git tools.
It's not particularly hard to reparent the tree for real -- I'd much
rather see a tool added to git which can _actually_ change the
1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 commit to have a parent of
0bcc493c633d78373d3fcf9efc29d6a710637519, and ripple the corresponding
SHA1 changes up to the current HEAD.

Note that the latter commit ID I gave there was actually the 2.6.12-rc2
commit in Thomas' history import, not your own. Thomas has done a lot of
work on it, and it has the full names extracted from the shortlog
script, full timestamps, branch/merge history and consistent character
sets in the commit logs. I'd definitely suggest that you use that
instead of the import from bkcvs.

http://www.kernel.org/git/?p=linux/kernel/git/tglx/history.git;a=summary

-- 
dwmw2


