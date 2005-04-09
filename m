Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261261AbVDIDPS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261261AbVDIDPS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 23:15:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261262AbVDIDPS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 23:15:18 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:59658
	"EHLO opteron.random") by vger.kernel.org with ESMTP
	id S261261AbVDIDPO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 23:15:14 -0400
Date: Sat, 9 Apr 2005 05:15:21 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Brian Gerst <bgerst@didntduck.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Martin Pool <mbp@sourcefrog.net>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       David Lang <dlang@digitalinsight.com>
Subject: Re: Kernel SCM saga..
Message-ID: <20050409031521.GC14085@opteron.random>
References: <pan.2005.04.07.02.25.56.501269@sourcefrog.net> <Pine.LNX.4.62.0504061931560.10158@qynat.qvtvafvgr.pbz> <1112852302.29544.75.camel@hope> <Pine.LNX.4.58.0504071626290.28951@ppc970.osdl.org> <1112939769.29544.161.camel@hope> <Pine.LNX.4.58.0504072334310.28951@ppc970.osdl.org> <20050408083839.GC3957@opteron.random> <Pine.LNX.4.58.0504081647510.28951@ppc970.osdl.org> <20050409022701.GA14085@opteron.random> <4257474A.108@didntduck.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4257474A.108@didntduck.org>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 08, 2005 at 11:08:58PM -0400, Brian Gerst wrote:
> It's my understanding that the files don't change.  Only new ones are 
> created for each revision.

I said diff between the trees, not diff between files ;). When you fetch
the new changes with rsync, it'll compress better and in turn it'll be
faster (assuming we're network bound and I am with 1mbit and 2.5ghz
cpu), if it's rsync applying gzip to the big "combined diff between
trees" instead of us compressing every single small file on disk, that
won't compress anymore inside rsync.
