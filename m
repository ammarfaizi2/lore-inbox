Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131989AbRAPQca>; Tue, 16 Jan 2001 11:32:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131987AbRAPQcU>; Tue, 16 Jan 2001 11:32:20 -0500
Received: from [64.64.109.142] ([64.64.109.142]:4106 "EHLO quark.didntduck.org")
	by vger.kernel.org with ESMTP id <S130199AbRAPQcM>;
	Tue, 16 Jan 2001 11:32:12 -0500
Message-ID: <3A647761.CFBA5DE6@didntduck.org>
Date: Tue, 16 Jan 2001 11:31:29 -0500
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.73 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Venkatesh Ramamurthy <Venkateshr@ami.com>
CC: "'David Woodhouse'" <dwmw2@infradead.org>,
        "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>
Subject: Re: Linux not adhering to BIOS Drive boot order?
In-Reply-To: <1355693A51C0D211B55A00105ACCFE64E9518D@ATL_MS1>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Venkatesh Ramamurthy wrote:
> 
> > It should be possible to read the BIOS setting for this option and
> > behave accordingly. Please give full details of how to read and interpret
> > the information stored in the CMOS for all versions of AMI BIOS, and I'll
> > take a look at this.
>         [Venkatesh Ramamurthy]  When i meant BIOS setting option i meant the
> SCSI BIOS settings not system BIOS option. The two SCSI controllers are of
> different make. This situation is made worse when the system has many cards
> of different makes and one of the controller somewhere in the middle of all
> the slots is made the boot controller.

When the cards are of different make the order is solely dependent on
the order that the drivers are initialized in the kernel.  If you have
modules enabled, only build the driver for your root device into the
kernel image and have the other modular.  This lets you control the
initialization order to your liking.

--

				Brian Gerst
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
