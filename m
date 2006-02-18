Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932114AbWBRUJb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932114AbWBRUJb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 15:09:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932136AbWBRUJb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 15:09:31 -0500
Received: from stinky.trash.net ([213.144.137.162]:18431 "EHLO
	stinky.trash.net") by vger.kernel.org with ESMTP id S932114AbWBRUJa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 15:09:30 -0500
Message-ID: <43F77E93.9080305@trash.net>
Date: Sat, 18 Feb 2006 21:07:47 +0100
From: Patrick McHardy <kaber@trash.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?T=F6r=F6k_Edwin?= <edwin@gurde.com>
CC: netfilter-devel@lists.netfilter.org, fireflier-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, martinmaurer@gmx.at
Subject: Re: [PATCH 2.6.15.4 1/1][RFC] ipt_owner: inode match supporting both
 incoming and outgoing packets
References: <200602181420.02791.edwin@gurde.com> <43F77571.7020100@trash.net> <200602182203.41823.edwin@gurde.com>
In-Reply-To: <200602182203.41823.edwin@gurde.com>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Török Edwin wrote:
> On Saturday 18 February 2006 21:28, Patrick McHardy wrote:
> 
>>Besides the tasklist_lock issues, there is no 1:1 relationship between
>>sockets and processes, which is why this can never work. You don't know
>>which process is going to receive a packet until it calls recvmsg().
> 
> Can sockets be "labeled". Like creating a label for each process, and then 
> apply a label to each socket they open. If a socket gets shared, then it gets 
> multiple labels.
> I see that you talk about SELinux labels below, but is there a way to "label" 
> anything without using SELinux? (Maybe by writing another LSM module that 
> does just this socket labeling?)
> I could then just check the labels to see if a packet is allowed to pass/ or 
> not.

I'm not familiar with SElinux, so I don't know.

>>There is some work in progress to solve this problem in a different way,
>>by adding new hooks to the protocols that get the socket as context,
>>and using SElinux labels instead of process names/inodes/whatever for
>>matching.
> 
> Could you tell me on which thread/mailing list this discussion/(work in 
> progress) is taking place? I'd like to follow it.

There has been some discussion on netdev and netfilter-devel. I'm
currently porting the patches to a current tree and fixing the
remaining problems, I'll probably post them to netdev in a week or
two.

