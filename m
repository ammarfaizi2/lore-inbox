Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268428AbTBNOoQ>; Fri, 14 Feb 2003 09:44:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268430AbTBNOoQ>; Fri, 14 Feb 2003 09:44:16 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:32519 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S268428AbTBNOoP>; Fri, 14 Feb 2003 09:44:15 -0500
Date: Fri, 14 Feb 2003 17:53:32 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Zwane Mwaikambo <zwane@holomorphy.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Richard T Henderson <rth@twiddle.net>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH][2.5] Protect smp_call_function_data w/ spinlocks on Alpha
Message-ID: <20030214175332.A19234@jurassic.park.msu.ru>
References: <Pine.LNX.4.50.0302140634000.3518-100000@montezuma.mastecende.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.50.0302140634000.3518-100000@montezuma.mastecende.com>; from zwane@holomorphy.com on Fri, Feb 14, 2003 at 06:51:54AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2003 at 06:51:54AM -0500, Zwane Mwaikambo wrote:
> 	This is an untested patch to remove the custom mutex, however it 
> doesn't maintain the same semantics wrt 'retry' and unconditionally 
> blocks on contention.

Why do you want to remove it? The critical data here is a single pointer
which can be effectively protected without spinlock.

Ivan.
