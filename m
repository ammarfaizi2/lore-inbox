Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271989AbRIRHrm>; Tue, 18 Sep 2001 03:47:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272475AbRIRHrc>; Tue, 18 Sep 2001 03:47:32 -0400
Received: from cpe.atm2-0-104276.arcnxx10.customer.tele.dk ([62.242.211.100]:30201
	"HELO arbat.com") by vger.kernel.org with SMTP id <S271989AbRIRHrU>;
	Tue, 18 Sep 2001 03:47:20 -0400
Date: Tue, 18 Sep 2001 09:47:43 +0200
From: Erik Corry <erik@arbat.com>
To: linux-kernel@vger.kernel.org, "Andrey V . Savochkin" <saw@saw.sw.com.sg>
Subject: eepro100/2.2.19: failure when switching to promiscuous mode
Message-ID: <20010918094743.A17515@arbat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Kernel 2.2.19, SMP, PIII-800

I've been seeing the eepro100 ethernet driver stop working when VMWare
puts it in promiscuous mode.  /var/log/messages looks like this:

Sep 18 08:35:18 gna kernel: bridge-eth0: set IFF_PROMISC
Sep 18 08:35:32 gna sshd[531]: Generating new 768 bit RSA key.
Sep 18 08:35:32 gna sshd[531]: RSA key generation complete.
Sep 18 08:35:36 gna kernel: nfs: server noatun is not responding
Sep 18 08:35:36 gna kernel: rtc: lost some interrupts at 256Hz.
Sep 18 08:35:42 gna kernel: eth0: Transmit timed out: status f048  0c00 at 911685345/911685405 command 000ca000.
Sep 18 08:35:52 gna kernel: nfs: server noatun still not responding
Sep 18 08:35:52 gna kernel: rtc: lost some interrupts at 256Hz.
Sep 18 08:36:07 gna kernel: nfs: server noatun still not responding
Sep 18 08:36:07 gna kernel: rtc: lost some interrupts at 256Hz.
Sep 18 08:36:23 gna kernel: nfs: server noatun still not responding

/proc/pci says:

Bus  0, device  14, function  0:
  Ethernet controller: Intel 82557 (rev 8).
    Medium devsel.  Fast back-to-back capable.  IRQ 21.  Master Capable.  Latency=64.  Min Gnt=8.Max Lat=56.
    Non-prefetchable 32 bit memory at 0xf4102000 [0xf4102000].
    I/O at 0x2800 [0x2801].
    Non-prefetchable 32 bit memory at 0xf4000000 [0xf4000000].

Yours,

-- 
Erik Corry erik@arbat.com           Ceterum censeo, Microsoftem esse delendam!
