Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318592AbSGSRBY>; Fri, 19 Jul 2002 13:01:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318594AbSGSRBY>; Fri, 19 Jul 2002 13:01:24 -0400
Received: from jalon.able.es ([212.97.163.2]:14841 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S318592AbSGSRBU>;
	Fri, 19 Jul 2002 13:01:20 -0400
Date: Fri, 19 Jul 2002 19:03:46 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19rc2aa1
Message-ID: <20020719170346.GC1690@werewolf.able.es>
References: <20020717225504.GA994@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20020717225504.GA994@dualathlon.random>; from andrea@suse.de on Thu, Jul 18, 2002 at 00:55:04 +0200
X-Mailer: Balsa 1.3.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.07.18 Andrea Arcangeli wrote:
>I would appreciate any feedback on the last patches for the i_size
>atomic accesses on 32bit archs. Thanks,
>
>URL:
>
>	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.19rc2aa1.gz
>	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.19rc2aa1/
>
>diff between 2.4.19rc1aa2 and 2.4.19rc1aa2:
>
>Only in 2.4.19rc1aa2: 000_e100-2.0.30-k1.gz
>Only in 2.4.19rc2aa1: 000_e100-2.1.6.gz
>Only in 2.4.19rc1aa2: 000_e1000-4.2.17-k1.gz
>Only in 2.4.19rc2aa1: 000_e1000-4.3.2.gz
>

More on this.

We have two interfaces:
04:04.0 Ethernet controller: Intel Corp. 82557 [Ethernet Pro 100] (rev 08)
03:01.0 Ethernet controller: Intel Corp. 82543GC Gigabit Ethernet Controller (rev 02)

NetPipe (tcp) shows numbers like 80Mb/s for e100 and 500Mb/s for e1000. So
efficiency is much much higher for e100 driver+card than e1000.
I have to dig, perhaps e100 is doing zerocopy and e1000 is not ?

Any ideas ?

-- 
J.A. Magallon             \   Software is like sex: It's better when it's free
mailto:jamagallon@able.es  \                    -- Linus Torvalds, FSF T-shirt
Linux werewolf 2.4.19-rc2-jam1, Mandrake Linux 8.3 (Cooker) for i586
gcc (GCC) 3.1.1 (Mandrake Linux 8.3 3.1.1-0.8mdk)
