Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266086AbUALJIj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 04:08:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266089AbUALJIf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 04:08:35 -0500
Received: from smtp09.auna.com ([62.81.186.19]:33174 "EHLO smtp09.retemail.es")
	by vger.kernel.org with ESMTP id S266086AbUALJId (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 04:08:33 -0500
Date: Mon, 12 Jan 2004 10:08:31 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: /proc/kcore size
Message-ID: <20040112090831.GC2588@werewolf.able.es>
References: <20040112090404.GA2588@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20040112090404.GA2588@werewolf.able.es> (from jamagallon@able.es on Mon, Jan 12, 2004 at 10:04:04 +0100)
X-Mailer: Balsa 2.0.15
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 01.12, J.A. Magallon wrote:
> Hi all...
> 
> To the request of one of my users, I installed the 'hinv' program (1.4pre1) by
> Larry McVoy.
> 
> Problem: it detects the memory amount in the box by stat'ing /proc/kcore.
> Thats not the problem, but that the box has 1Gb of memory, and kcore is just
> 896Mb big.
> 
> Kernel is built with 4Gb support:
> 
> annwn:/proc# free
>              total       used       free     shared    buffers     cached
> Mem:       1033172    1017772      15400          0     164792     556416
> -/+ buffers/cache:     296564     736608
> Swap:      1951856          8    1951848
> 
> annwn:/proc# hinv
> Main memory size: 896 Mbytes
> ...
> 
> annwn:/proc# ll /proc/kcore
> -r--------    1 root     root     939528192 Jan 12 10:02 /proc/kcore
> 
> Exactly the same as a box that has _really_ 896 Mb:
> 
> werewolf:/proc# ll kcore
> -r--------    1 root     root     939528192 Jan 12 10:02 kcore
> 
> werewolf:/proc# free
>              total       used       free     shared    buffers     cached
> Mem:        905012     276008     629004          0      27268     109344
> -/+ buffers/cache:     139396     765616
> Swap:       345356          0     345356
> 
> BUG ?
> 

Ooops, sorry. annwn is a (patched)2.4.24 and werewolf is 2.6.1-mm2(+hfsplusfs).

-- 
J.A. Magallon <jamagallon()able!es>     \                 Software is like sex:
werewolf!able!es                         \           It's better when it's free
Mandrake Linux release 10.0 (Cooker) for i586
Linux 2.6.1-jam2 (gcc 3.3.2 (Mandrake Linux 10.0 3.3.2-4mdk))
