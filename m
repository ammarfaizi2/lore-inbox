Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261772AbULGGlv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261772AbULGGlv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 01:41:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261774AbULGGlv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 01:41:51 -0500
Received: from main.gmane.org ([80.91.229.2]:19406 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261772AbULGGlI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 01:41:08 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Martin Pool <mbp@sourcefrog.net>
Subject: Re: make -j4 gets stuck w/ ccache over NFS
Date: Tue, 07 Dec 2004 17:22:43 +1100
Message-ID: <pan.2004.12.07.06.22.36.666301@sourcefrog.net>
References: <20041207022429.GA5295@jupiter.solarsys.private>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: ausrel1.hp.com
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table (Debian GNU/Linux))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Dec 2004 21:24:29 -0500, Mark M. Hoffman wrote:

> Hello:
> 
> I'm using ccache version 2.4 [1].  I just changed ~/.ccache to a symbolic
> link to a directory which is NFS mounted [2].  The kernel source itself is
> on a local FS.  With the ccache suitably primed, when I do a kernel
> compile using 'make -j4' it seems to get stuck for seconds at a time. 
> When it gets unstuck, it blows through a handful of files and then gets
> stuck again.
> 
> When it is stuck, both NFS client and server are almost totally idle.  The
> network itself has almost no other traffic.  It doesn't seem to matter if
> I mount NFS w/ udp or tcp (v3 in both cases).
> 
> If I move ~/.ccache to a local FS, it never gets stuck.  If I just use
> 'make' or even 'make -j2', (I'm pretty sure but not 100%) it never gets
> stuck.

Perhaps ccache is getting jammed/deadlocked trying to take a lock on NFS. 
Maybe you should try getting an ethereal dump of the network traffic.

-- 
Martin


