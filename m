Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264867AbTAEPle>; Sun, 5 Jan 2003 10:41:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264875AbTAEPle>; Sun, 5 Jan 2003 10:41:34 -0500
Received: from aslan.scsiguy.com ([63.229.232.106]:26632 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S264867AbTAEPld>; Sun, 5 Jan 2003 10:41:33 -0500
Date: Sun, 05 Jan 2003 08:50:06 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: Paul Rolland <rol@witbe.net>, linux-kernel@vger.kernel.org
Subject: Re: [2.5.54] Oops IDE-SCSI and failure AIC7xxx
Message-ID: <418420000.1041781806@aslan.scsiguy.com>
In-Reply-To: <012a01c2b4a9$cfe095b0$2101a8c0@witbe>
References: <012a01c2b4a9$cfe095b0$2101a8c0@witbe>
X-Mailer: Mulberry/3.0.0b10 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Out of this, two problems :
>  - AIC7xxx fails to use DMA, with :
> aic7xxx: PCI Device 0:8:0 failed memory mapped test.  Using PIO.
> scsi0: PCI error Interrupt at seqaddr = 0x3
> scsi0: Signaled a Target Abort

This is because your system is violating the PCI spec.  There is
now an explicit test for this during driver initialization so that
the driver doesn't unexpectedly fail later.  I can change the driver
so that it doesn't print out the diagnostic if it would make you
feel better. 8-)

Just out of curiosity, what MB/Chipset are you using?

--
Justin

