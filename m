Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751242AbVJSTdB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751242AbVJSTdB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 15:33:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751244AbVJSTdB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 15:33:01 -0400
Received: from khc.piap.pl ([195.187.100.11]:34052 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S1751242AbVJSTdA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 15:33:00 -0400
To: Rudolf Polzer <debian-ne@durchnull.de>
Cc: Horms <horms@verge.net.au>, linux-kernel@vger.kernel.org,
       334113@bugs.debian.org, Alastair McKinstry <mckinstry@debian.org>,
       security@kernel.org, team@security.debian.org,
       secure-testing-team@lists.alioth.debian.org
Subject: Re: kernel allows loadkeys to be used by any user, allowing for
 local root compromise
References: <E1EQofT-0001WP-00@master.debian.org>
	<20051018044146.GF23462@verge.net.au>
	<m37jcakhsm.fsf@defiant.localdomain>
	<20051018171645.GA59028%atfield-dt@durchnull.de>
	<m3fyqyhdm8.fsf@defiant.localdomain>
	<20051018204919.GA21286%atfield-dt@durchnull.de>
	<m3oe5l21rr.fsf@defiant.localdomain>
	<20051019132326.GA31526%atfield-dt@durchnull.de>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Wed, 19 Oct 2005 21:32:53 +0200
In-Reply-To: <20051019132326.GA31526%atfield-dt@durchnull.de> (Rudolf
 Polzer's message of "Wed, 19 Oct 2005 15:23:26 +0200")
Message-ID: <m3y84pjo9m.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rudolf Polzer <debian-ne@durchnull.de> writes:

>> Ok. So they are exposed to known attacks with quite high probability.
>
> Which others? Are there other places that assume only trusted users can
> access
> the console?

Probably: BIOS booting, messing with computer cases (are the computers
in locked room and only kbds/monitors/mouses are accessible?), sniffing
keyboard cables (all other passwords if not root's), physical damage
to the computer hardware (some kind of DoS).

Still, may be adequate for student room.

>> I assume that one can notice that Ctrl-Alt-Backspace doesn't work,
>> and stop there.
>
> Not if a malicious X program does "chvt 1; chvt 7" when Ctrl-Alt-Backspace is
> pressed.

With correct timing, possibly. Depends on how the graphics driver starts
and switches from text mode. There might be noticeable differences.

> It would require a video driver that can actually reset the video mode.
> Framebuffer drivers usually can do that. For the standard VGA text mode, at
> least savetextmode/restoretextmode from svgalib don't work on the graphics
> cards I have.

I think Xserver could terminate gracefully. But it would require changes
to kernel SAK handling I think - not sure if it's worth it, given other
threats.

Another idea: if the machines are ACPI-enabled and have "soft-power"
buttons, one can make use of acpid.
-- 
Krzysztof Halasa
