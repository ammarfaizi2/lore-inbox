Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264618AbSIQVWQ>; Tue, 17 Sep 2002 17:22:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264619AbSIQVWQ>; Tue, 17 Sep 2002 17:22:16 -0400
Received: from pizda.ninka.net ([216.101.162.242]:28803 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S264618AbSIQVWP>;
	Tue, 17 Sep 2002 17:22:15 -0400
Date: Tue, 17 Sep 2002 14:18:06 -0700 (PDT)
Message-Id: <20020917.141806.49377410.davem@redhat.com>
To: alan@lxorguk.ukuu.org.uk
Cc: ak@suse.de, linux-kernel@vger.kernel.org, johnstul@us.ibm.com,
       anton.wilson@camotion.com
Subject: Re: do_gettimeofday vs. rdtsc in the scheduler
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <1032298092.20498.21.camel@irongate.swansea.linux.org.uk>
References: <p73vg54tjpl.fsf@oldwotan.suse.de>
	<20020917.135451.49037528.davem@redhat.com>
	<1032298092.20498.21.camel@irongate.swansea.linux.org.uk>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Alan Cox <alan@lxorguk.ukuu.org.uk>
   Date: 17 Sep 2002 22:28:12 +0100

   A bus clock - but things like the x440 have more than one bus clock. Its
   NUMA. Also the bus clock and rdtsc clock are different - rdtsc is
   dependant on the multiplier. Shove a celeron 300 and a celeron 450 in a
   BP6 board with tsc on and enjoy
   
That's mostly my point.

If the bus clocks differ, then great create some system wide crystal
oscillator.  That's a detail, the important bit is that you don't need
to go out to the system bus to read the tick value, it must be cpu
local to be effective and without serious performance impact.
