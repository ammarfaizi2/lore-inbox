Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279233AbRJ2Ljy>; Mon, 29 Oct 2001 06:39:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279236AbRJ2Ljp>; Mon, 29 Oct 2001 06:39:45 -0500
Received: from [194.90.137.3] ([194.90.137.3]:36111 "EHLO MAILGW")
	by vger.kernel.org with ESMTP id <S279233AbRJ2Ljh>;
	Mon, 29 Oct 2001 06:39:37 -0500
Date: Mon, 29 Oct 2001 13:40:00 +0200
From: Michael Rozhavsky <mrozhavsky@opticalaccess.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Intel EEPro 100 with kernel drivers
Message-ID: <20011029134000.J24143@opticalaccess.com>
In-Reply-To: <20011029021339.B23985@stud.ntnu.no> <E15y9uL-0002F3-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E15y9uL-0002F3-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Mon, Oct 29, 2001 at 10:44:41AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We have exactly the same problem with 2.4.9, 2.4.10 and 2.4.13, so
We had to switch to Intel's driver.

from 'cat /proc/pci'
  Bus  1, device   1, function  0:
    Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev 8).
      IRQ 9.
      Master Capable.  Latency=64.  Min Gnt=8.Max Lat=56.
      Non-prefetchable 32 bit memory at 0xff8fe000 [0xff8fefff].
      I/O at 0xdf00 [0xdf3f].
      Non-prefetchable 32 bit memory at 0xff600000 [0xff6fffff].

It is Intel i810 motherboard with NIC onboard.

but Intel's driver (e100-1.6.22) says on boot: 
eth0: Intel(R) 82559 Fast Ethernet LAN on Motherboard

the chip is:
GD82559
L021LP51

We have this problem when nic is under high traffic.

Is there any other information that can help you to track the problem?

P.S. I can reproduce this problem any time.

On Mon, Oct 29, 2001 at 10:44:41AM +0000, Alan Cox wrote:
> > directory on a machine), the network-card says "eth0: Card reports no
> > resources" to dmesg, and then the "line" appear dead for some time (one
> > minutte or more). What can be done to remove this error? NFS timesout with
> > this error (obviously)...
> 
> Which kernel version, which eepro100 chip ?
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
Best regards.

--
   Michael Rozhavsky			Tel:    +972-4-9936248
   mrozhavsky@opticalaccess.com		Fax:    +972-4-9890564
   Optical Access  
   Senior Software Engineer		www.opticalaccess.com
