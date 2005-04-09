Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261219AbVDIDGF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261219AbVDIDGF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 23:06:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261261AbVDIDGF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 23:06:05 -0400
Received: from quark.didntduck.org ([69.55.226.66]:16821 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP id S261219AbVDIDGC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 23:06:02 -0400
Message-ID: <4257474A.108@didntduck.org>
Date: Fri, 08 Apr 2005 23:08:58 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla Thunderbird 1.0.2-1 (X11/20050323)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Linus Torvalds <torvalds@osdl.org>, Martin Pool <mbp@sourcefrog.net>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       David Lang <dlang@digitalinsight.com>
Subject: Re: Kernel SCM saga..
References: <pan.2005.04.07.01.40.20.998237@sourcefrog.net> <20050407014727.GA17970@havoc.gtf.org> <pan.2005.04.07.02.25.56.501269@sourcefrog.net> <Pine.LNX.4.62.0504061931560.10158@qynat.qvtvafvgr.pbz> <1112852302.29544.75.camel@hope> <Pine.LNX.4.58.0504071626290.28951@ppc970.osdl.org> <1112939769.29544.161.camel@hope> <Pine.LNX.4.58.0504072334310.28951@ppc970.osdl.org> <20050408083839.GC3957@opteron.random> <Pine.LNX.4.58.0504081647510.28951@ppc970.osdl.org> <20050409022701.GA14085@opteron.random>
In-Reply-To: <20050409022701.GA14085@opteron.random>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> On Fri, Apr 08, 2005 at 05:12:49PM -0700, Linus Torvalds wrote:
> 
>>really designed for something like a offline http grabber, in that you can 
>>just grab files purely by filename (and verify that you got them right by 
>>running sha1sum on the resulting local copy). So think "wget".
> 
> 
> I'm not entirely convinced wget is going to be an efficient way to
> synchronize and fetch your tree, its simplicitly is great though. It's a
> tradeoff between optimzing and re-using existing tools (like webservers).
> Perhaps that's why you were compressing the stuff too? It sounds better
> not to compress the stuff on-disk, and to synchronize with a rsync-like
> protocol (rsync server would make it) that handles the compression in
> the network protocol itself, and in turn that can apply compression to a
> large blob (i.e. the diff between the trees), and not to the single tiny
> files.

It's my understanding that the files don't change.  Only new ones are 
created for each revision.

--
				Brian gErst	
