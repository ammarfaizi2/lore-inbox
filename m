Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263327AbSIPXM3>; Mon, 16 Sep 2002 19:12:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263334AbSIPXM3>; Mon, 16 Sep 2002 19:12:29 -0400
Received: from virtmail.zianet.com ([216.234.192.37]:40660 "HELO zianet.com")
	by vger.kernel.org with SMTP id <S263327AbSIPXM1>;
	Mon, 16 Sep 2002 19:12:27 -0400
Message-ID: <3D8661E4.702@zianet.com>
Date: Mon, 16 Sep 2002 16:57:40 -0600
From: kwijibo@zianet.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2a) Gecko/20020913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Errors on D-Link DFE-580TX
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get these errors on using the D-Link DFE-580TX 4 port ethernet card.
This is with a RedHat kernel 2.4.18-5smp and using the latest sundance
driver version 1.09.  These errors used to be much more frequent with
earlier versions of the driver but they still occur.  These errors are 
just a
few of the many in my syslog.

eth0: Too much work at interrupt, status=0x0205 / 0x0205 .. 0x0214.
eth0: Transmit timed out, status 8c0, resetting...
  Rx ring de3c3000:  00008053 0000803c 0000804a 0000804a 0000803c 
00008040 00008040 0000803c 0000804a 0
000803c 0000803c 0000803c 0000803c 0000803c 00008067 00008067 00008067 
00008067 00008040 00008040 00008
067 0000803c 0000803c 00008040 00008040 0000803c 0000803c 0000808e 
0000804a 00008067
  Tx ring de3c3200:  80018001 80018005 80018009 8001800d 80018011 
80018015 80018019 8001801d                     0018029 8001802d 80018031 
80018035 80018039 8001803d
eth0: Too much work at interrupt, status=0x0005 / 0x0205 .. 0x0204.
eth0: Transmit timed out, status 9c0, resetting...
  Rx ring de3c3000:  0000803c 00008067 0000803c 0000803c 0000804a 
0000804a 0000803c 0000803c                     0008040 00008040 0000803c 
0000803c 0000803c 0000803c 0000803c 0000803c 0000804a 0000803c 
0000                    040 00008040 0000803c 00008067 0000803c 00008067 
00008067 00008067 00008067 00008067
  Tx ring de3c3200:  80018001 80018005 80018009 8001800d 80018011 
80018015 80018019 8001801d                     0018029 8001802d 80018031 
80018035 80018039 8001803d

Here is output of the card init:

sundance.c:v1.09 7/13/2002  Written by Donald Becker <becker@scyld.com>
  http://www.scyld.com/network/sundance.html
eth0: D-Link DFE-580TX (Sundance ST201) at 0xdc00, 00:05:5d:e6:2b:05, 
IRQ 11.
eth0: MII PHY found at address 1, status 0x782d advertising 01e1.
eth1: D-Link DFE-580TX (Sundance ST201) at 0xd880, 00:05:5d:e6:2b:06, 
IRQ 10.
eth1: MII PHY found at address 1, status 0x7809 advertising 01e1.
eth2: D-Link DFE-580TX (Sundance ST201) at 0xd800, 00:05:5d:e6:2b:07, IRQ 9.
eth2: MII PHY found at address 1, status 0x7809 advertising 01e1.
eth3: D-Link DFE-580TX (Sundance ST201) at 0xd480, 00:05:5d:e6:2b:08, 
IRQ 11.
eth3: MII PHY found at address 1, status 0x7809 advertising 01e1.

Any ideas on what it could be?  The card will stop working for a bit 
after a reset but
it always comes back.  This kind of behavior won't work for a production 
box however.

Steve



  

