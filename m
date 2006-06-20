Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751097AbWFTVPa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751097AbWFTVPa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 17:15:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751099AbWFTVPa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 17:15:30 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:62361 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751097AbWFTVPa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 17:15:30 -0400
Date: Tue, 20 Jun 2006 22:15:24 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       linux1394-devel@lists.sourceforge.net,
       Ben Collins <bcollins@ubuntu.com>,
       Jody McIntyre <scjody@modernduck.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [git pull] ieee1394 tree for 2.6.18
Message-ID: <20060620211524.GU27946@ftp.linux.org.uk>
References: <44954102.3090901@s5r6.in-berlin.de> <Pine.LNX.4.64.0606191902350.5498@g5.osdl.org> <20060620025552.GO27946@ftp.linux.org.uk> <Pine.LNX.4.64.0606192007460.5498@g5.osdl.org> <20060620175321.GA7463@flint.arm.linux.org.uk> <44984CA1.5010308@s5r6.in-berlin.de> <20060620193422.GA10748@flint.arm.linux.org.uk> <44986126.506@s5r6.in-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44986126.506@s5r6.in-berlin.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2006 at 10:57:10PM +0200, Stefan Richter wrote:
> Russell King wrote:
> >The point was to try to establish when we could consider the tree from
> >which we'd asked Linus to pull from as being sufficiently old that it
> >would not be pulled from without another request being sent - or if it
> >was pulled from, that we wouldn't get an email from Linus about the fact
> >there was new stuff in there.
> 
> You could /a/ try to come to an agreement with him about a less brittle 
> protocol, or /b/ think of your mail as an "announcement" rather than a 
> "request" (for your peace of mind) and follow up with a repost of the 
> announcement if you come to know that your updates did not appear in 
> Linus' tree when the end of a merge window is near.

c) no matter how badly your variant of git might suck, on server you
can always do
	echo [commit-ID] > .git/refs/heads/for-linus-<date>
and ask him to pull that branch from that server (if your version of
git doesn't suck, git checkout -b for-linus-<date>; git checkout <your
previous branch> will do it).

Then move on with the life, using whatever you are using.  The question when
to remove that file... hell, run "trim the stuff more than month old"
from cron every month and forget about it.
