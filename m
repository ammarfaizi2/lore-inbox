Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131459AbRDBX3B>; Mon, 2 Apr 2001 19:29:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131478AbRDBX2w>; Mon, 2 Apr 2001 19:28:52 -0400
Received: from www.resilience.com ([209.245.157.1]:29427 "EHLO
	www.resilience.com") by vger.kernel.org with ESMTP
	id <S131586AbRDBX2p>; Mon, 2 Apr 2001 19:28:45 -0400
Message-ID: <3AC8FDD8.4116E97@resilience.com>
Date: Mon, 02 Apr 2001 15:31:52 -0700
From: Jeff Golds <jgolds@resilience.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Pete Zaitcev <zaitcev@redhat.com>
CC: Ketil Froyn <ketil@froyn.com>, linux-kernel@vger.kernel.org
Subject: Re: oops in uhci.c running 2.4.2-ac28
In-Reply-To: <Pine.LNX.4.30.0104010313440.1135-100000@ns.froyn.org> <20010402185526.A4083@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pete Zaitcev wrote:
> 
> > Date:         Sun, 1 Apr 2001 03:35:03 +0200 (CEST)
> > From: Ketil Froyn <ketil@froyn.com>
> > To: <linux-kernel@vger.kernel.org>
> 
> > While running kernel 2.4.2-ac28, I switched on spinlock debugging and
> > verbose BUG() reporting (I always use sysrq). Anyway, while running this I
> > got an oops after about 2 or 3 minutes running, several times, exact same
> > place each time, which I traced back to rh_int_timer_do().
> > This was in uhci.c (I used CONFIG_USB_UHCI_ALT).  [...]  I
> > recompiled with usb-uhci.c instead (CONFIG_USB_UHCI), and now I don't get
> > the oops any more.
> 
> I am behind usb-uhci for a reason. Alan bounced your report
> to me but I do not see a case for action...
> 
> -- Pete
> -

Let me show what I got with the 2.4.2 kernel with USB support enabled.

Mar 19 14:10:00 Eng99 kernel: uhci: host controller halted. very bad
Mar 19 14:10:31 Eng99 last message repeated 108 times
Mar 19 14:11:37 Eng99 last message repeated 93 times
Mar 19 14:12:39 Eng99 last message repeated 87 times
Mar 19 14:13:40 Eng99 last message repeated 20 times
Mar 19 14:14:45 Eng99 last message repeated 42 times
Mar 19 14:15:46 Eng99 last message repeated 47 times
Mar 19 14:16:47 Eng99 last message repeated 127 times
Mar 19 14:17:50 Eng99 last message repeated 7074 times
Mar 19 14:18:51 Eng99 last message repeated 3342 times
Mar 19 14:19:52 Eng99 last message repeated 10948 times
Mar 19 14:20:00 Eng99 last message repeated 15
times                                                                    

This happens after simply fiddling around with ethernet settings (it's a
PCI ethernet card).  In fact, my syslog is FULL of these messages... my
syslog was 3x larger than usual.  The console is just about unusable
because of all the spam.

Something seems terribly wrong with the uhci driver... I've disabled it
on my system and it's fine now (I don't need USB).

My system:
Slot 1 P3-850
VIA chipset MB (not sure of exact chipset, can find out if needed)

-Jeff

-- 
Jeff Golds
jgolds@resilience.com
