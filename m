Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270678AbTGUSBw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 14:01:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270654AbTGUSBv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 14:01:51 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:19855 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S270632AbTGURzk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 13:55:40 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: nick black <dank@suburbanjihad.net>
Date: Mon, 21 Jul 2003 20:10:22 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: 2.6.0-test1 + matroxfb = unuusable VC
Cc: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <7E154527EED@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 21 Jul 03 at 17:45, nick black wrote:

> i'm seeing the exact same issues.  i use to see similar problems in late
> 2.4's with agp turned on, where turning off agp sorted out the issue.
> using 2.6 (test1-ac2), it happens whether agp is turned on or not.

I do not think that it has anything to do with AGP, as matroxfb does not
initiate any AGP transfers. 
 
> some info:  (cmdline, dmesg, config, lspci -v -v for bridge/card):
> 
> video=matroxfb:vesa:0x1bb

I think that you are using fbset somewhere in your initscripts. Either
do not do that, or apply 
ftp://platan.vc.cvut.cz/pub/linux/matrox-latest/matroxfb-2.5.72.gz.

> PCI: No IRQ known for interrupt pin A of device 01:00.0. Please try 
>     using pci=biosirq.

And reconfigure your system to assign IRQ to the AGP devices too.
matroxfb uses it for delivering some notifications to the userspace
programs...

>         Interrupt: pin A routed to IRQ 0

... if it hooked IRQ0 as MGA interrupt, anything can happen.
                                                Best regards,
                                                    Petr Vandrovec
                                                    vandrove@vc.cvut.cz

