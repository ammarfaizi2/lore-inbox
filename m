Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932127AbWBRUEI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932127AbWBRUEI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 15:04:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932135AbWBRUEI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 15:04:08 -0500
Received: from 216.255.188.82-custblock.intercage.com ([216.255.188.82]:51637
	"EHLO main.astronetworks.net") by vger.kernel.org with ESMTP
	id S932127AbWBRUEH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 15:04:07 -0500
From: =?iso-8859-1?q?T=F6r=F6k_Edwin?= <edwin@gurde.com>
To: Patrick McHardy <kaber@trash.net>
Subject: Re: [PATCH 2.6.15.4 1/1][RFC] ipt_owner: inode match supporting both incoming and outgoing packets
Date: Sat, 18 Feb 2006 22:03:41 +0200
User-Agent: KMail/1.9.1
Cc: netfilter-devel@lists.netfilter.org, fireflier-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, martinmaurer@gmx.at
References: <200602181420.02791.edwin@gurde.com> <43F77571.7020100@trash.net>
In-Reply-To: <43F77571.7020100@trash.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200602182203.41823.edwin@gurde.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - main.astronetworks.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - gurde.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 18 February 2006 21:28, Patrick McHardy wrote:
> Török Edwin wrote:
> > First of all this is what I'd like to achieve:
> > - filter packets by the program who sent the packet
> > - filter packets by the program who is going to receive the packet
> > - when multiple programs share a socket (i.e. they listen on the same
> > socket), allow the packet only if all programs are allowed to receive the
> > packet
>
> Besides the tasklist_lock issues, there is no 1:1 relationship between
> sockets and processes, which is why this can never work. You don't know
> which process is going to receive a packet until it calls recvmsg().
Can sockets be "labeled". Like creating a label for each process, and then 
apply a label to each socket they open. If a socket gets shared, then it gets 
multiple labels.
I see that you talk about SELinux labels below, but is there a way to "label" 
anything without using SELinux? (Maybe by writing another LSM module that 
does just this socket labeling?)
I could then just check the labels to see if a packet is allowed to pass/ or 
not.
>
> There is some work in progress to solve this problem in a different way,
> by adding new hooks to the protocols that get the socket as context,
> and using SElinux labels instead of process names/inodes/whatever for
> matching.
Could you tell me on which thread/mailing list this discussion/(work in 
progress) is taking place? I'd like to follow it.

Thanks
Edwin
