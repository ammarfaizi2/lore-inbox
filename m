Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131368AbRAXVK2>; Wed, 24 Jan 2001 16:10:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132131AbRAXVKT>; Wed, 24 Jan 2001 16:10:19 -0500
Received: from chaos.analogic.com ([204.178.40.224]:4992 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S131368AbRAXVJl>; Wed, 24 Jan 2001 16:09:41 -0500
Date: Wed, 24 Jan 2001 16:09:14 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: "Isabelle, Francois" <Isabellf@Teknor.com>
cc: "Linux-Kernel@Vger. Kernel. Org. (E-mail)" 
	<linux-kernel@vger.kernel.org>,
        "'Per Hedeland' (E-mail)" <Per@bluetail.com>
Subject: Re: Silly Question
In-Reply-To: <5009AD9521A8D41198EE00805F85F18F683FCC@SEMBO111>
Message-ID: <Pine.LNX.3.95.1010124160200.865A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Jan 2001, Isabelle, Francois wrote:

> There is something I try to do using Linux and I think you may have a clue:
> 
> I want to use the external loopback of my ethernet interface to test it. I
> want the data to actually go through the cable and I don't want internal
> logic to bypass this process.
> There is only one interface available, so I can't use swapped routing as
> explained here:
[SNIPPED...]

If you set a SNIC (Serial Network Interface Chip) to loop-back, the
signal doesn't come in or go out the cable! In fact, initialization
procedures often require that the SNIC be put into loop-back so that
nothing is being received during the initialization process.

You just need another card for the single-machine loop-back testing
that you describe. FYI, you can get an idea of the underlying network
code speed by using the echo and sink port over lo. This uses all
the IP layers, but bypasses the Ethernet hardware.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.0 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
