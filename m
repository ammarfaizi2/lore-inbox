Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264690AbTAFUvx>; Mon, 6 Jan 2003 15:51:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267133AbTAFUvx>; Mon, 6 Jan 2003 15:51:53 -0500
Received: from ool-4351594a.dyn.optonline.net ([67.81.89.74]:43531 "EHLO
	buggy.badula.org") by vger.kernel.org with ESMTP id <S264690AbTAFUvw>;
	Mon, 6 Jan 2003 15:51:52 -0500
Date: Mon, 6 Jan 2003 16:00:06 -0500
Message-Id: <200301062100.h06L06V03070@buggy.badula.org>
From: Ion Badulescu <ionut@cs.columbia.edu>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: Paul Rolland <rol@witbe.net>, linux-kernel@vger.kernel.org
Subject: Re: [2.5.54] Oops IDE-SCSI and failure AIC7xxx
In-Reply-To: <418420000.1041781806@aslan.scsiguy.com>
User-Agent: tin/1.5.12-20020427 ("Sugar") (UNIX) (Linux/2.4.20 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 05 Jan 2003 08:50:06 -0700, Justin T. Gibbs <gibbs@scsiguy.com> wrote:
>> Out of this, two problems :
>>  - AIC7xxx fails to use DMA, with :
>> aic7xxx: PCI Device 0:8:0 failed memory mapped test.  Using PIO.
>> scsi0: PCI error Interrupt at seqaddr = 0x3
>> scsi0: Signaled a Target Abort
> 
> This is because your system is violating the PCI spec.  There is
> now an explicit test for this during driver initialization so that
> the driver doesn't unexpectedly fail later.  I can change the driver
> so that it doesn't print out the diagnostic if it would make you
> feel better. 8-)

The problem with the message is that it makes people think PIO vs DMA
(which matters a lot for e.g. IDE), not PIO vs MMIO which is what it
really is, and doesn't matter nearly as much.

Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.
