Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264262AbTKKFoT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 00:44:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264266AbTKKFoT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 00:44:19 -0500
Received: from fw.osdl.org ([65.172.181.6]:53213 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264262AbTKKFoS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 00:44:18 -0500
Date: Mon, 10 Nov 2003 21:44:15 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Paul Venezia <pvenezia@jpj.net>
cc: Andrew Morton <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: Re: I/O issues, iowait problems, 2.4 v 2.6
In-Reply-To: <1068526547.22800.131.camel@soul.jpj.net>
Message-ID: <Pine.LNX.4.44.0311102141370.2881-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 10 Nov 2003, Paul Venezia wrote:
> 
> I rebooted and shot these, starting 5 seconds before the cat:
> 
>  0  0      0 1474524   7084  42420    0    0     0     0 1033    47  0  0 100  0
>  0  0      0 1474524   7084  42420    0    0     0     0 1031    38  0  0 100  0
>  0  0      0 1474524   7084  42420    0    0     0     0 1016    12  0  0 100  0
>  1  0      0 1373716   7184 140376    0    0     0     0 1020    14  0 10 90  0
>  1  2      0 1166548   7392 341652    0    0     8 18836 1028    56  0 21 43 36
>  1  2      0 994132   7556 509312    0    0     4  1696 1030    63  0 17 27 56
>  1  2      0 867732   7684 632264    0    0     4  2400 1033    65  0 12 27 60
>  0  3      0 817748   7732 680700    0    0     4  9632 1033    66  0  5 27 67

Ok, looks saner in the sense that now you seem to get no interrupts at all 
from your card. At least that matches the fact that you basically get no 
throughput either ;)

So the previous vmstat was when there was a lot of network activity with
some associated server going on too?

So this same setup worked find for you with bonnie++ with a single disk?

		Linus

