Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261925AbTENLwl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 07:52:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261927AbTENLwl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 07:52:41 -0400
Received: from nmail1.systems.pipex.net ([62.241.160.130]:39652 "EHLO
	nmail1.systems.pipex.net") by vger.kernel.org with ESMTP
	id S261925AbTENLwk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 07:52:40 -0400
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Subject: RE: 2.6 must-fix list, v2
Message-ID: <1052913905.3ec230f1b8337@netmail.pipex.net>
Date: Wed, 14 May 2003 13:05:05 +0100
From: "Shaheed R. Haque" <srhaque@iee.org>
Cc: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>,
       "'Andrew Morton'" <akpm@digeo.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
References: <A46BBDB345A7D5118EC90002A5072C780CCB07F4@orsmsx116.jf.intel.com> <Pine.LNX.4.50.0305132238550.14103-100000@montezuma.mastecende.com>
In-Reply-To: <Pine.LNX.4.50.0305132238550.14103-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: PIPEX NetMail 2.2.0-pre13
X-PIPEX-username: aozw65%dsl.pipex.com
X-Originating-IP: 195.166.116.245
X-Usage: Use of PIPEX NetMail is subject to the PIPEX Terms and Conditions of use
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Quoting Zwane Mwaikambo <zwane@linuxpower.ca>:

> Not really, during load your reserved cpu will now have to wait longer 
> for shared resources instead of helping make progress, bringing down the
> performance of all your applications including the 'realtime' one.

Of course you are right in the general case. But as long as one has correctly 
sized the load so that it does NOT exceed the dedicated CPUs, and one has 
reserved the right resources, then it can help the stability of the soft-
realtime applications that are of interest to me.

So, in my case, using dedicated raw-ish disks, pinned memory, dedicated CPUs 
and the understanding that the kernel has absolute priority over userspace (and 
so is never a worse bottleneck than usual), it all works. Also, my application 
maximises the probability of success by explictly managing the resources which 
*are* shared between the time-sensitive code and the relevant "joe-random" code.

Can I be certain that there is no shared lock or anything else in the whole 
kernel? No, but I'm prepared to make that probabalistic tradeoff (backed via 
extensive testing) rather than have to go to hard-realtime.

Thanks, Shaheed


