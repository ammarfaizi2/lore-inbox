Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129345AbQLLSCY>; Tue, 12 Dec 2000 13:02:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130755AbQLLSCO>; Tue, 12 Dec 2000 13:02:14 -0500
Received: from quattro.sventech.com ([205.252.248.110]:56073 "HELO
	quattro.sventech.com") by vger.kernel.org with SMTP
	id <S129345AbQLLSCK>; Tue, 12 Dec 2000 13:02:10 -0500
Date: Tue, 12 Dec 2000 12:31:38 -0500
From: Johannes Erdfelt <johannes@erdfelt.com>
To: linux-usb-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] PROBLEM: USB (MS Intellimouse specifically) does not work with SMP Linux 2.2.18.
Message-ID: <20001212123137.D17167@sventech.com>
In-Reply-To: <NEBBKCNHIKGLMACGICIGAEFMCAAA.lar@cs.york.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4i
In-Reply-To: <NEBBKCNHIKGLMACGICIGAEFMCAAA.lar@cs.york.ac.uk>; from Laramie Leavitt on Tue, Dec 12, 2000 at 02:07:59PM -0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2000, Laramie Leavitt <lar@cs.york.ac.uk> wrote:
> [1.] One line summary of the problem:
> USB (MS Intellimouse specifically) does not work with SMP kernel 2.2.18.
> 
> [2.] Full description of the problem/report:
> When trying to install a Microsoft Intellimouse Explorer (USB)
> to a SMP kernel, I get the following error multiple times:
> 
> usb.c: USB device not accepting new address (error=-110)
> 
> If USB is compiled in, then it happens several times during the
> boot sequence.
> 
> Everything works fine on a single-processor kernel.  I have tried
> installing all of USB as modules, and I have tried compiling it
> into the kernel with no change.
> 
> System is a MSI 694D-Pro AR motherboard (Via 694X chipset)
> Dual 500 Mhz Celeron processors, 500 Mhz (Not overclocked)
> Microsoft Intellimouse explorer.
> 
> I suspect that it is an issue where locking is required,
> but none currently exists, either in mousedev, usb, or
> uhci.  (Great logic--those are the main modules that should
> be in use.) I suspect that the problem can be duplicated
> on my system under Linux 2.4.0-test11, but, alas, I cannot
> get linux 2.4 to boot right now.
> 
> I don't see the hid module in the status output like I do on
> the uni-processor kernel.  Maybe those structures need locks.

Unlikely. Many people use that particular mouse with your particular HCD
in SMP every day. Like myself. In fact I am right now, using 2.2.18.

What is more likely the cause is an IRQ routing problem.

Can you check /proc/interrupts and see if the interrupt count is going
up?

Also, can you check your BIOS and see if it is configured for MPS 1.4?
If so, change it to MPS 1.1.

JE

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
