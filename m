Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315192AbSELQZy>; Sun, 12 May 2002 12:25:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315235AbSELQZx>; Sun, 12 May 2002 12:25:53 -0400
Received: from urtica.linuxnews.pl ([217.67.200.130]:20230 "EHLO
	urtica.linuxnews.pl") by vger.kernel.org with ESMTP
	id <S315192AbSELQZw>; Sun, 12 May 2002 12:25:52 -0400
Date: Sun, 12 May 2002 18:24:13 +0200 (CEST)
From: Pawel Kot <pkot@linuxnews.pl>
To: Mikael Pettersson <mikpe@csd.uu.se>
cc: <linux-kernel@vger.kernel.org>, <rml@tech9.net>
Subject: Re: [2.4.18] preemptible patch causing freeze
In-Reply-To: <200205121556.RAA02088@harpo.it.uu.se>
Message-ID: <Pine.LNX.4.33.0205121811580.493-100000@urtica.linuxnews.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 May 2002, Mikael Pettersson wrote:

> On Sun, 12 May 2002 16:29:11 +0200 (CEST), Pawel Kot wrote:
> >I was attempting to get new ntfs driver to work with your preemptible
> >patch in 2.4.18 kernel. I used 2.4.18 kernel with 2.4.18-4 preempt patch
> >and with or w/o ntfs 2.0.7b patch. The result was every time the same.
> >I use it on the Dell laptop with APM enabled (.config in the attachment)
> >
> >The problem is that when I unplug the power cable, the laptop freezes. It
> >freezes totally, but not oops or other error is generated. The problem
> >does not exist in 2.4.18 vanilla.
> >...
> ># CONFIG_SMP is not set
> >CONFIG_PREEMPT=y
> >CONFIG_X86_UP_APIC=y
> >CONFIG_X86_UP_IOAPIC=y
>
> Are you sure you were using this exact .config without the
> CONFIG_PREEMPT=y in 2.4.18 vanilla? The problem is that recent
> Dell laptops with local APICs are known to have buggy BIOSen
> that cause exactly the kinds of problems you described (hangs
> at BIOS and power-management events).

I'm sure. I did:
$ cp $oldlinux/.config $preemptlinux/
$ make menuconfig
[enable preemption]
I can recompile the kernel to make sure though.

> 2.4.19-pre8 has the necessary workarounds for Dell Inspiron
> and Latitude laptops. Alternatively, rebuild your kernel with
> SMP, UP_APIC, and UP_IOAPIC all disabled.
>
> (If your Dell is old enough to not have a local APIC, then this
> is not the problem and you can ignore this message.)

It is Dell Latitice c610. I'll try to disable APIC then.

thanks for the answer,
pkot
-- 
mailto:pkot@linuxnews.pl :: mailto:pkot@slackware.pl
http://kt.linuxnews.pl/ :: Kernel Traffic po polsku

