Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161123AbVLOFcw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161123AbVLOFcw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 00:32:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161126AbVLOFcw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 00:32:52 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:49878
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1161123AbVLOFcv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 00:32:51 -0500
Date: Wed, 14 Dec 2005 21:24:37 -0800 (PST)
Message-Id: <20051214.212437.61974201.davem@davemloft.net>
To: davej@redhat.com
Cc: jesper.juhl@gmail.com, bunk@stusta.de, akpm@osdl.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] offer CC_OPTIMIZE_FOR_SIZE only if EXPERIMENTAL
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20051215004006.GA19354@redhat.com>
References: <9a8748490512141418w2a3811a9iffe83b5f285e2910@mail.gmail.com>
	<9a8748490512141428q29f39ca5x66d2c52e22aa9208@mail.gmail.com>
	<20051215004006.GA19354@redhat.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Jones <davej@redhat.com>
Date: Wed, 14 Dec 2005 19:40:06 -0500

> [1] In that particular case, it was broken asm-x86-64/ macros that 
>     just happened to work at -O2 by chance, so it actually found latent bugs.

I'm hoping it's something similar on sparc64.

I have the problem narrowed down to compiling kernel/sched.o with
"-Os" on sparc64.  Let's see if I can zero in on the exact problem
quickly...
