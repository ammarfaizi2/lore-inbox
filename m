Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129161AbRBCE4F>; Fri, 2 Feb 2001 23:56:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129481AbRBCEz4>; Fri, 2 Feb 2001 23:55:56 -0500
Received: from saloma.stu.rpi.edu ([128.113.199.230]:1801 "HELO
	incandescent.mp3revolution.net") by vger.kernel.org with SMTP
	id <S129161AbRBCEzn>; Fri, 2 Feb 2001 23:55:43 -0500
From: dilinger@mp3revolution.net
Date: Fri, 2 Feb 2001 23:54:31 -0500
To: linux-kernel@vger.kernel.org
Cc: dhinds@zen.stanford.edu
Subject: xirc2ps_cs driver timeouts/errors
Message-ID: <20010202235431.A16216@incandescent.mp3revolution.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
X-Operating-System: Linux incandescent 2.4.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My logs show the following:

xirc2ps_cs.c 1.31 1998/12/09 19:32:55 (dd9jn+kvh)
eth0: Xircom: port 0x300, irq 3, hwaddr 00:80:C7:1E:28:2A
eth0: MII link partner: 0021
eth0: MII selected
eth0: media 10BaseT, silicon revision 4
UDP: short packet: 137/58
NETDEV WATCHDOG: eth0: transmit timed out
eth0: transmit timed out
eth0: MII link partner: 0021
eth0: MII selected
eth0: media 10BaseT, silicon revision 4
NETDEV WATCHDOG: eth0: transmit timed out
eth0: transmit timed out
eth0: MII link partner: 0021
eth0: MII selected
eth0: media 10BaseT, silicon revision 4
UDP: short packet: 0/213
UDP: short packet: 0/58

Each time I get a transmit timeout, or UDP: short packet error,
networking on my laptop seems to go down.  Reinsertion of the
card temporarily fixes it, and if I leave it long enough it
also fixes itself.

Hardware info:

Socket 0:
  product info: "Xircom", "CreditCard 10/100", "CE3-10/100", "1.00"
  manfid: 0x0105, 0x010a
  function: 6 (network)

Socket 0:
  Vcc 5.0V  Vpp1 0.0V  Vpp2 0.0V
  interface type is "memory and I/O"
  irq 3 [exclusive] [level]
  function 0:
    config base 0x0800
      option 0x41 status 0x00
    io 0x0300-0x030f [16bit]

  Bus  0, device   3, function  0:
    CardBus bridge: Texas Instruments PCI1225 (rev 1).
      IRQ 11.
      Master Capable.  Latency=168.  Min Gnt=192.Max Lat=5.
      Non-prefetchable 32 bit memory at 0x10000000 [0x10000fff].
  Bus  0, device   3, function  1:
    CardBus bridge: Texas Instruments PCI1225 (#2) (rev 1).
      IRQ 11.
      Master Capable.  Latency=168.  Min Gnt=192.Max Lat=5.
      Non-prefetchable 32 bit memory at 0x10001000 [0x10001fff].

Kernel is stock 2.4.1.  If any more info is needed, let me know.
Please CC replies to me, as I'm not on the list.

-- 
"... being a Linux user is sort of like living in a house inhabited
by a large family of carpenters and architects. Every morning when
you wake up, the house is a little different. Maybe there is a new
turret, or some walls have moved. Or perhaps someone has temporarily
removed the floor under your bed." - Unix for Dummies, 2nd Edition
        -- found in the .sig of Rob Riggs, rriggs@tesser.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
