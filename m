Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316615AbSGLQSJ>; Fri, 12 Jul 2002 12:18:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316621AbSGLQSI>; Fri, 12 Jul 2002 12:18:08 -0400
Received: from zianet.com ([204.134.124.201]:27287 "HELO zianet.com")
	by vger.kernel.org with SMTP id <S316615AbSGLQSG>;
	Fri, 12 Jul 2002 12:18:06 -0400
Message-ID: <3D2F0364.8020902@zianet.com>
Date: Fri, 12 Jul 2002 10:27:16 -0600
From: kwijibo@zianet.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1a+) Gecko/20020709
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kernel <linux-kernel@vger.kernel.org>
Subject: Errors using D-Link DFE-580TX (sundance.o)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, I got the D-Link DFE-580TX card working with the
new drivers from Donald Becker(thanks), and I may have
spoke too soon on it working great.  It correctly recognizes the eth
ports:

sundance.c:v1.07 7/3/2002 Written by Donald Becker <becker@scyld.com>
http://www.scyld.com/network/sundance.html
eth0: OEM Sundance Technology ST201 at 0xdc00, 00:05:5d:e6:2b:19, IRQ 11.
eth0: MII PHY found at address 0, status 0x782d advertising 01e1.
eth0: MII PHY found at address 1, status 0x782d advertising 01e1.
eth1: OEM Sundance Technology ST201 at 0xd880, 00:05:5d:e6:2b:1a, IRQ 10.
eth1: MII PHY found at address 0, status 0x7809 advertising 01e1.
eth1: MII PHY found at address 1, status 0x7809 advertising 01e1.
eth2: OEM Sundance Technology ST201 at 0xd800, 00:05:5d:e6:2b:1b, IRQ 9.
eth2: MII PHY found at address 0, status 0x7809 advertising 01e1.
eth2: MII PHY found at address 1, status 0x7809 advertising 01e1.
eth3: OEM Sundance Technology ST201 at 0xd480, 00:05:5d:e6:2b:1c, IRQ 11.
eth3: MII PHY found at address 0, status 0x7809 advertising 01e1.
eth3: MII PHY found at address 1, status 0x7809 advertising 01e1

But after running it for a while I noticed these errors in the syslog:

eth0: Too much work at interrupt, status=0x0011 / 0x0011.
eth0: Transmit timed out, status c0, resetting...
  Rx ring d9a40800:  0000803c 000080a5 0000803c 0000803c 0000803c 
0000803c 000085ea 000085a5 0000803c 0000803c 0000803c 0000803c 0000828a 
0000859a 0000859a 0000859a 0000859a 0000859a 000085ea 0000859a 0000859a 
0000859a 0000859a 0000859a 0000859a 0000821a 0000859a 0000859a 0000829c 
0000859a 000085a5 00008042
  Tx ring d9a40a00:  80018001 80018005 80018009 8001800d 80018011 
80018015 80018019 8001801d 80018021 80018025 80018029 8001802d 80018031 
80018035 80018039 8001803d
eth0: Too much work at interrupt, status=0x0011 / 0x0011.
eth0: Transmit timed out, status c0, resetting...
  Rx ring d9a40800:  0000803c 0000803c 00008076 000085ea 00008409 
00008299 0000803c 0000803c 000085ea 0000803c 0000803c 0000803c 0000803c 
0000803c 0000803c 000085ea 0000803c 0000803c 0000806e 0000803c 0000803c 
000085ea 0000803c 0000803c 0000803c 0000803c 0000803c 0000803c 0000803c 
0000803c 0000803c 0000803c
  Tx ring d9a40a00:  80018001 80018005 80018009 8001800d 80018011 
80018015 80018019 8001801d 80018021 80018025 80018029 8001802d 80018031 
80018035 80018039 8001803d
eth0: Too much work at interrupt, status=0x0011 / 0x0615.
eth0: Transmit timed out, status c0, resetting...
  Rx ring d9a40800:  0000803c 0000803c 0000803c 0000803c 0000803c 
0000803c 000085ea 0000803c 000080a6 0000803c 00008042 0000803c 00008442 
0000843e 00008442 00008442 000085ea 0000803c 0000803c 0000803c 0000803c 
000085ea 0000803c 0000803c 0000803c 0000803c 0000803c 000085ea 00008072 
0000803c 0000803c 0000803c
  Tx ring d9a40a00:  80018001 80018005 80018009 8001800d 80018011 
80018015 80018019 8001801d 80018021 80018025 80018029 8001802d 80018031 
80018035 80018039 8001803d
eth0: Too much work at interrupt, status=0x0011 / 0x0011.
eth0: Transmit timed out, status c0, resetting...
  Rx ring d9a40800:  0000803c 000085ea 00008243 0000805c 0000803c 
000080e4 0000803c 0000803c 000085ea 0000803c 0000803c 0000803c 0000803c 
0000803c 0000803c 000085ea 0000803c 0000803c 0000803c 0000803c 0000803c 
0000805c 0000803c 0000803c 0000803c 0000803c 0000803c 0000803c 0000803c 
0000803c 0000803c 0000803c
  Tx ring d9a40a00:  80018001 80018005 80018009 8001800d 80018011 
80018015 80018019 8001801d 80018021 80018025 80018029 8001802d 80018031 
80018035 80018039 8001803d

This is on a RedHat kernel 2.4.18-5smp and with Donalds sundance driver
(1.07) that is available on his site.  While these resets at the moment 
don't affect
me to much because I am just using it in my personel computer,  it will 
hopefully
be moved into a high traffice situation where this just won't work.  Any 
ideas?

Thanks,
Steven

Btw, here is a list of modules:
Module                  Size  Used by    Not tainted
sb                      9152   0 (autoclean)
sb_lib                 41856   0 (autoclean) [sb]
uart401                 8064   0 (autoclean) [sb_lib]
sound                  75244   0 (autoclean) [sb_lib uart401]
soundcore               7044   5 (autoclean) [sb_lib sound]
sundance               11424   2
pci-scan                4700   1 [sundance]
autofs                 12612   0 (autoclean) (unused)
ipchains               46120  12
usbcore                75904   1
ext3                   70944   2
jbd                    53728   2 [ext3]





