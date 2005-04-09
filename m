Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261260AbVDICc6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261260AbVDICc6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 22:32:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261261AbVDICc6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 22:32:58 -0400
Received: from warden2-p.diginsite.com ([209.195.52.120]:14768 "HELO
	warden2.diginsite.com") by vger.kernel.org with SMTP
	id S261260AbVDICc4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 22:32:56 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Martin Pool <mbp@sourcefrog.net>,
       linux-kernel@vger.kernel.org
Date: Fri, 8 Apr 2005 19:32:02 -0700 (PDT)
X-X-Sender: dlang@dlang.diginsite.com
Subject: Re: Kernel SCM saga..
In-Reply-To: <20050409022701.GA14085@opteron.random>
Message-ID: <Pine.LNX.4.62.0504081931060.12437@qynat.qvtvafvgr.pbz>
References: <pan.2005.04.07.01.40.20.998237@sourcefrog.net>
 <20050407014727.GA17970@havoc.gtf.org> <pan.2005.04.07.02.25.56.501269@sourcefrog.net>
 <Pine.LNX.4.62.0504061931560.10158@qynat.qvtvafvgr.pbz> <1112852302.29544.75.camel@hope>
 <Pine.LNX.4.58.0504071626290.28951@ppc970.osdl.org> <1112939769.29544.161.camel@hope>
 <Pine.LNX.4.58.0504072334310.28951@ppc970.osdl.org> <20050408083839.GC3957@opteron.random>
 <Pine.LNX.4.58.0504081647510.28951@ppc970.osdl.org> <20050409022701.GA14085@opteron.random>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Apr 2005, Andrea Arcangeli wrote:

> On Fri, Apr 08, 2005 at 05:12:49PM -0700, Linus Torvalds wrote:
>> really designed for something like a offline http grabber, in that you can
>> just grab files purely by filename (and verify that you got them right by
>> running sha1sum on the resulting local copy). So think "wget".
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

note that many webservers will compress the data for you on the fly as 
well, so there's even less need to have it pre-compressed

David Lang

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare
