Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129387AbRAERmT>; Fri, 5 Jan 2001 12:42:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129593AbRAERmK>; Fri, 5 Jan 2001 12:42:10 -0500
Received: from [158.111.6.80] ([158.111.6.80]:47112 "EHLO
	mcdc-us-smtp4.cdc.gov") by vger.kernel.org with ESMTP
	id <S129387AbRAERl5>; Fri, 5 Jan 2001 12:41:57 -0500
Message-ID: <B7F9A3E3FDDDD11185510000F8BDBBF2049E7F99@mcdc-atl-5.cdc.gov>
X-Sybari-Space: 00000000 00000000 00000000
From: Heitzso <xxh1@cdc.gov>
To: "'antirez@invece.org'" <antirez@invece.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'Johannes Erdfelt'" <johannes@erdfelt.com>
Subject: USB broken in 2.4.0
Date: Fri, 5 Jan 2001 12:38:25 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just tested with fresh-out-of-the-box
2.4.0 and using the newer libusb 0.1.2 
as suggested by antirez  (see email chain
below for more info).  I compiled libusb
and s10sh code this AM under 2.4.0. 

It blows up BAD by finding increasingly
larger photo images in the camera over
the usb link and extracting them to disk.
So by the third file you're trying to
extract gig sized files.  Obviously the
filesystem files up, the sytem chokes, etc.

This is the same code that works fine
under 2.2.18 kernel (I use it all of the
time there).


Heitzso

-----Original Message-----
From: antirez [mailto:antirez@invece.org]
Sent: Wednesday, January 03, 2001 6:00 PM
To: Heitzso
Cc: 'Johannes Erdfelt'; 'antirez@invece.org'
Subject: Re: usb broken in 2.4.0 prerelease versus 2.2.18


On Wed, Jan 03, 2001 at 12:33:34PM -0500, Heitzso wrote:

Hi Heitzso!

> (Salvatore Sanfilippo ... I'm cc'ing you
> to note that s10sh -u (usb mode) works fine
> with 2.2.18 but is breaking under 2.4.0 prerelease.

Too bad. The problem can't be of s10sh itself I guess.
It's more likely that some USB userspace ioctl() changed
so the USB subsystem isn't access without problems,
even if it's possible that some s10sh bug grow up
with a more robust USB implementation in 2.4.0.
I tested s10sh in 2.4.0-testxxx and it worked:
I suggest to try the new libusb 0.1.2 at
http://sourceforge.net/project/showfiles.php?group_id=1674&release_id=13538
and try to make s10sh working with this updated library.
I'll try. If you is able to fix s10sh or to make it working
using modified libusb version please drop me a mail!

thanks for your effort,
regars,
antirez

-- 
Salvatore Sanfilippo              |
<antirez@invece.org>
http://www.kyuzz.org/antirez      |      PGP: finger
antirez@tella.alicom.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
