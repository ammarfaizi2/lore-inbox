Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132836AbRDIULV>; Mon, 9 Apr 2001 16:11:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132837AbRDIULM>; Mon, 9 Apr 2001 16:11:12 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:36625 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132836AbRDIUK5>; Mon, 9 Apr 2001 16:10:57 -0400
Subject: Re: No 100 HZ timer !
To: mbs@mc.com (Mark Salisbury)
Date: Mon, 9 Apr 2001 21:12:16 +0100 (BST)
Cc: jdike@karaya.com (Jeff Dike), schwidefsky@de.ibm.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <01040914220214.01893@pc-eng24.mc.com> from "Mark Salisbury" at Apr 09, 2001 02:19:28 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14mi1M-0002pU-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> this is one of linux biggest weaknesses.  the fixed interval timer is a
> throwback.  it should be replaced with a variable interval timer with interrupts
> on demand for any system with a cpu sane/modern enough to have an on-chip
> interrupting decrementer.  (i.e just about any modern chip)

Its worth doing even on the ancient x86 boards with the PIT. It does require
some driver changes since


	while(time_before(jiffies, we_explode))
		poll_things();

no longer works

