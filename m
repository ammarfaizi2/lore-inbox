Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964905AbWFTEbv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964905AbWFTEbv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 00:31:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964917AbWFTEbv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 00:31:51 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:31907 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S964905AbWFTEbu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 00:31:50 -0400
Date: Tue, 20 Jun 2006 05:31:48 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Stefan Richter <stefanr@s5r6.in-berlin.de>, linux-kernel@vger.kernel.org,
       linux1394-devel@lists.sourceforge.net,
       Ben Collins <bcollins@ubuntu.com>,
       Jody McIntyre <scjody@modernduck.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [git pull] ieee1394 tree for 2.6.18
Message-ID: <20060620043148.GQ27946@ftp.linux.org.uk>
References: <44954102.3090901@s5r6.in-berlin.de> <Pine.LNX.4.64.0606191902350.5498@g5.osdl.org> <20060620025552.GO27946@ftp.linux.org.uk> <Pine.LNX.4.64.0606192007460.5498@g5.osdl.org> <20060620042250.GP27946@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060620042250.GP27946@ftp.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2006 at 05:22:51AM +0100, Al Viro wrote:
> I'm saying that often _I_ am curious about the log _in_ _some_ _remote_ _tree_.
> Preferably - without fetch + git log + rm .git/refs/tmp + git prune, which
> is how I do that now.  git prune is quite slow, for one thing...
> 
> It's not about kernel or getting stuff merged; the question is about git
> and cheaper way to do the thing I often find useful.  IOW, read that as
> "BTW, is there a way to get such information out of git without too much
> PITA?"

Actually, posting that _was_ useful - staring at the above got me to
realize that git clone -l -s -n + git fetch + git log + rm -rf would
work just fine and be much faster than the variant above...

Still, that looks like excessive from server, if nothing else.  Is there
a better way to do it?  Getting remote log, that is, preferably with
a way to get it starting at the point I have in local tree.
