Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280641AbRKNPXU>; Wed, 14 Nov 2001 10:23:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280638AbRKNPXL>; Wed, 14 Nov 2001 10:23:11 -0500
Received: from sdsl-64-32-181-131.dsl.lax.megapath.net ([64.32.181.131]:7129
	"EHLO brigadier.ontimesupport.com") by vger.kernel.org with ESMTP
	id <S280634AbRKNPXB>; Wed, 14 Nov 2001 10:23:01 -0500
Message-Id: <5.1.0.14.0.20011114090926.00a87d88@127.0.0.1>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 14 Nov 2001 09:21:32 -0600
To: Alastair Stevens <alastair.stevens@mrc-bsu.cam.ac.uk>
From: Matthew Sell <msell@ontimesupport.com>
Subject: Re: Athlon SMP blues - kernels 2.4.[9 13 15-pre4]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.33.0111141421230.14971-100000@gurney>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Guys,


Just my $.02 worth on the dual Athlons...

We just finished putting together what was for us a pretty big box using 
the Tyan S2460 with 1.4GHz Athlons (not MP) and ran into some troublesome 
heating problems.

We had similar problems of hard lockups, usually soon after starting 
SETI@Home.....

We put some fans into the case to circulate air around the surface of the 
board, as well as additional fans on the front and back of the case for 
additional intake/exhaust.

On the S2460, the IC with the black heatsink was reaching 120 deg. F, at 
which point it promptly locked solid. We mounted a miniature fan directly 
on that heatsink, and with the additional circulation, we're keeping it to 
about 95 deg. F, which seems to keep it happy.

I agree with a previous post that cases today are pretty poorly designed 
with respects to air circulation. Of course, this was a server that we made 
using "department store"-style parts, and we expected to get what we paid 
for. It's been doing fine for the last several days with the case 
re-assembled and placed in the server rack with it's brothers.

Hope this helps a little. BTW: We are using the "Enterprise" SMP kernel 
supplied with RedHat 7.2.  It's not optimal for our arrangement, but it 
gets things going until I have a chance to get back to it to compile a 
custom kernel.


         - Matt




At 02:35 PM 11/14/2001 +0000, you wrote:
>Hi folks - I'm having real problems getting our new dual CPU server
>going. It's a 2x Athlon XP 1800+ on a Tyan mobo, AMD 760MP chipset, with
>an Adaptec SCSI controller and 512Mb DDR SDRAM. I'm not a Linux newbie
>at all, but I've never tried running it on such exotic hardware before,
>and it doesn't seem happy....
>
>I installed Red Hat 7.2 and the machine boots fine, using SMP or UP
>kernels (Red Hat 2.4.9-7), but totally HANGS at the login prompt. Can't
>type, can't reboot, can't do anything. Single user mode _does_ let me
>in, however, and this is the only progress so far.
>
>I then tried building a custom 2.4.15-pre4 (on another machine), which
>compiled perfectly happily, and I installed this on the server. It
>panic'd due to failure to mount the root filesystem. I made an
>initrd.img, and it then got further (detecting and initialising the SCSI
>controller), but still panic'd with the same message.
>
>I then threw down the gauntlet and installed the rawhide Athlon
>SMP kernel (based on 2.4.13) which also booted fine but HUNG at the
>login prompt, as above. Finally, I tried the i686 version, which spewed
>out tons of error messages regarding "invalid symbols" in the ext3
>module.
>
>Either way, I'm stumped. Am I up against an Athlon / chipset problem
>here, or is something else wrong? What do I need to do to get my
>custom-built 2.4.15-pre4 rolling - why can't it mount the root
>partition?
>
>Cheers
>Alastair
>
>_____________________________________________
>Alastair Stevens
>MRC Biostatistics Unit
>Cambridge UK
>---------------------------------------------
>phone - 01223 330383
>email - alastair.stevens@mrc-bsu.cam.ac.uk
>web - www.mrc-bsu.cam.ac.uk
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/



Matthew Sell
Programmer
On Time Support, Inc.
www.ontimesupport.com
(281) 296-6066

Join the Metrology Software discussion group METLIST!
http://www.ontimesupport.com/cgi-bin/mojo/mojo.cgi


"One World, One Web, One Program" - Microsoft Promotional Ad
"Ein Volk, Ein Reich, Ein Fuhrer" - Adolf Hitler

Many thanks for this tagline to a fellow RGVAC'er...

