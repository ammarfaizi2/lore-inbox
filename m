Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271265AbTGPXie (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 19:38:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271260AbTGPXie
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 19:38:34 -0400
Received: from mcmmta2.mediacapital.pt ([193.126.240.147]:1963 "EHLO
	mcmmta2.mediacapital.pt") by vger.kernel.org with ESMTP
	id S271354AbTGPXiW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 19:38:22 -0400
Date: Thu, 17 Jul 2003 00:52:43 +0100
From: "Paulo Andre'" <fscked@netvisao.pt>
Subject: Re: 2.6.0-test1 test results (radeonfb and ACPI on thinkpad A30)
In-reply-to: <3F13ED8A.9000809@rozeta.com.pl>
To: "=?ISO-8859-1?Q? Pawe=B3?= T. Jochym" <jochym@rozeta.com.pl>
Cc: linux-kernel@vger.kernel.org
Message-id: <20030717005243.2bde3b04.fscked@netvisao.pt>
Organization: Transatlantic Inc.
MIME-version: 1.0
X-Mailer: Sylpheed version 0.9.0claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8BIT
References: <3F13ED8A.9000809@rozeta.com.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jul 2003 14:03:22 +0200
Pawe³ T. Jochym wrote:

> Here is a report on my tests of 2.6.0-test1 on ThinkPad A30:
> 
> (preempt kernel with quite standard config - I'll post config on
> request)
> 
> - RadeonFB - sort-of works (it was working fine in 2.4.21). It boots, 
> detects panel size correctly (1400x1050), switches to fbconsole of 
> proper size but the screen is garbage: the contents of each line seams
> to be shifted by some 8-32 pixels (its difficult to tell exactly how 
> much). I was able to reset it to proper geometry by "fbset
> 1600x1200-60" command (notice the geometry!) and after that it reports
> virtual resolution 1600x1200 and visable resolution of 1400x1050 and
> works fine.

It also happens here. I've noticed this behaviour since early 2.5 or so.

> - ACPI - I was unable to boot with ACPI turned on. It simply hangs at
> very early stage (shows nothing on the console). Notice that this is 
> upgraded BIOS/EC machine with corrected ACPI tables - 2.4.21-ac4 with 
> ACPI works fine. Any sugestions?

This is what's been bugging me the most. I suppose you are experiencing
a persistent oops early at boot time and it happens exactly the same way
here. The last kernel that worked fine for me wrt ACPI was 2.5.69 and I
think that something on the acpi-20030619 patch broke it (which
unfortunately the latest acpi update [acpi-20030714] didn't fix). I
haven't narrowed it down to a specific kernel but will do soon and will
report back on it.

Could you please pass your oops through ksymoops and post the output?
I'd do it myself but right now I lack the hardware to do so.

> - Other - i've noticed too fast playback in mplayer (by some 10-20%)
> and jumping sound/video in xine.

I didn't notice any of this, even if I didn't make intensive use of it
with this kernel yet.

> - We will need to put some more documentation on setting this kernel
> up for newbies (I know - later).
> 
> The rest is working fine as far as I can tell.

Same here. Exactly the two major problems you describe are the very
things that bug me aswell.

Btw, for me it doesn't happen on a thinkpad, it's a Fujitsu Siemens
E7110.


		Paulo
