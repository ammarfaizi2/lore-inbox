Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272889AbRIGWws>; Fri, 7 Sep 2001 18:52:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272890AbRIGWwi>; Fri, 7 Sep 2001 18:52:38 -0400
Received: from mailout04.sul.t-online.com ([194.25.134.18]:9998 "EHLO
	mailout04.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S272889AbRIGWwX>; Fri, 7 Sep 2001 18:52:23 -0400
Message-ID: <3B994F74.F97196BC@t-online.de>
Date: Sat, 08 Sep 2001 00:51:32 +0200
From: SPATZ1@t-online.de (Frank Schneider)
X-Mailer: Mozilla 4.76 [de] (X11; U; Linux 2.4.3-test i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: AIC + RAID1 error? (was: Re: aic7xxx errors)
In-Reply-To: <200109072232.f87MWWY92133@aslan.scsiguy.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Justin T. Gibbs" schrieb:
> 
> >Okay, I had it again today:
> 
> You need to be running with aic7xxx=verbose for these messages to be
> useful.  In the 6.2.2 driver release I've turned these messages on
> by default.

Could you please shortly explain what this option does...(before it
fills my logfiles with notes "succesfully wrote 1 Byte to disk abc"..:-)
i had recently also some problems with aic7xxx, but they where due to a
misconfigured scsi-bus and perhaps a bad drive (is still under test), so
i enabled scsi error logging in the kernel (2.4.3, RH7.1) and by sending
the following strings to /proc/scsi/scsi:

/bin/echo "scsi log error 5" > /proc/scsi/scsi
/bin/echo "scsi log mlqueue 3" > /proc/scsi/scsi
/bin/echo "scsi log hlcomplete 1" > /proc/scsi/scsi
/bin/echo "scsi log scan 5" > /proc/scsi/scsi

But it did not give me that kind of info i wanted to see...does the
"aic7xxx=verbose" something similar or something completly different ?
 
> >Kernel was 2.4.9ac9 with (new) AIC driver 6.2.1, compiled with "Maximum
> >Number of TCQ Commands per Device" set to 64.
> 
> This is 8 times the tag load the old driver defaults to.

Thats true, and e.g., my relatively new IBM-drives (DGHS18V, 2x
DNES-309170W,  DDRS-39130W, all Server-disks according to IBM) can only
64...and the kernel complains, if i compile it with 255 and locks to
64...as i have played with this feature a while ago, i did not realize a
big performance-plus from 8 to 64, so i switched to 32...and i would go
down to <8 if i where in doubt....

> >So I compiled the same kernel with the old AIC driver and it works fine.

Test it longer and under load...i also "cured" a bad scsi-bus by
switching drivers one time...sometimes it really seems to work...for
some days...:-)
 
> Which may be due to a lighter load on the drive.  Its hard to say without
> the verbose messages and the full dmesg for the machine.  You're IBM drive
> may be running the "if I miss a seek, I fall off the bus" firmware where
> the bug is only triggered under high load.  Send the dmesg output and we'll
> see.

Solong...
Frank.

--
Frank Schneider, <SPATZ1@T-ONLINE.DE>.                           
Microsoft isn't the answer.
Microsoft is the question, and the answer is NO.
... -.-
