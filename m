Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287874AbSA1NGN>; Mon, 28 Jan 2002 08:06:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288173AbSA1NGE>; Mon, 28 Jan 2002 08:06:04 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:26884 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S287874AbSA1NF6>; Mon, 28 Jan 2002 08:05:58 -0500
Subject: Re: 2.4.18-pre7 slow ... apm problem
To: jdthood@mail.com (Thomas Hood)
Date: Mon, 28 Jan 2002 13:18:41 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org,
        sfr@canb.auug.org.au (Stephen Rothwell)
In-Reply-To: <1012217107.746.5.camel@thanatos> from "Thomas Hood" at Jan 28, 2002 06:25:05 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16VBgH-0000Z4-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > If so then I suspect vmware should be issuing APM cpu busy calls itself
> 
> Do you see a difference between VMware and other processes
> in their susceptibility to this problem?  If VMware runs
> slowly because it gets scheduled in while the CPU is idle
> and the apm driver fails to busyize the CPU, won't the same
> thing happen for other processes?  If so, then our idle 
> handling is fundamentally broken.  If not, then what makes
> VMware special?

We don't know how VMware switches between virtual machines. If that
switch is done behind Linux back, then VMware is effectively special. It
is virtualising the system and it has to virtualise APM status too. If its
doing the switch when it is a current foreground process then it wouldnt
explain the problem
