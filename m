Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030407AbVLGWuX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030407AbVLGWuX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 17:50:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030409AbVLGWuX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 17:50:23 -0500
Received: from vms044pub.verizon.net ([206.46.252.44]:25334 "EHLO
	vms044pub.verizon.net") by vger.kernel.org with ESMTP
	id S1030407AbVLGWuW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 17:50:22 -0500
Date: Wed, 07 Dec 2005 17:50:20 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: ntp problems
In-reply-to: <43975A96.9090503@eclis.ch>
To: linux-kernel@vger.kernel.org
Message-id: <200512071750.20709.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 8BIT
Content-disposition: inline
References: <200512050031.39438.gene.heskett@verizon.net>
 <200512070108.58466.gene.heskett@verizon.net> <43975A96.9090503@eclis.ch>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 07 December 2005 16:56, Jean-Christian de Rivaz wrote:
>Gene Heskett a écrit :
>> And, acpi is on, and ntpd is happy with the new bios.  Hurrah!
>
>Good news!
>
>I wonder if it would be a good idea to add something into the kernel or
>into ntpd to alert the users that ntpd can't run normaly because of a
>too fast drift ? Then a BIOS upgrade could be proposed (especially on a
>nForce2 system). I don't know if it's even realistc.
>
>Regards,

The drift itself wasn't what I'd call excessive, 
something like 6 minutes in a week, which for 
mainboard quality crystals is pretty darned good.

I didn't discover it wasn't working till my watch beeped 
at me on the hour like it always does (casio) and I glanced 
at the cornerclock to see it said it was 6 minutes & some 
after the hour.  So either my watch was funkity, or the ntpd.
My watch has been *very* reliable, staying within 10 seconds 
a month, so I discounted that theory and went after ntpd.

After my experience, I'd recommend any nforce2 board get 
the latest bios and install it.  On this biostar though, 
I then had to go into the expert mode on the 3rd screen 
and play for a while till I had restored the DDR to 333 mhz, 
the defaults want to run it at 400 mhz, and an XP2800 
athlon will only stay up 10 minutes or so at 40, as its 
only rated at 333.  The faster athlons, Xp3200+ chips, 
are rated for 400 though.

But in my case, I think that was the only 'gotcha', and 
everything else seems to be as happy as that infamous pig 
in you know what.

When its running, drift file contents have not to my knowledge ever 
exceeded 6.000, and are currently running like this:
drift=4.236
     remote           refid      st t when poll reach   delay   offset  jitter
==============================================================================
+ns2.pulsation.f 129.240.64.3     3 u  232 1024  377  132.270    1.516   1.117
+ntp.aramiska.ne 172.16.33.1      2 u  333 1024  377  123.445    3.725   0.704
*ftp.cerias.purd 128.10.252.7     2 u 1370 1024  376   73.101    0.532   5.700
 LOCAL(0)        LOCAL(0)        10 l    6   64  377    0.000    0.000   0.001
drift=4.236

I have a while true script logging the drift and the output of 
ntpq -p into /var/log/ntp.log every half hour temporarily.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.36% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
