Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279427AbRJ2UC7>; Mon, 29 Oct 2001 15:02:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279424AbRJ2UCt>; Mon, 29 Oct 2001 15:02:49 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:35081 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S279421AbRJ2UCk>; Mon, 29 Oct 2001 15:02:40 -0500
Message-ID: <3BDDB4E0.C90BFACB@zip.com.au>
Date: Mon, 29 Oct 2001 11:58:24 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.13-ac2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: harri@synopsys.com
CC: linux-kernel@vger.kernel.org
Subject: Re: 3c59x:command 0x3002 did not complete! Status=0xffff
In-Reply-To: <3BDD9FF4.D54DC0C9@Synopsys.COM> <3BDDA4C0.F4391EC@zip.com.au> <3BDDB312.589D2E04@Synopsys.COM>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Harald Dunkel wrote:
> 
> PS: The message about '0x3002 did not complete' is gone. I haven't seen
> it anymore since I added the 'options 3c59x enable_wol=1'.
> 
> But now I get this in my syslog:
> 
> Oct 29 20:41:19 bilbo pppd[522]: pppd 2.4.1 started by root, uid 0
> Oct 29 20:41:20 bilbo pppd[522]: Sending PADI
> Oct 29 20:41:20 bilbo kernel: eth0: Transmit error, Tx status register 90.

0x90 -> Transmit underrun.  The NIC wasn't able to get data
from main memory fast enough.    Across PCI.

> ...
> Oct 29 20:41:20 bilbo kernel: scsi0: PCI error Interrupt at seqaddr = 0x9

I wonder what that error is?

> 
> Especially interesting is the message about the SCSI. How is this
> related to the 3c59x?

The PCI bus is screwed up.  I haven't seen this before.
Is the machine otherwise stable?  What's special about bringing
up PPPoE?  Have you tested the machine well against other hosts
on the LAN?
