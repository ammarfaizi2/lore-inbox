Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261546AbVDEDNB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261546AbVDEDNB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 23:13:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261547AbVDEDNB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 23:13:01 -0400
Received: from fire.osdl.org ([65.172.181.4]:29163 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261546AbVDEDM6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 23:12:58 -0400
Date: Mon, 4 Apr 2005 19:12:46 -0700
From: Andrew Morton <akpm@osdl.org>
To: Claudio Martins <ctpm@rnl.ist.utl.pt>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Processes stuck on D state on Dual Opteron
Message-Id: <20050404191246.24b11158.akpm@osdl.org>
In-Reply-To: <200504050316.20644.ctpm@rnl.ist.utl.pt>
References: <200504050316.20644.ctpm@rnl.ist.utl.pt>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Claudio Martins <ctpm@rnl.ist.utl.pt> wrote:
>
>    While stress testing 2.6.12-rc2 on an HP DL145 I get processes stuck in D 
>  state after some time.  
>    This machine is a dual Opteron 248 with 2GB (ECC) on one node (the other 
>  node has no RAM modules plugged in, since this board works only with pairs).
> 
>    I was using stress (http://weather.ou.edu/~apw/projects/stress/) with the 
>  following command line:
> 
>  stress -v -c 20 -i 12 -m 10 -d 20
> 
>    This causes a constant load avg. of around 70, makes the machine go into 
>  swap a little, and writes up to about 20GB of random data to disk while 
>  eating up all CPU. After about half and hour random processes like top, df, 
>  etc get stuck in D state. Half of the 60 or so stress processes are also in D 
>  state. The machine keeps being responsive for maybe some 15 minutes but then 
>  the shells just hang and sshd stops responding to connections, though the 
>  machine replies to pings (I don't have console acess till tomorrow).
> 
>    The system is using ext3 with md software Raid1.
> 
>   I'm interested in knowing if anyone out there with dual Opterons can 
>  reproduce this or not. I also have access to an HP DL360 Dual Xeon, so I will 
>  try to find out if this is AMD64 specific as soon as possible. Please let me 
>  know if you want me to run some other tests or give some more info to help 
>  solve this one.

Can you capture the output from alt-sysrq-T?
