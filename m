Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750916AbVIKVYz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750916AbVIKVYz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 17:24:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750922AbVIKVYz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 17:24:55 -0400
Received: from smtp.osdl.org ([65.172.181.4]:57751 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750881AbVIKVYy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 17:24:54 -0400
Date: Sun, 11 Sep 2005 14:24:48 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Roland Dreier <rolandd@cisco.com>
cc: Sam Ravnborg <sam@ravnborg.org>, Peter Osterlund <petero2@telia.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Git Mailing List <git@vger.kernel.org>
Subject: Re: What's up with the GIT archive on www.kernel.org?
In-Reply-To: <52irx7cnw5.fsf@cisco.com>
Message-ID: <Pine.LNX.4.58.0509111422510.3242@g5.osdl.org>
References: <m3mzmjvbh7.fsf@telia.com> <Pine.LNX.4.58.0509110908590.4912@g5.osdl.org>
 <20050911185711.GA22556@mars.ravnborg.org> <Pine.LNX.4.58.0509111157360.3242@g5.osdl.org>
 <20050911194630.GB22951@mars.ravnborg.org> <Pine.LNX.4.58.0509111251150.3242@g5.osdl.org>
 <52irx7cnw5.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 11 Sep 2005, Roland Dreier wrote:
> 
> Does "everything" include someone doing
> 
>     git clone rsync://rsync.kernel.org/pub/scm/linux/kernel/git/roland/whatever.git

Nope. Only server-side smart protocols will handle this.

There is such an anonymous server, btw: "git-daemon" implements anonymous 
access much more efficient than rsync/http. Sadly, kernel.org still 
doesn't offer it (but it's now used in the wild, ie I've done a couple of 
merges with people running the git daemon).

> In other words, is the git network transport smart enough to handle
> the alternates path?

The _git_ network transport is. rsync and http aren't.

		Linus
