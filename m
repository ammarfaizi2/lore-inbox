Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284717AbSA1KCa>; Mon, 28 Jan 2002 05:02:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285060AbSA1KCU>; Mon, 28 Jan 2002 05:02:20 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:2319 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S284717AbSA1KCN>; Mon, 28 Jan 2002 05:02:13 -0500
Subject: Re: 2.4.18-pre7 slow ... apm problem
To: jdthood@mail.com (Thomas Hood)
Date: Mon, 28 Jan 2002 10:14:59 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org,
        sfr@canb.auug.org.au (Stephen Rothwell)
In-Reply-To: <1012185478.2165.73.camel@thanatos> from "Thomas Hood" at Jan 27, 2002 09:37:40 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16V8oV-0004FV-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > managing the APM state of the processor (and leaving it in
> > powersave)
> 
> APM idling is done if apm_cpu_idle() is called, and then if
>     DELTA(current->times.tms_stime)
>     -------------------------------
>     DELTA(jiffies)
> is greater than the idle threshold of 0.95.  Could that ratio be
> affected by VMware?  If so, how?

Suppose vmware decides to switch between running Linux and its virtualised
Windows OS. Can it do this during an interrupt - if so what ensures that
vmware isnt switched to after we have done APM idle calls and slowed the
CPU right down ?

If so then I suspect vmware should be issuing APM cpu busy calls itself

