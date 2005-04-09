Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261404AbVDIXPQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261404AbVDIXPQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Apr 2005 19:15:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261422AbVDIXOs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Apr 2005 19:14:48 -0400
Received: from fire.osdl.org ([65.172.181.4]:16870 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261404AbVDIXMF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Apr 2005 19:12:05 -0400
Date: Sat, 9 Apr 2005 16:13:51 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: "David S. Miller" <davem@davemloft.net>
cc: andrea@suse.de, mbp@sourcefrog.net, linux-kernel@vger.kernel.org,
       dlang@digitalinsight.com
Subject: Re: Kernel SCM saga..
In-Reply-To: <20050409155511.7432d5c7.davem@davemloft.net>
Message-ID: <Pine.LNX.4.58.0504091611570.1267@ppc970.osdl.org>
References: <pan.2005.04.07.01.40.20.998237@sourcefrog.net>
 <20050407014727.GA17970@havoc.gtf.org> <pan.2005.04.07.02.25.56.501269@sourcefrog.net>
 <Pine.LNX.4.62.0504061931560.10158@qynat.qvtvafvgr.pbz> <1112852302.29544.75.camel@hope>
 <Pine.LNX.4.58.0504071626290.28951@ppc970.osdl.org> <1112939769.29544.161.camel@hope>
 <Pine.LNX.4.58.0504072334310.28951@ppc970.osdl.org> <20050408083839.GC3957@opteron.random>
 <Pine.LNX.4.58.0504081647510.28951@ppc970.osdl.org> <20050409022701.GA14085@opteron.random>
 <Pine.LNX.4.58.0504082240460.28951@ppc970.osdl.org>
 <20050409155511.7432d5c7.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 9 Apr 2005, David S. Miller wrote:
> 
> I understand the arguments for compression, but I hate it for one
> simple reason: recovery is more difficult when you corrupt some
> file in your repository.

Trust me, the way git does things, you'll have so much redundancy that 
you'll have to really _work_ at losing data.

That's the good news.

The bad news is that this is obviously why it does eat a lot of disk. 
Since it saves full-file commits, you're going to have a lot of 
(compressed) full files around.

		Linus
