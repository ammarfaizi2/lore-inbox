Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130085AbRAAXCo>; Mon, 1 Jan 2001 18:02:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130392AbRAAXCe>; Mon, 1 Jan 2001 18:02:34 -0500
Received: from [158.111.6.62] ([158.111.6.62]:269 "EHLO mcdc-us-smtp3.cdc.gov")
	by vger.kernel.org with ESMTP id <S130085AbRAAXCX>;
	Mon, 1 Jan 2001 18:02:23 -0500
Message-ID: <B7F9A3E3FDDDD11185510000F8BDBBF2049E7F7F@mcdc-atl-5.cdc.gov>
X-Sybari-Space: 00000000 00000000 00000000
From: Heitzso <xxh1@cdc.gov>
To: "'Johannes Erdfelt'" <johannes@erdfelt.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: usb broken in 2.4.0 prerelease versus 2.2.18
Date: Mon, 1 Jan 2001 17:31:34 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Johannes, I apologize for not getting back to you earlier.
Holidays, a changing kernel, and work, kept me away from
the test.

DATA: s10sh 0.1.9 is a program used to access the USB
bus to get to digital cameras and download pictures, etc.
I used it for quite awhile with 2.4.0 test up until
test 10(?) or so when it broke.  I then switched over to 
2.2.18 where s10sh works fine.  With the 2.4.0 
prerelease out I compiled the 2.4.0 prerelease kernel 
and tested and the 2.4.0 prerelease kernel still breaks 
s10sh though the same s10sh program works fine with 2.2.18.

I cannot say that 2.4.0 is broken because I don't know
if it is expected for a program like s10sh to break over
the kernel shift.  What was odd for me was that is worked
fine for quite awhile with 2.4.0 then snapped.

DEFINITION of SNAPPED: s10sh provides a command GETALL
to download all of the pictures in a camera's 'directory'.
Running GETALL under 2.4.0 now has the first picture file
being somewhat reasonably sized, the second being roughly
200M in size, then the next being almost a gig in size,
etc. until the parition I was in filled up and everything
stops.  I then rebooted to 2.2.18 and the same program
downloaded the pictures just fine.

If someone wants my .config files for 2.2.18 and 2.4.0
let me know with instructions for getting it to you
(i.e. attachments versus ...)  



Heitzso
xxh1@cdc.gov




-----Original Message-----
From: Johannes Erdfelt [mailto:johannes@erdfelt.com]
Sent: Monday, December 18, 2000 4:41 PM
To: Heitzso
Cc: 'linux-kernel@vger.kernel.org'
Subject: Re: usb broken in 2.4.0 test 12 versus 2.2.18


On Mon, Dec 18, 2000, Heitzso <xxh1@cdc.gov> wrote:
> I have a Canon usb camera that I access via a
> recent copy of the s10sh program (with -u option).
> 
> Getting to the camera via s10sh -u worked through 
> large sections of 2.4.0 test X but broke recently.  
> I cannot say for certain which test/patch the 
> break occurred in.
> 
> Running 2.4.0 test12 malloc errors appear.
> Everything is fine with 2.2.18.  I haven't tried
> the test13 series of patches.  
> 
> key .config options:
>  CONFIG_USB on
>  DEVICEFS on
>  HOTPLUG on
>  UHCI on
> everything else off (i.e. printers, keyboards,
> mice, etc.). 
> 
> Baseline system is RH6.2 with most patches applied
> (so avoiding RH7 compiler problems).  Basic dev
> environment is same (i.e. compiling the two kernels
> on the same box).

Could you give us the exact error message you saw?

JE
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
