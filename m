Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751338AbVJKU75@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751338AbVJKU75 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 16:59:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751343AbVJKU75
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 16:59:57 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:47569 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751338AbVJKU74
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 16:59:56 -0400
Date: Tue, 11 Oct 2005 21:59:49 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Borislav Petkov <bbpetkov@yahoo.de>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, tgraf@suug.ch,
       pablo@eurodev.net
Subject: Re: [was: Linux v2.6.14-rc4] fix textsearch build warning
Message-ID: <20051011205949.GU7992@ftp.linux.org.uk>
References: <Pine.LNX.4.64.0510101824130.14597@g5.osdl.org> <20051011145454.GA30786@gollum.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051011145454.GA30786@gollum.tnic>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 11, 2005 at 04:54:54PM +0200, Borislav Petkov wrote:
> I get this when building 14-rc4:
> 
> lib/ts_kmp.c:125: warning: initialization from incompatible pointer type
> lib/ts_bm.c:165: warning: initialization from incompatible pointer type
> lib/ts_fsm.c:318: warning: initialization from incompatible pointer type
> 
> The following trivial patch fixes it.

Umm...  I'd rather get all that stuff dealt with in one go - I've got gfp_t
conversion finished and it's waiting for 2.6.14.

Fix for that one had been sent, actually - see part 4 of gfp_t annotations
series.  Since none of that stuff is critical (the only bug caught so far
had been already fixed - see relayfs patch) and Linus decided to go for
2.6.14-final, let's hold it back and merge as soon as 2.6.14 gets released.
