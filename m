Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286221AbSAHKTM>; Tue, 8 Jan 2002 05:19:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285130AbSAHKTC>; Tue, 8 Jan 2002 05:19:02 -0500
Received: from smtp1.ndsu.NoDak.edu ([134.129.111.146]:11271 "EHLO
	smtp1.ndsu.nodak.edu") by vger.kernel.org with ESMTP
	id <S284659AbSAHKSu>; Tue, 8 Jan 2002 05:18:50 -0500
Subject: Re: PCI SCSI interrupt clash
From: Reid Hekman <reid.hekman@ndsu.nodak.edu>
To: linux-kernel@vger.kernel.org
In-Reply-To: <5.1.0.14.0.20020108203421.00af4940@pop-server.bigpond.net.au>
In-Reply-To: <5.1.0.14.0.20020108203421.00af4940@pop-server.bigpond.net.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 08 Jan 2002 04:17:41 -0600
Message-Id: <1010485105.2044.2.camel@zeus>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-01-08 at 03:46, Glenn Geers wrote:
> enclose the win2k interrupt allocation for your perusal and comment (it's 
> weird!)
...
> System Information report written at: 08/01/2002 08:44:11 PM
> [IRQs]
> 
> IRQ Number    Device
> 5     Sound Blaster 16 or AWE32 or compatible (WDM)
> 128   Matrox Millennium G400 DualHead MAX
> 14    Primary IDE Channel
> 15    Secondary IDE Channel
> 11    Intel 82371AB/EB PCI to USB Universal Host Controller
> 36    Adaptec AHA-2940U2/U2W PCI SCSI Controller
> 52    Realtek RTL8139/810X Family PCI Fast Ethernet NIC
> 56    Hauppauge Win/TV 878/9 VFW Video Driver
> 56    Hauppauge Win/TV 878/9 VFW Audio Driver
> 60    Creative SB Live! Value (WDM)
> 64    Texas Instruments OHCI Compliant IEEE 1394 Host Controller
> 1     PC/AT Enhanced PS/2 Keyboard (101/102-Key)
> 4     Communications Port (COM1)
> 3     Communications Port (COM2)
> 6     Standard floppy disk controller
> 8     System CMOS/real time clock
> 13    Numeric data processor
> 12    Other Logitech Mouse PS/2
> 
> I hope someone can shed some light on the very high (>20) interrupt 
> numbers. I'd really like and will help to get to the bottom of the problem.

Win2k with the ACPI HAL will reroute IRQ's to 256 "virtual" IRQ's, hence
the high numbers.

What happens if you twiddle ACPI/PnP OS in the BIOS?

And do you really expect a PCI bus overclocked past 37MHz to survive
with 5 PCI cards? You get 40 lashes with a wet noodle >:-(

Regards,
Reid

