Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131508AbRDBXwB>; Mon, 2 Apr 2001 19:52:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131562AbRDBXvw>; Mon, 2 Apr 2001 19:51:52 -0400
Received: from quattro.sventech.com ([205.252.248.110]:15109 "HELO
	quattro.sventech.com") by vger.kernel.org with SMTP
	id <S131508AbRDBXvj>; Mon, 2 Apr 2001 19:51:39 -0400
Date: Mon, 2 Apr 2001 19:50:48 -0400
From: Johannes Erdfelt <johannes@erdfelt.com>
To: Jeff Golds <jgolds@resilience.com>
Cc: Pete Zaitcev <zaitcev@redhat.com>, Ketil Froyn <ketil@froyn.com>,
   linux-kernel@vger.kernel.org
Subject: Re: oops in uhci.c running 2.4.2-ac28
Message-ID: <20010402195048.H17651@sventech.com>
In-Reply-To: <Pine.LNX.4.30.0104010313440.1135-100000@ns.froyn.org> <20010402185526.A4083@devserv.devel.redhat.com> <3AC8FDD8.4116E97@resilience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4i
In-Reply-To: <3AC8FDD8.4116E97@resilience.com>; from Jeff Golds on Mon, Apr 02, 2001 at 03:31:52PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 02, 2001, Jeff Golds <jgolds@resilience.com> wrote:
> Let me show what I got with the 2.4.2 kernel with USB support enabled.
> 
> Mar 19 14:10:00 Eng99 kernel: uhci: host controller halted. very bad
> Mar 19 14:10:31 Eng99 last message repeated 108 times
> Mar 19 14:11:37 Eng99 last message repeated 93 times
> Mar 19 14:12:39 Eng99 last message repeated 87 times
> Mar 19 14:13:40 Eng99 last message repeated 20 times
> Mar 19 14:14:45 Eng99 last message repeated 42 times
> Mar 19 14:15:46 Eng99 last message repeated 47 times
> Mar 19 14:16:47 Eng99 last message repeated 127 times
> Mar 19 14:17:50 Eng99 last message repeated 7074 times
> Mar 19 14:18:51 Eng99 last message repeated 3342 times
> Mar 19 14:19:52 Eng99 last message repeated 10948 times
> Mar 19 14:20:00 Eng99 last message repeated 15
> times                                                                    
> 
> This happens after simply fiddling around with ethernet settings (it's a
> PCI ethernet card).  In fact, my syslog is FULL of these messages... my
> syslog was 3x larger than usual.  The console is just about unusable
> because of all the spam.
> 
> Something seems terribly wrong with the uhci driver... I've disabled it
> on my system and it's fine now (I don't need USB).

Do you get the same messages with the usb-uhci driver?

> My system:
> Slot 1 P3-850
> VIA chipset MB (not sure of exact chipset, can find out if needed)

Some of the VIA chipsets have port aliasing problems supposedely. This
may cause your controller to go insane like you've described.

JE

