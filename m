Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267369AbUG2AxP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267369AbUG2AxP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 20:53:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267381AbUG2AxP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 20:53:15 -0400
Received: from mail.tpgi.com.au ([203.12.160.61]:27855 "EHLO mail.tpgi.com.au")
	by vger.kernel.org with ESMTP id S267369AbUG2AxJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 20:53:09 -0400
Subject: Re: [Patch] Per kthread freezer flags
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1091056916.1844.14.camel@teapot.felipe-alfaro.com>
References: <1090999301.8316.12.camel@laptop.cunninghams>
	 <20040728142026.79860177.akpm@osdl.org>
	 <1091053822.1844.4.camel@teapot.felipe-alfaro.com>
	 <1091054194.8867.26.camel@laptop.cunninghams>
	 <1091056916.1844.14.camel@teapot.felipe-alfaro.com>
Content-Type: text/plain
Message-Id: <1091061983.8867.95.camel@laptop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 29 Jul 2004 10:46:23 +1000
Content-Transfer-Encoding: 7bit
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Thu, 2004-07-29 at 09:21, Felipe Alfaro Solana wrote:
> kirdad? No... That sounds like Infrared which my laptop does not have.

Did to me too. I was clutching at straws. :>

> Here is a digest of ps -axf:
> 
>   PID TTY      STAT   TIME COMMAND
>     1 ?        S      0:00 init [5]
>     2 ?        S<     0:03 [irqd/0]
>     3 ?        S<     0:00 [events/0]
>     4 ?        S<     0:00  \_ [khelper]
>     5 ?        S<     0:00  \_ [kacpid]
>    22 ?        S<     0:00  \_ [kblockd/0]
>    32 ?        S      0:00  \_ [pdflush]
>    33 ?        S      0:00  \_ [pdflush]
>    35 ?        S<     0:00  \_ [aio/0]
>    36 ?        S<     0:00  \_ [xfslogd/0]
>    37 ?        S<     0:00  \_ [xfsdatad/0]
>    34 ?        S      0:00 [kswapd0]
>    38 ?        S      0:00 [xfsbufd]
>   120 ?        S      0:00 [kseriod]
>   125 ?        S      0:00 [xfssyncd]
>   273 ?        Ss     0:00 minilogd
>   286 ?        S      0:00 [xfssyncd]
>   287 ?        S      0:00 [xfssyncd]
>   567 ?        S      0:00 [khubd]
>   871 ?        S      0:00 [pccardd]
>   877 ?        S      0:00 [pccardd]

It doesn't look like I've touched any of those threads. I have doubts
about irqd/0 (is that kirqd reworked?), so you might try making setting
PF_NOFREEZE and seeing if it makes a difference. I haven't done the
switch to rc2-mm1 yet, so haven't gotten to those issues.

Nigel

