Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262070AbUCQV1K (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 16:27:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262085AbUCQV1K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 16:27:10 -0500
Received: from mailgate5.cinetic.de ([217.72.192.165]:34737 "EHLO
	mailgate5.cinetic.de") by vger.kernel.org with ESMTP
	id S262070AbUCQV1H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 16:27:07 -0500
Date: Wed, 17 Mar 2004 22:26:53 +0100
Message-Id: <200403172126.i2HLQrQ09487@mailgate5.cinetic.de>
MIME-Version: 1.0
From: "Thomas Schlichter" <thomas.schlichter@web.de>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: "AndrewMorton" <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: idle Athlon with IOAPIC is 10C warmer since 2.6.3-bk1
Organization: http://freemail.web.de/
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Maciej W. Rozycki" <macro@ds2.pg.gda.pl> wrote:
> On Wed, 3 Mar 2004, Thomas Schlichter wrote:
> 
> > a few days ago I noticed that my Athlon 3000+ was relatively hot (49C) 
> > although it was completely idle. At that time I was running 2.6.3-mm3 with 
> > ACPI and IOAPIC-support enabled.
> > 
> > As I tried 2.6.3, the idle temperature was at normal 39C. So I did do some 
> > binary search with the -bk patches and found the patch that causes the high 
> > idle temperature. It is ChangeSet@1.1626 aka 8259-timer-ack-fix.patch.
> 
> Interesting -- the patch removes a pair of unnecessary for your
> configuration PIC accesses when using an I/O APIC NMI watchdog. You have 
> the NMI watchdog enabled, don't you?

No, I don't use the NMI watchdog...
So the optimization of removing these I/O accesses is bogus for my configuration. Btw. I don't know if I already mentioned it, but I use the VIA KT400 chipset. Maybe this is of interest...

The only way to cool down my CPU was to enable timer_ack.
I don't know how to help you, but of course I am willing to test patches... ;-)

   Thomas

