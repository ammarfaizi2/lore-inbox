Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267201AbUBRWYS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 17:24:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267193AbUBRWYS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 17:24:18 -0500
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:57353 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S268283AbUBRWYL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 17:24:11 -0500
From: Vlasenko Denis <vda@port.imtp.ilyichevsk.odessa.ua>
To: Carl Thompson <cet@carlthompson.net>, Pavel Machek <pavel@suse.cz>
Subject: Re: hard lock using combination of devices
Date: Thu, 19 Feb 2004 00:13:55 +0200
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <20040216214111.jxqg4owg44wwwc84@carlthompson.net> <20040217223319.GB666@elf.ucw.cz> <20040217163228.qz5ogcw4ggc0w8cg@carlthompson.net>
In-Reply-To: <20040217163228.qz5ogcw4ggc0w8cg@carlthompson.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402190013.55033.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 18 February 2004 02:32, Carl Thompson wrote:
> At the moment I am.  But I also tried native Linux drivers too with the
> same result.  I've tried Windows drivers under DriverLoader and ndiswrapper
> as well as the native Aetheros driver, the native ADMTek driver and another
> native driver the name of which escapes me right now.  It's definitely not
> a driver problem because I've tried several with the same results.
>
> BTW, Driverloader is actually a very slick package.  For 802.11a/g parts,
> it definitely seems to be the way to go if stability is an issue.  While it
> is a commercial product it's worth the $20US if you use high-speed wireless
> cards. Ndiswrapper is also nice but it is not as complete as DriverLoader
> currently and does not work with many cards.  As for the Windows NDIS
> drivers that are run with them, they actually tend to be very stable and I
> have no problem with running them from a "purity" standpoint.  I believe in
> doing what works, and right now nothing is working with Linux.

How can Linux folks fix bugs if kernel contains a binary-only part?

> >>   1:      26061          XT-PIC  i8042
> >>   2:          0          XT-PIC  cascade
> >>   8:          1          XT-PIC  rtc
> >>   9:       2020          XT-PIC  acpi
> >>  10:    2187181          XT-PIC  yenta, driverloader
> >>  11:        111          XT-PIC  ALI 5451
> >>  12:    2399118          XT-PIC  i8042
> >>  14:     169829          XT-PIC  ide0
> >>  15:          1          XT-PIC  ide1
> >> NMI:          0
> >> LOC:   41036749 
> >> ERR:     275764

You seem to have lots of ERRs too, ~1 each 2 secs.
That's bad, maybe flakey interrupt controller?
BIOS writers paying dirty with SMM?
I had such problems with 11g card and 'latest' BIOS for
my old mainboard. Older BIOS was ok.
--
vda

