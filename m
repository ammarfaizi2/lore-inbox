Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932512AbWGHFZc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932512AbWGHFZc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 01:25:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751298AbWGHFZc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 01:25:32 -0400
Received: from smtp.osdl.org ([65.172.181.4]:50572 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751297AbWGHFZb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 01:25:31 -0400
Date: Fri, 7 Jul 2006 22:25:10 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Albert Cahalan <acahalan@gmail.com>
cc: linux-kernel@vger.kernel.org, linux-os@analogic.com, khc@pm.waw.pl,
       mingo@elte.hu, akpm@osdl.org, arjan@infradead.org
Subject: Re: [patch] spinlocks: remove 'volatile'
In-Reply-To: <787b0d920607072054i237eebf5g8109a100623a1070@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0607072222540.3869@g5.osdl.org>
References: <787b0d920607072054i237eebf5g8109a100623a1070@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 7 Jul 2006, Albert Cahalan wrote:
> 
> Key thing being "language environment", meaning gcc.

No.

The key thing is "language environment", meaning THE HARDWARE.

> By the language spec, volatile is a low-performance way to
> get the job done.

No.

"volatile" simply CANNOT get the job done. It fundamentally does _nothing_ 
for all the issues that are fundamental today: CPU memory ordering in SMP, 
special IO synchronization requirements for memory-mapped IO registers etc 
etc.

It's not that "volatile" is the "portable way". It's that "volatile" is 
fundamentally not sufficient for the job.

		Linus
