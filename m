Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263367AbUCNOHa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Mar 2004 09:07:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263368AbUCNOHa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Mar 2004 09:07:30 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:49158 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S263367AbUCNOG3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Mar 2004 09:06:29 -0500
Date: Sun, 14 Mar 2004 17:06:27 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Marc Giger <gigerstyle@gmx.ch>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.4 on Alpha uninterruptible sleep of processes
Message-ID: <20040314170627.A11159@den.park.msu.ru>
References: <20040312154613.7567adab@hdg.gigerstyle.ch> <20040312182754.A680@jurassic.park.msu.ru> <20040312184115.B680@jurassic.park.msu.ru> <20040312165907.626d4a08@hdg.gigerstyle.ch> <20040312224649.A750@den.park.msu.ru> <20040312215215.1041889a@hdg.gigerstyle.ch> <20040313020141.B4021@den.park.msu.ru> <20040313111021.4af73b9e@hdg.gigerstyle.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040313111021.4af73b9e@hdg.gigerstyle.ch>; from gigerstyle@gmx.ch on Sat, Mar 13, 2004 at 11:10:21AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 13, 2004 at 11:10:21AM +0100, Marc Giger wrote:
> Hmm, I couldn't boot the kernel with enabled "semaphore debugging". It
> hangs directly after aboot. No messages, nothing. Do I something wrong?

No. Indeed, "semaphore debugging" is completely useless since printk()
itself is trying to acquire the console_sem, which in turn causes
another debugging printk() and so on.
I think this option should be removed...

> Now I've booted 2.6.4 without debugging.

And does the last patch makes things better?

Ivan.
