Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314035AbSDVCpN>; Sun, 21 Apr 2002 22:45:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314037AbSDVCpM>; Sun, 21 Apr 2002 22:45:12 -0400
Received: from mta5.snfc21.pbi.net ([206.13.28.241]:39908 "EHLO
	mta5.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S314035AbSDVCpL>; Sun, 21 Apr 2002 22:45:11 -0400
Date: Sun, 21 Apr 2002 19:43:10 -0700
From: David Brownell <david-b@pacbell.net>
Subject: Re: 2.4.19pre2++ USB EHCI-HCD -> auto-reboot
To: Kris Karas <ktk@enterprise.bidmc.harvard.edu>
Cc: linux-usb-devel@lists.sourceforge.net, lkml <linux-kernel@vger.kernel.org>
Message-id: <109b01c1e9a7$71ada460$6800000a@brownell.org>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
X-Priority: 3
X-MSMail-priority: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I need some tips on how to debug (or help others debug) a problem
> I am seeing with the EHCI-HCD driver introduced in 2.4.19-pre2.

Hmm ... that "auto-reboot" has to stop before you can get
much of anywhere!  I've not seen that kind of failure since
ehci-hcd was first starting to enumerate devices.

I'd hope that running against 2.5.8 (which has a somewhat
more current EHCI driver in any case), with lots of kernel
debugging features (notably slab debugging, which also
poisons the pci_pool memory used by the USB HCDs),
would give you a more friendly failure mode.  Basically
the same stuff exists on 2.4.19-pre, but you will need
to tweak the PCIPOOL_DEBUG stuff in drivers/pci/pci.c
to make the extra poisoning happen.  KDB can help too.

Once a few more tidbits of info become available, I can
help figure out what's up.  (To be honest, it's been quite a
while since anyone has reported anything but success with
ehci-hcd.  Some variety is perversely refreshing ... :)

- Dave



