Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131007AbRCFQT4>; Tue, 6 Mar 2001 11:19:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131004AbRCFQTr>; Tue, 6 Mar 2001 11:19:47 -0500
Received: from tomts8.bellnexxia.net ([209.226.175.52]:59385 "EHLO
	tomts8-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S131002AbRCFQTm>; Tue, 6 Mar 2001 11:19:42 -0500
Message-ID: <3AA50CE8.2EA86CD@coplanar.net>
Date: Tue, 06 Mar 2001 11:14:32 -0500
From: Jeremy Jackson <jerj@coplanar.net>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: mshiju@in.ibm.com
CC: linux-kernel@vger.kernel.org, linux-mca@vger.kernel.org
Subject: Re: Linux installation problem
In-Reply-To: <CA256A07.00341167.00@d73mta05.au.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mshiju@in.ibm.com wrote:

> Hi all,
>            I am trying to install Linux (redhat-7) on a ps/2 server-9595
> machine (mca ). I am booting from a floppy disk and using a custom build
> 2.4.1 kernel image since there are problems  booting  the machine using the
> installation image on  redhat CD and also it is not CD bootable. The
> problem is that after booting it asks for redhat CDROM and when I insert
> the redhat CDROM it gives a message "I could not find a redhat linux CDROM
> in any of your CDROM drives ". The CD drive is a SCSI device and I have
> enabled SCSI cdrom in kernel compilation . Can any one help me .
>
> Thanks & Regards
> Shiju

Hi,

I have a type 8560 PS/2... not the same as yours but I did install slackware
on
it once.

I would suggest installing from a standard PC.  Boot disks are very
inflexible,
since you don't have any utilities to poke around and figure out what's going
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

