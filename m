Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279548AbRJ2VWQ>; Mon, 29 Oct 2001 16:22:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279544AbRJ2VWH>; Mon, 29 Oct 2001 16:22:07 -0500
Received: from kiruna.synopsys.com ([204.176.20.18]:52425 "HELO
	kiruna.synopsys.com") by vger.kernel.org with SMTP
	id <S279543AbRJ2VVu>; Mon, 29 Oct 2001 16:21:50 -0500
Message-ID: <3BDDC879.7F1D2D2C@Synopsys.COM>
Date: Mon, 29 Oct 2001 22:22:01 +0100
From: Harald Dunkel <harri@synopsys.COM>
Reply-To: harri@synopsys.COM
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.13 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Tim Walberg <twalberg@mindspring.com>
Cc: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
Subject: Re: 3c59x:command 0x3002 did not complete! Status=0xffff
In-Reply-To: <3BDD9FF4.D54DC0C9@Synopsys.COM> <3BDDA4C0.F4391EC@zip.com.au> <3BDDB312.589D2E04@Synopsys.COM> <3BDDB4E0.C90BFACB@zip.com.au> <3BDDBD60.3540EFCA@Synopsys.COM> <20011029145307.A8312@mindspring.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Walberg wrote:
> 
> Is the NIC sharing interrupts or I/O ports with
> the SCSI HBAs?
> 

Nope:

  Bus  0, device  10, function  0:
    SCSI storage controller: Adaptec 7899A (rev 1).
      IRQ 15.
      Master Capable.  Latency=32.  Min Gnt=40.Max Lat=25.
      I/O at 0xa000 [0xa0ff].
      Non-prefetchable 64 bit memory at 0xd5000000 [0xd5000fff].
  Bus  0, device  10, function  1:
    SCSI storage controller: Adaptec 7899A (#2) (rev 1).
      IRQ 9.
      Master Capable.  Latency=32.  Min Gnt=40.Max Lat=25.
      I/O at 0x9800 [0x98ff].
      Non-prefetchable 64 bit memory at 0xd4800000 [0xd4800fff].
  Bus  0, device  11, function  0:
    Ethernet controller: 3Com Corporation 3c900 Combo [Boomerang] (rev 0).
      IRQ 10.
      Master Capable.  Latency=32.  Min Gnt=3.Max Lat=8.
      I/O at 0x9400 [0x943f].


The SCSI controller is an Adaptec 39160, so it allocates 2 IRQs, 2 I/Os,
etc.


Regards

Harri
