Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263128AbUCPAat (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 19:30:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263021AbUCPASi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 19:18:38 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:8205 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S262991AbUCPAKI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 19:10:08 -0500
Date: Tue, 16 Mar 2004 02:00:36 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Marc Giger <gigerstyle@gmx.ch>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.4 on Alpha uninterruptible sleep of processes
Message-ID: <20040316020035.A4123@jurassic.park.msu.ru>
References: <20040312184115.B680@jurassic.park.msu.ru> <20040312165907.626d4a08@hdg.gigerstyle.ch> <20040312224649.A750@den.park.msu.ru> <20040312215215.1041889a@hdg.gigerstyle.ch> <20040313020141.B4021@den.park.msu.ru> <20040313111021.4af73b9e@hdg.gigerstyle.ch> <20040314170627.A11159@den.park.msu.ru> <20040314195203.78abbef9@vaio.gigerstyle.ch> <20040315145145.A31703@jurassic.park.msu.ru> <20040315190249.19263f4f@vaio.gigerstyle.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040315190249.19263f4f@vaio.gigerstyle.ch>; from gigerstyle@gmx.ch on Mon, Mar 15, 2004 at 07:02:49PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2004 at 07:02:49PM +0100, Marc Giger wrote:
> How long did you let your machine run?

$ uptime
 01:40:40 up 3 days,  6:31,  4 users,  load average: 25.23, 24.16, 23.73

It's with unpatched 2.6.4. Before that the machine was running 2.6.1-rc1
for 2 months.

> In my case, it has to run the whole night until it happens.

Perhaps there is a memory leak somewhere, and your systems just
starts swapping.

> I don't know if it helps but I think the
> first processes that are in uninterruptible sleep are apache and mysql.
> Also, as you can see in my first e-mail (ps -aux output), the pdflush
> and kswapd0 are in in uninterruptible sleep state.

Well, I can see something like that when I compile kernel with "make -j 15".
The system starts swapping like crazy, most processes are in the D-state
waiting for disk, but all goes back to normal after compilation is finished.
What's wrong with it? :-)

Ivan.
