Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263375AbTE0MVz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 08:21:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263381AbTE0MVz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 08:21:55 -0400
Received: from boden.synopsys.com ([204.176.20.19]:18645 "EHLO
	boden.synopsys.com") by vger.kernel.org with ESMTP id S263375AbTE0MVy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 08:21:54 -0400
Date: Tue, 27 May 2003 14:34:53 +0200
From: Alex Riesen <alexander.riesen@synopsys.COM>
To: linux-kernel@vger.kernel.org
Cc: nfs@lists.sourceforge.net, Neil Brown <neilb@cse.unsw.edu.au>
Subject: Re: NFS root: New error messages in latest bk
Message-ID: <20030527123453.GU32559@Synopsys.COM>
Reply-To: alexander.riesen@synopsys.COM
Mail-Followup-To: linux-kernel@vger.kernel.org,
	nfs@lists.sourceforge.net, Neil Brown <neilb@cse.unsw.edu.au>
References: <3E47D057.4070205@walrond.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E47D057.4070205@walrond.org>
Organization: Synopsys, Inc.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Walrond, Mon, Feb 10, 2003 17:16:23 +0100:
> Latest bk 2.5;

2.5.70 here

> Just booted with NFS root and noticed these new error messages in dmesg:
> 
> NFS: server cheating in read reply: count 4096 > recvd 1000
> NFS: giant filename in readdir (len 0xcb2d2053)!
> 

I have almost the same, but without the "server cheating":

16:12:06 NFS: giant filename in readdir (len c8f2d9f0)!

got this by doing "find /mnt -type f | xargs cat > /dev/null".
The server is 2.4.20-ck4 (Con Kolivas patches: aavm, preempt, lolatency).

Also seen something about 7 min later (the find was still running):

16:19:22 nfs: server server1 not responding, still trying
16:19:25 nfs: server server1 OK

The "server1" (my desktop machine) was doing almost nothing at this time
and felt ok (still does).

-alex

