Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130952AbRCGK3J>; Wed, 7 Mar 2001 05:29:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130921AbRCGK3A>; Wed, 7 Mar 2001 05:29:00 -0500
Received: from ausmtp01.au.ibm.COM ([202.135.136.97]:15889 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP
	id <S130824AbRCGK2R>; Wed, 7 Mar 2001 05:28:17 -0500
From: mshiju@in.ibm.com
X-Lotus-FromDomain: IBMIN@IBMAU
To: Jeremy Jackson <jerj@coplanar.net>
cc: linux-kernel@vger.kernel.org, linux-mca@vger.kernel.org
Message-ID: <CA256A08.0039498E.00@d73mta05.au.ibm.com>
Date: Wed, 7 Mar 2001 15:44:07 +0530
Subject: Re: Linux installation problem
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 CDROM is detected. On booting it gives the following messages
######################

Detected scsi CD-ROM sr0 at scsi0, channel 0, id 12, lun 0
sr0: scsi-1 drive
Uniform CD-ROM driver Revision: 3.12

#############################

The kernel message from the  virtual consol is as follows:

########################
trying to mount device scd0
loopfd is -1
LOP_SET_FD failed : Bad file descriptor

####################

Where am I gone wrong?

Thanks & Regards
Shiju



mshiju@in.ibm.com wrote:

> Hi all,
>            I am trying to install Linux (redhat-7) on a ps/2 server-9595
> machine (mca ). I am booting from a floppy disk and using a custom build
> 2.4.1 kernel image since there are problems  booting  the machine using
the
> installation image on  redhat CD and also it is not CD bootable. The
> problem is that after booting it asks for redhat CDROM and when I insert
> the redhat CDROM it gives a message "I could not find a redhat linux
CDROM
> in any of your CDROM drives ". The CD drive is a SCSI device and I have
> enabled SCSI cdrom in kernel compilation . Can any one help me .
>
> Thanks & Regards
> Shiju

Hi,

I have a type 8560 PS/2... not the same as yours but I did install
slackware
on
it once.

I would suggest installing from a standard PC.  Boot disks are very
inflexible,
since you don't have any utilities to poke around and figure out what's
going
on.

Once you have a complete root filesystem, once you've got a kernel to
recognise your scsi adapter, (and disk), you're off to the races, and can
use all kinds of tools to look into the CDROM problem...BUT

it's probably not going to recognise the disk either...

check different virtual consoles with alt-f1, f2, etc: under
a normal redhat boot disk, the different vc's will have diagnostic
messages, ie kernel messages, list of modules being loaded, etc.

maybe the best way is to be sure to compile kernel with support
for scsi subsystem *in kernel* - not module, along with
scsi-disk, scsi-cdrom, and your scsi host adapter.  the last
one may be the tricky one.  you will have to figure out if it is supported.
(the one in my PS/2 is at least for 2.0 kernel)

if you can make the kernel on the boot disk use a smaller font,
you will be able to see more of the messages at once.

also, shift-PgUp should let you scroll back some of the messages.
look for the kernel messages from your scsi host adapter driver...
if you don't see any there's a problem!

take a look inside your box and see what kind of scsi adapter it has.
or use your reference disk to see what it is.  post that here
so someone (maybe me) can check for kernel support.

Cheers,

Jeremy




