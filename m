Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130510AbRAPRi7>; Tue, 16 Jan 2001 12:38:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130423AbRAPRit>; Tue, 16 Jan 2001 12:38:49 -0500
Received: from gateway.sequent.com ([192.148.1.10]:45130 "EHLO
	gateway.sequent.com") by vger.kernel.org with ESMTP
	id <S129706AbRAPRik>; Tue, 16 Jan 2001 12:38:40 -0500
From: Malahal Rao Naineni <naineni@sequent.com>
Message-Id: <200101161738.f0GHcK214559@eng2.sequent.com>
Subject: Re: Linux not adhering to BIOS Drive boot order?
To: Venkateshr@ami.com (Venkatesh Ramamurthy)
Date: Tue, 16 Jan 2001 09:38:19 -0800 (PST)
Cc: linux-scsi@vger.kernel.org ('linux-scsi@vger.kernel.org'),
        linux-kernel@vger.kernel.org ('linux-kernel@vger.kernel.org'),
        alan@lxorguk.ukuu.org.uk ('Alan Cox')
In-Reply-To: <1355693A51C0D211B55A00105ACCFE64E9518C@ATL_MS1> from "Venkatesh Ramamurthy" at Jan 16, 2001 09:49:05 AM PST
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Venkatesh Ramamurthy wrote:
> 
> Hi,
> I have one issue which requires fix from the linux kernel. 
> Initially i put a SCSI controller and install the OS on the drive connected
> to it. After installing the OS (on sda), the customer puts another SCSI
> controller. The BIOS for the first controller has BIOS enabled and for the
> second controller does not have the BIOS enabled. 
> 
> The linux loads the driver for the second controller first and assigns sda
> to it first , and the actual boot drive gets some sdX device node. 
> >From the lilo prompt we can override it with root=/dev/sdX to boot to the
> correct drive and controller, but for a end -user using these cards, this is
> no fun.
> 
> 
> Can the linux kernel be changed in such a way that kernel will look for the
> actual boot drive and re-order the drives so that mounting can go on in the
> right order.

Name slippage is a horrible thing. That should be fixed first. The O/S
should get the device names right for every boot.

Thanks, Malahal.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
