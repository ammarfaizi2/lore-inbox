Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314458AbSELP4t>; Sun, 12 May 2002 11:56:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314546AbSELP4t>; Sun, 12 May 2002 11:56:49 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:39658 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S314458AbSELP4q>;
	Sun, 12 May 2002 11:56:46 -0400
Date: Sun, 12 May 2002 17:56:40 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200205121556.RAA02088@harpo.it.uu.se>
To: pkot@linuxnews.pl
Subject: Re: [2.4.18] preemptible patch causing freeze
Cc: linux-kernel@vger.kernel.org, rml@tech9.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 May 2002 16:29:11 +0200 (CEST), Pawel Kot wrote:
>I was attempting to get new ntfs driver to work with your preemptible
>patch in 2.4.18 kernel. I used 2.4.18 kernel with 2.4.18-4 preempt patch
>and with or w/o ntfs 2.0.7b patch. The result was every time the same.
>I use it on the Dell laptop with APM enabled (.config in the attachment)
>
>The problem is that when I unplug the power cable, the laptop freezes. It
>freezes totally, but not oops or other error is generated. The problem
>does not exist in 2.4.18 vanilla.
>...
># CONFIG_SMP is not set
>CONFIG_PREEMPT=y
>CONFIG_X86_UP_APIC=y
>CONFIG_X86_UP_IOAPIC=y

Are you sure you were using this exact .config without the
CONFIG_PREEMPT=y in 2.4.18 vanilla? The problem is that recent
Dell laptops with local APICs are known to have buggy BIOSen
that cause exactly the kinds of problems you described (hangs
at BIOS and power-management events).

2.4.19-pre8 has the necessary workarounds for Dell Inspiron
and Latitude laptops. Alternatively, rebuild your kernel with
SMP, UP_APIC, and UP_IOAPIC all disabled.

(If your Dell is old enough to not have a local APIC, then this
is not the problem and you can ignore this message.)

/Mikael
