Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289096AbSA1CiT>; Sun, 27 Jan 2002 21:38:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289097AbSA1Ch7>; Sun, 27 Jan 2002 21:37:59 -0500
Received: from sushi.toad.net ([162.33.130.105]:51074 "EHLO sushi.toad.net")
	by vger.kernel.org with ESMTP id <S289096AbSA1Chz>;
	Sun, 27 Jan 2002 21:37:55 -0500
Subject: Re: 2.4.18-pre7 slow ... apm problem
From: Thomas Hood <jdthood@mail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <E16Uzie-0003Ba-00@the-village.bc.nu>
In-Reply-To: <E16Uzie-0003Ba-00@the-village.bc.nu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 27 Jan 2002 21:37:40 -0500
Message-Id: <1012185478.2165.73.camel@thanatos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The keyboard rate one is curious. The vmware one I can easily
> believe is caused by Vmware switching in/out of OS's without
> managing the APM state of the processor (and leaving it in
> powersave)

APM idling is done if apm_cpu_idle() is called, and then if
    DELTA(current->times.tms_stime)
    -------------------------------
    DELTA(jiffies)
is greater than the idle threshold of 0.95.  Could that ratio be
affected by VMware?  If so, how?

--
Thomas


