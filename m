Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268086AbTCCA2i>; Sun, 2 Mar 2003 19:28:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268093AbTCCA2i>; Sun, 2 Mar 2003 19:28:38 -0500
Received: from mkc-65-26-127-147.kc.rr.com ([65.26.127.147]:27144 "EHLO
	portal.home.hanaden.com") by vger.kernel.org with ESMTP
	id <S268086AbTCCA2h>; Sun, 2 Mar 2003 19:28:37 -0500
Message-ID: <3E62A426.1000402@hanaden.com>
Date: Sun, 02 Mar 2003 18:39:02 -0600
From: Hanasaki JiJi <hanasaki@hanaden.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030215
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.4.20 ide-scsi
References: <3E625282.8010101@hanaden.com> <200303022038.53606.freesoftwaredeveloper@web.de> <3E6261C3.1020700@pobox.com> <200303022112.18566.freesoftwaredeveloper@web.de>
In-Reply-To: <200303022112.18566.freesoftwaredeveloper@web.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Still no luck.. I took out the idecd.


scsi0 : SCSI host adapter emulation for IDE ATAPI devices
   Vendor: TEAC      Model: CD-W54E           Rev: 1.0A
   Type:   CD-ROM                             ANSI SCSI revision: 02
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
sr0: scsi3-mmc drive: 32x/32x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12
fred:~# mount /cdrom/
ide-scsi: hdc: unsupported command in request queue (0)
end_request: I/O error, dev 16:00 (hdc), sector 64
isofs_read_super: bread failed, dev=16:00, iso_blknum=16, block=32
mount: wrong fs type, bad option, bad superblock on /dev/cdrom,
        or too many mounted file systems
        (could this be the IDE device where you in fact use
        ide-scsi so that sr0 or sda or so is needed?)


Michael Buesch wrote:
>>The standard solution, supported by all major distributions, is to supply
>>	hdX=ide-scsi
>>on the kernel command line.
>>
>>There is no need to completely disable IDE-CD.  IDE-CD and IDE-SCSI can
>>and do interoperate all the time.
> 
> 
> Yes I thought this also until yesterday. :)
> GRUB is configured this way in my case:
> kernel (hd1,0)/linux root=/dev/md0 hdd=ide-scsi hdb=ide-scsi mce vga=779
> 
> But nevertheless it didn't work until I disabled
> CONFIG_BLK_DEV_IDECD
> 
> It's somewhat strange, but.. :)
> 
> bye, Michael Buesch.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
=================================================================
= Management is doing things right; leadership is doing the     =
=       right things.    - Peter Drucker                        =
=_______________________________________________________________=
=     http://www.sun.com/service/sunps/jdc/javacenter.pdf       =
=  www.sun.com | www.javasoft.com | http://wwws.sun.com/sunone  =
=================================================================

