Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275909AbTHOLjn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 07:39:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275910AbTHOLjn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 07:39:43 -0400
Received: from [66.98.134.43] ([66.98.134.43]:13448 "EHLO shitake.truemesh.com")
	by vger.kernel.org with ESMTP id S275909AbTHOLjm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 07:39:42 -0400
Date: Fri, 15 Aug 2003 12:39:41 +0100
From: Paul Nasrat <pauln@truemesh.com>
To: Milan Roubal <roubm9am@barbora.ms.mff.cuni.cz>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0test3mm2 - Synaptics touchpad problem
Message-ID: <20030815113940.GR13037@shitake.truemesh.com>
Mail-Followup-To: Paul Nasrat <pauln@truemesh.com>,
	Milan Roubal <roubm9am@barbora.ms.mff.cuni.cz>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <003701c3630f$387a6330$401a71c3@izidor> <20030815103529.GQ13037@shitake.truemesh.com> <00a501c3631c$676237b0$401a71c3@izidor>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00a501c3631c$676237b0$401a71c3@izidor>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 15, 2003 at 01:00:09PM +0200, Milan Roubal wrote:
> Hi,
> I am using the new drivers for XFree86 and if the touchpad is visible

Apologies I misread your bug report.  Maybe this will be of more help.

> in dmesg, than it is working in XFree86 too. When it isn't,
> it isn't than listed in /proc/bus/input/devices and is not working in
> XFree86.

That does seem odd, I haven't noticed this with vanilla 2.6.0test3
(linux only, but a reboot linux->linux would exhibit that).

I note on the non synaptics boot you have this instead of the synaptics.

serio: i8042 AUX3 port at 0x60,0x64 irq 12

It may be worth #define DEBUG in i8042.c, to see the differences between
the two boot sequences in more detail.

You might want to try against 2.6.0-test3, if it works for you
then it might be worth going through the synaptics patches in mm2 one by
one :( 

http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test3/2.6.0-test3-mm2/broken-out/

http://w1.894.telia.com/~u89404340/patches/touchpad/2.6.0-test2/v1/Readme.txt

I'll see if I can replicate this with my laptop this evening.
 
Paul
