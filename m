Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130661AbRA2SC6>; Mon, 29 Jan 2001 13:02:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131049AbRA2SCj>; Mon, 29 Jan 2001 13:02:39 -0500
Received: from hs-gk.cyberbills.com ([216.35.157.254]:9737 "EHLO
	hs-mail.cyberbills.com") by vger.kernel.org with ESMTP
	id <S130661AbRA2SCd>; Mon, 29 Jan 2001 13:02:33 -0500
Date: Mon, 29 Jan 2001 10:02:26 -0800 (PST)
From: "Sergey Kubushin" <ksi@cyberbills.com>
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: "Craig I. Hagan" <hagan@cih.com>, Romain Kang <romain@kzsu.stanford.edu>,
        linux-kernel@vger.kernel.org
Subject: Re: eepro100 - Linux vs. FreeBSD
In-Reply-To: <Pine.LNX.3.95.1010129123830.562A-100000@chaos.analogic.com>
Message-ID: <Pine.LNX.4.31ksi3.0101290957530.25829-100000@nomad.cyberbills.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Jan 2001, Richard B. Johnson wrote:

> Two of my Linux machines use the Intel Ethernet controller on the
> motherboard. These are both SMP machines. I have never, ever, had
> any problems with the eepro100 driver that handles these chips.
>
> I spite of the fact that the driver loops in the ISR, and does other
> things that show poor design, it works so I have not done anything
> to it. "If it ain't broke, don't fix it..."
>
> So, if you have problems with using on-board Intel chip, it's
> unlikely that it's a driver problem. If you have cards on the PCI
> bus, the driver doesn't "know" any difference (PCI is PCI even if
> it's not in a connector). You may find that the problem is caused
> by PCI (mis)configuration since recent kernels use internal PCI
> code. You may find that some bus master device does not have its
> latency set correctly so it's taking over the bus. This can cause
> problems with any high-activity device on the bus, such as a
> network device.

The older chips (e.g. 82557) work fine. The problem arises when you have the
newer 82559's. They do work, however, if the power management for eepro100
is enabled in kernel config. It definitely means that those chips are
underinitialized (or overinitialized :)) when it's not.

---
Sergey Kubushin				Sr. Unix Administrator
CyberBills, Inc.			Phone:	702-567-8857
874 American Pacific Dr,		Fax:	702-567-8890
Henderson, NV, 89014

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
