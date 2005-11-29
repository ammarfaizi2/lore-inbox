Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751394AbVK2QLJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751394AbVK2QLJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 11:11:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751396AbVK2QLJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 11:11:09 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.152]:1472 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1751394AbVK2QLI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 11:11:08 -0500
In-Reply-To: <20051129075047.GA26460@hansmi.ch>
References: <111520052143.16540.437A5680000BE8A60000409C220076369200009A9B9CD3040A029D0A05@comcast.net> <70210ED5-37CA-40BC-8293-FF1DAA3E8BD5@comcast.net> <20051129000615.GA20843@hansmi.ch> <68465DDA-053F-4A85-9204-549E830B2269@comcast.net> <20051129075047.GA26460@hansmi.ch>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <2100B419-3498-4BAF-8186-3EC06A917DF6@comcast.net>
Cc: debian-powerpc@lists.debian.org,
       linux-kernel <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org
Content-Transfer-Encoding: 7bit
From: Parag Warudkar <kernel-stuff@comcast.net>
Subject: Re: PowerBook5,8 - TrackPad update
Date: Tue, 29 Nov 2005 11:11:03 -0500
To: Michael Hanselmann <linux-kernel@hansmi.ch>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Nov 29, 2005, at 2:50 AM, Michael Hanselmann wrote:
> The mouse moves, but slowly. Maybe something isn't correct yet, but it
> works basically.

Yeah, mine works like that too - but sometimes it will go left->right  
when you moved the finger
right->left and vice versa.

> I get 256 bytes in each transfer as well, but didn't look at the bytes
> behind 40. Maybe that'll help to make it more responsive.

Nope, if yours works with 80 bytes, it only sends 80. It will still  
work with anything > 80 but that's superfluous data.
(E,g, Mine works even with 1024 - anything above 256 seems junk, but  
with < 256 it dies with EOVERFLOW )

Right now I have detected that byte # 13 increases when moving finger  
along the bottom from left corner to right,
and byte #11 changes when moved from bottom left corner to top left.  
Gotta figure out the rest of the movement patterns
along with how many total sensors X and Y are there and how to relate  
the data to something to report to the input device!

Hopefully Johannes will have a PowerBook with either of the 0x0214 or  
0x0215 touchpads
and we will make some headway!

Parag


