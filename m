Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262667AbVDAJnt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262667AbVDAJnt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 04:43:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262676AbVDAJnt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 04:43:49 -0500
Received: from baikonur.stro.at ([213.239.196.228]:40322 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S262667AbVDAJnq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 04:43:46 -0500
Date: Fri, 1 Apr 2005 11:43:44 +0200
From: maximilian attems <debian@sternwelten.at>
To: Jefferson Cowart <jeff@cowart.net>
Cc: 270376@bugs.debian.org, linux-pcmcia@lists.infradead.org,
       rmk@arm.linux.org.uk, daniel.ritz@gmx.ch, linux-kernel@vger.kernel.org
Subject: Re: Bug#270376: PCMCIA Nic stops working after upgrading to 2.6.6/7/8
Message-ID: <20050401094344.GA2755@sputnik.stro.at>
References: <20050330150609.GN2559@sputnik.stro.at> <20050331101612.B3B5B1012F@P450.internal.cowart.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050331101612.B3B5B1012F@P450.internal.cowart.net>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

cc'ing the pcmcia maintainer and the author of
the patch for interrupt routing for TI bridges.
concerning a bug report about non working irq routing since 2.6.6-rc1
up until 2.6.12-rc1-mm3
http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=270376
(lspci, dmesg)

hope you can help to resolve that issue.
i volountary test build kernels for bug reporter with proposed patches.

On Thu, 31 Mar 2005, Jefferson Cowart wrote:

> (For reference my primary card is a 3C574. My secondary is a 3C589.)
.. 
> ========
> 
> (I put that card into a Windows XP laptop and it worked fine there so the
> card itself is fine.)
> 
> Now I'm trying to see if I have these same problems on 2.5.5
> 
> First, Booting with the secondary card plugged in had the same failure as
> above.
> Next booting with the primary plugged in. It worked (as expected). Then I
> was able to pull and re-insert the card without problems. However pulling
> the primary and inserting the secondary killed the network (as expected).
> 
> Now I'm going back to 2.4.27 to figure out if my secondary card will work
> there. It failed. I got a hard lock when I inserted the card. (Reboot button
> needed.)
> 
> I'm 99.9% certain that my testing of 2.6.6-2.6.10 was using my primary nic,
> but I'm booting 2.6.10 now to be sure. (I know the kernels I tested for you
> yesterday used my primary nic.) As expected no networking.
> 
> It looks like we may have 2 different bugs here: one in the yenta_socket
> driver starting somewhere after 2.6.5-bk1 and before 2.6.6-rc1 and one in
> the 3c589 driver in I don't know what versions. (I seem to remember that
> 2.4.18 worked, but I'm not sure. If you want me to try that nic under and
> older kernel let me know, however I think fixing the first bug is more
> important.) If you need any further log info let me know.

indeed there is a change in the irq handling in the yenta code.
it went in after 2.6.5-bk2 and is in 2.6.6-rc1.

in the context could you send please the ouput of a pre 
2.6.6-rc1 kernel on your box:
cat /proc/interrupts 

regarding your other pcmcia i don't know if it's supported.
thanks for your feedback.

--
maks

