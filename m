Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132865AbRDIWfJ>; Mon, 9 Apr 2001 18:35:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132868AbRDIWe7>; Mon, 9 Apr 2001 18:34:59 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:15890 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132865AbRDIWeo>; Mon, 9 Apr 2001 18:34:44 -0400
Subject: Re: No 100 HZ timer !
To: mikulas@artax.karlin.mff.cuni.cz (Mikulas Patocka)
Date: Mon, 9 Apr 2001 23:35:44 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), mbs@mc.com (Mark Salisbury),
        jdike@karaya.com (Jeff Dike), schwidefsky@de.ibm.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.3.96.1010410002852.4212A-100000@artax.karlin.mff.cuni.cz> from "Mikulas Patocka" at Apr 10, 2001 12:31:08 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14mkGA-000341-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Its worth doing even on the ancient x86 boards with the PIT.
> 
> Note that programming the PIT is sloooooooow and doing it on every timer
> add_timer/del_timer would be a pain.

You only have to do it occasionally.

When you add a timer newer than the current one 
	(arguably newer by at least 1/2*HZ sec)
When you finish running the timers at an interval and the new interval is
significantly larger than the current one.

Remember each tick we poke the PIT anyway

