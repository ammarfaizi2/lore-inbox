Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132292AbRBDUyd>; Sun, 4 Feb 2001 15:54:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132355AbRBDUyY>; Sun, 4 Feb 2001 15:54:24 -0500
Received: from unthought.net ([212.97.129.24]:43206 "HELO mail.unthought.net")
	by vger.kernel.org with SMTP id <S132292AbRBDUyL>;
	Sun, 4 Feb 2001 15:54:11 -0500
Date: Sun, 4 Feb 2001 21:54:09 +0100
From: Jakob Østergaard <jakob@unthought.net>
To: Jean-Eric Cuendet <Jean-Eric.Cuendet@linkvest.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'linux-raid@vger.rutgers.edu'" <linux-raid@vger.rutgers.edu>
Subject: Re: RAID autodetect and 2.4.1
Message-ID: <20010204215409.L22191@unthought.net>
Mail-Followup-To: Jakob Østergaard <jakob@unthought.net>,
	Jean-Eric Cuendet <Jean-Eric.Cuendet@linkvest.com>,
	"'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
	"'linux-raid@vger.rutgers.edu'" <linux-raid@vger.rutgers.edu>
In-Reply-To: <B45465FD9C23D21193E90000F8D0F3DF6838FD@mailsrv.linkvest.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2i
In-Reply-To: <B45465FD9C23D21193E90000F8D0F3DF6838FD@mailsrv.linkvest.ch>; from Jean-Eric.Cuendet@linkvest.com on Sun, Feb 04, 2001 at 12:28:30AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 04, 2001 at 12:28:30AM +0100, Jean-Eric Cuendet wrote:
> 
> Hi,
> I have a server with RAID1 partitions with linux 2.4.1 (stock,
> self-compiled) installed.
> It was easy to create the RAID partitions but when booting, no
> auto-detection is successful.
> The kernel says that autodetect is running, then done, but nothing is
> auto-detected.
> My devices are IDE devices (hda + hdc) and all drivers are bult-ins (no
> initrd nor modules).
> After the boot, making a raidstart works like a charm...
> Any advice?
> Help welcomed.

>From http://unthought.net/Software-RAID.HOWTO/Software-RAID.HOWTO-4.html#ss4.10

---------------------------------------------
4.10 Autodetection

Autodetection allows the RAID devices to be automatically recognized by the kernel at boot-time, right after the ordinary partition detection is done. 

This requires several things:
* You need autodetection support in the kernel. Check this
* You must have created the RAID devices using persistent-superblock
* The partition-types of the devices used in the RAID must be set to 0xFD (use fdisk and set the type to ``fd'')
---------------------------------------------

I guess you forgot to mark the partitions as type 0xfd.   I have a similar box
here with 2.4.1 and autodetect works like a charm.

Cheers,

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
