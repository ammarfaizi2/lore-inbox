Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263968AbSKCXL1>; Sun, 3 Nov 2002 18:11:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264610AbSKCXL1>; Sun, 3 Nov 2002 18:11:27 -0500
Received: from msdo0001.xtend.de ([217.27.0.68]:64460 "EHLO msdo0001.xtend.de")
	by vger.kernel.org with ESMTP id <S263968AbSKCXLK>;
	Sun, 3 Nov 2002 18:11:10 -0500
Message-ID: <3DC5AE86.7010404@triaton-webhosting.com>
Date: Mon, 04 Nov 2002 00:17:26 +0100
From: Georg Chini <georg.chini@triaton-webhosting.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Sparc 32/64 - freeswan - iptables 
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

when I try to use freeswan on my sparcs, I have the following problems:

1) freeswan+iptables crashes the system on sparc 32
2) freeswan does not work on ethX interfaces but on ppp0
3) freeswan crashes the system on sparc64

1)for half a year I have been trying to make freeswan work on
   my Sparc Station 5  or Ultra 1.  I used several kernel  and
   freeswan versions. A few days ago, I found out that it works
   on my ppp0 (pppoe) interface, but not on ethX interfaces.
  The problem is, that ipsec is stable on the sparc 32 as long as the 
netfilter
  code is not in the kernel.  As soon as I load the iptable modules
  (or ipchains) the machine crashes without any message when
  I use the tunnel, even if there are no rules in place.
  Iptables without ipsec works fine.
  I compiled all the code into the kernel, but it had no effect.
  The same configuration works well on my Intel machine.
  I am currently using 2.4.20-rc1 with freeswan-2.00 or 1.98b.

2) When I use ipsec over an ethX interface,  the ipsec interface drops the
     outgoing packets and reports an error. As far as I found out, the
     ip_route_output call in line 1898 of ipsec_tunnel.c returns an
    error.I am not able to get the errorcode returned, because the
    system crashes when I try to print it out. I have the same problem
    on the 32 bit and 64 bit platform. I posted that problem in the freeswan
    lists a while ago, but nobody could help me.

3)I patched sys_ioctl32.c on the ultra (horrible hack I suppose,
    I'm no C-programmer). On ppp0 the sparc 64 is able to establish
    an ipsec connection, but crashes as soon as I try to use the tunnel.
   
Can anyone help me to solve one of my problems?

Thanks in advance
                                    Georg Chini

