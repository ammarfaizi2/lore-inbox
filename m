Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267476AbRGLLUe>; Thu, 12 Jul 2001 07:20:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267475AbRGLLUY>; Thu, 12 Jul 2001 07:20:24 -0400
Received: from shiva.jussieu.fr ([134.157.0.129]:8708 "EHLO shiva.jussieu.fr")
	by vger.kernel.org with ESMTP id <S267474AbRGLLUP>;
	Thu, 12 Jul 2001 07:20:15 -0400
Message-ID: <3B4D886C.8822B0A6@qosmos.net>
Date: Thu, 12 Jul 2001 13:22:20 +0200
From: Jerome Tollet <Jerome.Tollet@qosmos.net>
Organization: Qosmos
X-Mailer: Mozilla 4.77 [fr] (X11; U; Linux 2.4.3-12smp i686)
X-Accept-Language: fr-FR, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: bridge and multicast
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I tried to install a linux bridge on my network on which some multicast
traffic is present. It seems that the bridge stops the multicast
traffic. 
I looked at the bridge source code and i saw that there is no
special code to handle ethernet multicast mac adresses. The only code i
found is that
the bridge duplicates the packet for the local interface if the brgXX
interface has the flag
IFF_MULTI set.
I think that the problem is that the bridge has already seen a special
mac adress on its interface ethY
so it doesn't duplicate the packet on its other interfaces (ethZ).

What can i do ? Does someone experienced the same problem ?
Thanks for help

Please CC me personaly because i didn't subsribed to the lkml.

Jerome
-- 
------------------------
Jerome Tollet
jerome.tollet@qosmos.net
www.qosmos.net
------------------------
