Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129051AbRAYUiQ>; Thu, 25 Jan 2001 15:38:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129169AbRAYUiG>; Thu, 25 Jan 2001 15:38:06 -0500
Received: from think.faceprint.com ([166.90.149.11]:2823 "EHLO
	think.faceprint.com") by vger.kernel.org with ESMTP
	id <S129051AbRAYUiA>; Thu, 25 Jan 2001 15:38:00 -0500
Message-ID: <3A708E9B.FA702A91@faceprint.com>
Date: Thu, 25 Jan 2001 15:37:47 -0500
From: Nathan Walp <faceprint@faceprint.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Heikki Lindholm <holindho@mail.niksula.cs.hut.fi>
CC: linux-kernel@vger.kernel.org
Subject: Re: fat32 corruption with 2.4.0
In-Reply-To: <Pine.GSO.4.20.0101251133480.21886-100000@famine.cs.hut.fi>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Heikki Lindholm wrote:
> 
> Hello,
> I haven't seen much vfat/fat32 complaints lately, so:
> 2.4.0 destroyed my windows partition. There seemed to be some trouble in
> 2.4.0-test9, too. I don't know if this was a known problem or not, but
> 2.4.0-test9 wrote filenames in a wrong way. It could be observed by
> running windows (98 in my case) file system checker (not scandisk, but the
> graphical one) after copying some files with non-8.3 names to a fat32
> partition. There was no noticable data loss, however.
> 
> Yesterday, with 2.4.0 release kernel, mounting a fat32 filesystem caused
> data loss. The filesystem seemed to mount ok at a first glance, but
> reported falsely 100% space usage. Then, after unmounting it, the oldest
> (probably at start of the partition) directories "windows" and "my
> documents" were mangled beyond recognition. I think, in this case, the
> filenames got written REALLY wrong and showed as something like
> "?   * ~ ?. ?  ?". Running scandisk caused most directories and files
> in root directory to change to FILE0xxx.CHK and DIR0xxx.CHK. Most of the
> data was intact, however - and subdirectories below DIR0xxx.CHK's were
> good, too. I had VIA (868B) UDMA enabled, but don't think that was the
> cause since it worked fine with ext2 partitions.
> 
> In addition, trying to write to vfat /floppy with 2.4.0 also didn't
> work. Kernel complained about (bad?) sectors. Whereas 2.2.0 did the job
> fine (obviously, to the same floppy).
> 

I just got through rebuilding my system (messy partition table, and
windoze wouldn't install w/o blowing away everything).  To backup, I
tarred everything up, and put it on a big vfat drive I share between win
and linux.  I also burnt a CD w/ those backup tars.  Being the moron
that I am, I didn't test the tars, and I got burned.  They got
corrupted.  At first I blamed the windows install scandisk that found
some errors on that huge drive, but then i realized that I had burnt the
backup CD before windows ever touched that drive.  So, the files must
have gotten corrupted as they were written to the vfat drive, or in the
5 minutes it took me to find my spindle ;-)  

This was under either kernel 2.4.0-ac10, or 2.4.1-pre10.  I honestly
don't remember which I was in at the time.  If you can fix a crc-messy
.tar.gz, I can find out for you ;-)

Nathan
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
