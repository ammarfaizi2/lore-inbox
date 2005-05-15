Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261268AbVEOVqV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261268AbVEOVqV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 May 2005 17:46:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261263AbVEOVqV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 May 2005 17:46:21 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:45816 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S261261AbVEOVqQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 May 2005 17:46:16 -0400
To: Petr Baudis <pasky@ucw.cz>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org
Subject: Re: git repository for net drivers available
References: <42841A3F.7020909@pobox.com> <4284C54E.3060907@linux.intel.com>
	<4284C7DA.1020707@pobox.com> <20050515200514.GA31414@pasky.ji.cz>
From: Junio C Hamano <junkio@cox.net>
Date: Sun, 15 May 2005 14:46:11 -0700
In-Reply-To: <20050515200514.GA31414@pasky.ji.cz> (Petr Baudis's message of
 "Sun, 15 May 2005 22:05:14 +0200")
Message-ID: <7vacmwqi1o.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "PB" == Petr Baudis <pasky@ucw.cz> writes:

PB> Dear diary, on Fri, May 13, 2005 at 05:29:30PM CEST, I got a letter
PB> where Jeff Garzik <jgarzik@pobox.com> told me that...
>> Looks like cogito is using $repo/heads/$branch, whereas my git repo is 
>> using $repo/branches/$branch.

PB> Would it be a big problem to use refs/heads/$branch? That's the
PB> currently commonly agreed convention about location for storing branch
PB> heads, not just some weird Cogito-specific invention. And it'd be very
PB> nice to have those locations consistent across git repositories.

Since Jeff brought up $repo/branches/$branch, you may also want
to add that $repo/branches/$branch is used to record the URL of
the remote $branch (the information used to be in a flat file
$repo/remotes, branch name and URL separated by shell $IFS, one
record on each line), and is quite different from those 40-byte
SHA1 plus LF files you see in $repo/refs/*/ directory.

I think it is a reasonable one, I also follow the
$repo/branches/$branch convention Cogito uses, and I would
encorage other Porcelain implementations to follow suit.

