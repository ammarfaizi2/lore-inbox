Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266852AbTBQGHd>; Mon, 17 Feb 2003 01:07:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266859AbTBQGHd>; Mon, 17 Feb 2003 01:07:33 -0500
Received: from franka.aracnet.com ([216.99.193.44]:45256 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S266852AbTBQGHd>; Mon, 17 Feb 2003 01:07:33 -0500
Date: Sun, 16 Feb 2003 22:17:14 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Manfred Spraul <manfred@colorfullife.com>,
       Anton Blanchard <anton@samba.org>, Andrew Morton <akpm@digeo.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Zwane Mwaikambo <zwane@holomorphy.com>
Subject: Re: more signal locking bugs?
Message-ID: <77820000.1045462633@[10.10.2.4]>
In-Reply-To: <Pine.LNX.4.44.0302161951580.1424-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0302161951580.1424-100000@home.transmeta.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Ah, I see what happened, I think .... the locking used to be inside
>> collect_sigign_sigcatch, and you moved it out into task_sig ... but 
>> there were two callers of collect_sigign_sigcatch, the other one being
>> proc_pid_stat
> 
> Doh.
> 
> This should fix it. 

Oooh, not only does SDET work now in 61, it doesn't freeze the whole box
when I hit ^C any more (like it's been doing since the dawn of time).
Spiffy ;-)


M.

