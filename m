Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262571AbVCJMoN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262571AbVCJMoN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 07:44:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262578AbVCJMoN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 07:44:13 -0500
Received: from vms044pub.verizon.net ([206.46.252.44]:25258 "EHLO
	vms044pub.verizon.net") by vger.kernel.org with ESMTP
	id S262571AbVCJMnq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 07:43:46 -0500
Date: Thu, 10 Mar 2005 07:43:43 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: 2.6.11-mm2 vs audio for kino and tvtime
In-reply-to: <XO42l8mC.1110444770.5508140.khali@localhost>
To: linux-kernel@vger.kernel.org
Cc: "Jean Delvare" <khali@linux-fr.org>, "Andrew Morton" <akpm@osdl.org>,
       linux1394-devel@lists.sourceforge.net, video4linux-list@redhat.com,
       sensors@stimpy.netroedge.com
Reply-to: gene.heskett@verizon.net
Message-id: <200503100743.44283.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <XO42l8mC.1110444770.5508140.khali@localhost>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 10 March 2005 03:52, Jean Delvare wrote:
>Hi Gene,
>
>> > I've dropped the "id" member of struct i2c_client, as it were
>> > useless. Third-party driver authors now need to do the same.
>>
>> Aha!  As in just 'dd' any line containing the .id in vim?
>
>Exactly. Don't kill all lines with .id though, only the i2c_client
> id was dropped, and there are plenty of other ids in the
> media/video drivers.

I found the patch location, it was off by about -30 lines after the 
other patches, and applied them.  It builds now, but still doesn't 
work, very slow screen updates and no video in tvtime.  It works 
properly with 2.6.11, 2.6.11.1, and 2.6.11.2.  As I didn't have the 
card until 2.6.11 was out, I should back up to the last rc4-RT, and 
see if this card will work with that. At least that will narrow the 
guilty patchset down a wee bit.  I'll try that later today if the 
honeydo's don't get in the way.

I noted last night too, that while my scanner worked, it was gawdawful 
slow at retrieving the data over the usb when running at a measly 
300dpi, 3 to 4 minutes for an 8.5x11, 23 MB of data (according to 
xsane) scan.  IIRC Its been only 45-50 seconds in past times.  So 
that may indicate a usb slowdown too, in the read path only.  The usb 
printer in 1440x1440 color was about its usual speed, needing a 
surveyer to measure page ejection progress. :)

That printer does very very nice indeed color work, but in those 
modes, theres no way to convince the frogs that an Epson C82 is 
faster than watching paint dry.  10 to 20 minutes a page depending on 
content.

OTOH, my output, after tweaking a few things, was a hell of a lot more 
brilliant than the page I scanned in!  (Plus the award recipients 
name is now spelled correctly, the reason for that little 3 hour 
exersize, ain't the gimp wunnerful?)

>> > THRM is most likely a temperature you get from
>> > /proc/acpi/thermal_zone, and isn't related with the w83627hf
>> > driver.
>>
>> Humm, it is the highest temp reported, as is temp2 in gkrellm, so
>> I had assumed it was somehow a dup of the diode in the cpu, or of
>> the thermistor against the bottom of it inside the socket.  Wrong
>> assumption?
>
>Not necessarily wrong. It is possible that the same diode
> temperature is read from the W83627HF chip by both the ACPI
> subsystem and by the w83627hf driver. But if this is the case, I
> would be worried by concurrent I/O accesses to the chip, which
> could possibly cause trouble.

I don't believe I'm seeing any evidence of that here.  OTOH, I don't 
run sensors very often when gkrellm is running.  Or are there other 
processes accessing through that bus that wouldn't play well?

>--
>Jean Delvare
>-
>To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.34% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
