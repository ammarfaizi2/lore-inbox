Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273912AbRJDNCs>; Thu, 4 Oct 2001 09:02:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273983AbRJDNCj>; Thu, 4 Oct 2001 09:02:39 -0400
Received: from robur.slu.se ([130.238.98.12]:7944 "EHLO robur.slu.se")
	by vger.kernel.org with ESMTP id <S273912AbRJDNCW>;
	Thu, 4 Oct 2001 09:02:22 -0400
From: Robert Olsson <Robert.Olsson@data.slu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15292.24193.308549.459631@robur.slu.se>
Date: Thu, 4 Oct 2001 15:05:05 +0200
To: <mingo@elte.hu>
Cc: jamal <hadi@cyberus.ca>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        <linux-kernel@vger.kernel.org>,
        Robert Olsson <Robert.Olsson@data.slu.se>, <bcrl@redhat.com>,
        <netdev@oss.sgi.com>, Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
In-Reply-To: <Pine.LNX.4.33.0110040831020.1727-100000@localhost.localdomain>
In-Reply-To: <Pine.GSO.4.30.0110031828100.7244-100000@shell.cyberus.ca>
	<Pine.LNX.4.33.0110040831020.1727-100000@localhost.localdomain>
X-Mailer: VM 6.92 under Emacs 19.34.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ingo Molnar writes:
 > 
 > i'm asking the following thing. dev->quota, as i read the patch now, can
 > cause extra calls to ->poll() even though the RX ring of that particular
 > device is empty and the driver has indicated it's done processing RX
 > packets. (i'm now assuming that the extra-polling-for-a-jiffy line in the
 > current patch is removed - that one is a showstopper to begin with.) Is
 > this claim of mine correct?

 Hello!

 Well I'm the one to blame... :-) This comes from my experiments to delay 
 to polling before going into RX-irq-enable mode. This is one of the areas
 to be addressed further with NAPI. And this code was not in any of the 
 files that I announced I think..?

 Cheers.

						--ro
