Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262078AbUDPCxf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 22:53:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262114AbUDPCxf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 22:53:35 -0400
Received: from relay01.roc.ny.frontiernet.net ([66.133.131.34]:6337 "EHLO
	relay01.roc.ny.frontiernet.net") by vger.kernel.org with ESMTP
	id S262078AbUDPCxc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 22:53:32 -0400
From: Russell Miller <rmiller@duskglow.com>
To: linux-kernel@vger.kernel.org
Subject: udp traceroute dropping packets
Date: Thu, 15 Apr 2004 21:55:13 -0500
User-Agent: KMail/1.6.1
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-Id: <200404152155.18724.rmiller@duskglow.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I came across this archived linux-kernel message:

http://www.uwsg.iu.edu/hypermail/linux/net/0007.2/0111.html

I am having the exact same problem as is outlined there, from a post three 
years ago.  Here's a summary:

"I think I've found a bug in UDP/ICMP code in the kernel using 
 traceroute. 
 
To reproduce: Launch traceroute -n to some Linux system nearby 
 really quickly 3 times in the row; localhost won't work, it has to go 
 through network. Quick response is crucial. I used systems w/ in 
 the same physical network and a few routers between (still < 5 ms 
 response). 
 
The effect: On third traceroute (or perhaps second/first, if you're quick 
 enough), ICMP port unreachable will not be sent to the UDP datagram. "

I reproduced this on a redhat 8.0 machine running kernel 2.4.23.  Changing to 
the -I option of traceroute (to use ICMP) works flawlessly.  I'll be glad to 
provide more information if you need it.  Please CC, as I'm not subscribed.

- --Russell
- -- 

Russell Miller - rmiller@duskglow.com - Somewhere near Sioux City, IA.
Youth cannot know age, but age is guilty if it forgets youth
    - Professor Dumbledore
Hi! I'm a .signature virus! Copy me into your ~/.signature, please!
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAf0sUURTA4VCI9OARAs52AJ9llhS5KKvSe2nAU3lp82oySZ8c/gCfeyIK
i5V/P6Qj6ODS3jm6GSMQFrs=
=vREp
-----END PGP SIGNATURE-----
