Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279473AbRJ2UfM>; Mon, 29 Oct 2001 15:35:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279496AbRJ2UfD>; Mon, 29 Oct 2001 15:35:03 -0500
Received: from hamachi.synopsys.com ([204.176.20.26]:38134 "EHLO
	hamachi.synopsys.com") by vger.kernel.org with ESMTP
	id <S279483AbRJ2Ues>; Mon, 29 Oct 2001 15:34:48 -0500
Message-ID: <3BDDBD60.3540EFCA@Synopsys.COM>
Date: Mon, 29 Oct 2001 21:34:40 +0100
From: Harald Dunkel <harri@synopsys.COM>
Reply-To: harri@synopsys.COM
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.13 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@zip.com.au>
CC: linux-kernel@vger.kernel.org
Subject: Re: 3c59x:command 0x3002 did not complete! Status=0xffff
In-Reply-To: <3BDD9FF4.D54DC0C9@Synopsys.COM> <3BDDA4C0.F4391EC@zip.com.au> <3BDDB312.589D2E04@Synopsys.COM> <3BDDB4E0.C90BFACB@zip.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 
> The PCI bus is screwed up.  I haven't seen this before.
> Is the machine otherwise stable?  What's special about bringing
> up PPPoE?  Have you tested the machine well against other hosts
> on the LAN?

The eth0 has the address 192.168.1.1 . When I do a ping 192.168.1.2,
then I get an error message, too:

Oct 29 21:28:49 bilbo kernel: scsi0: PCI error Interrupt at seqaddr = 0x8
Oct 29 21:28:49 bilbo kernel: scsi0: Data Parity Error Detected during address or write data phase
Oct 29 21:28:49 bilbo kernel: eth0: Transmit error, Tx status register ff.
Oct 29 21:28:49 bilbo kernel:   Flags; bus-master 1, dirty 1(1) current 1(1)
Oct 29 21:28:49 bilbo kernel:   Transmit list ffffffff vs. df231240.
Oct 29 21:28:49 bilbo kernel:   0: @df231200  length 8000002a status 8000002a
Oct 29 21:28:49 bilbo kernel:   1: @df231240  length 00000000 status 00000000
Oct 29 21:28:49 bilbo kernel:   2: @df231280  length 00000000 status 00000000
Oct 29 21:28:49 bilbo kernel:   3: @df2312c0  length 00000000 status 00000000
Oct 29 21:28:49 bilbo kernel:   4: @df231300  length 00000000 status 00000000
Oct 29 21:28:49 bilbo kernel:   5: @df231340  length 00000000 status 00000000
Oct 29 21:28:49 bilbo kernel:   6: @df231380  length 00000000 status 00000000
Oct 29 21:28:49 bilbo kernel:   7: @df2313c0  length 00000000 status 00000000
Oct 29 21:28:49 bilbo kernel:   8: @df231400  length 00000000 status 00000000
Oct 29 21:28:49 bilbo kernel:   9: @df231440  length 00000000 status 00000000
Oct 29 21:28:49 bilbo kernel:   10: @df231480  length 00000000 status 00000000
Oct 29 21:28:49 bilbo kernel:   11: @df2314c0  length 00000000 status 00000000
Oct 29 21:28:49 bilbo kernel:   12: @df231500  length 00000000 status 00000000
Oct 29 21:28:49 bilbo kernel:   13: @df231540  length 00000000 status 00000000
Oct 29 21:28:49 bilbo kernel:   14: @df231580  length 00000000 status 00000000
Oct 29 21:28:49 bilbo kernel:   15: @df2315c0  length 00000000 status 00000000
Oct 29 21:28:49 bilbo kernel: eth0: Updating statistics failed, disabling stats as an interrupt source.
Oct 29 21:28:49 bilbo kernel: eth0: Host error, FIFO diagnostic register ffff.
Oct 29 21:28:49 bilbo kernel: eth0: PCI bus error, bus status ffffffff
Oct 29 21:28:49 bilbo kernel: scsi1: PCI error Interrupt at seqaddr = 0x8
Oct 29 21:28:49 bilbo kernel: scsi1: Data Parity Error Detected during address or write data phase


PPPoE was not involved in this. It wasn't even started.

Maybe the NIC is broken? 


Regards

Harri
