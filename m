Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261457AbSJ1TQP>; Mon, 28 Oct 2002 14:16:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261486AbSJ1TQP>; Mon, 28 Oct 2002 14:16:15 -0500
Received: from [195.223.140.107] ([195.223.140.107]:35968 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S261457AbSJ1TQO>;
	Mon, 28 Oct 2002 14:16:14 -0500
Date: Mon, 28 Oct 2002 20:22:14 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: chrisl@vmware.com
Cc: Christoph Rohland <cr@sap.com>, Andrew Morton <akpm@digeo.com>,
       linux-kernel@vger.kernel.org, chrisl@gnuchina.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: writepage return value check in vmscan.c
Message-ID: <20021028192214.GI13972@dualathlon.random>
References: <20021024082505.GB1471@vmware.com> <3DB7B11B.9E552CFF@digeo.com> <20021024175718.GA1398@vmware.com> <20021024183327.GS3354@dualathlon.random> <20021024191531.GD1398@vmware.com> <elabj7bt.fsf@sap.com> <20021028184420.GB1454@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021028184420.GB1454@vmware.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2002 at 10:44:20AM -0800, chrisl@vmware.com wrote:
> They are the same as shmfs to linux kernel. Why does vmware not use it
> in the first place? It is possible due to some the history reason.
> 
> BTW, I have another question. For the 8G memory machine, do we need
> to setup 16G swap space? Think about the time it take to write 16G
> data, does it still make sense that swap space is twice  as big as
> memory?

swap space doesn't need to be twice as big as ram. That's fixed long
ago.

swap+ram is the total amount of virtual memory that you can use in
vmware.

> 
> And the swap partition has limit as 2G. So we need to setup 8 swap
> partitions if we want 16G swap.

that's a silly restriction of mkswap, the kernel doesn't care, it can
handle way more than 2G (however there's an high bound at some
unpractical level, to go safe the math limit should be re-encoded in
mkswap, of course it changes for every arch because the pte layout is
different).

Andrea
