Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289604AbSAJTC7>; Thu, 10 Jan 2002 14:02:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289593AbSAJTCu>; Thu, 10 Jan 2002 14:02:50 -0500
Received: from 12-237-170-171.client.attbi.com ([12.237.170.171]:39810 "EHLO
	wf-rch.cirr.com") by vger.kernel.org with ESMTP id <S289596AbSAJTC3>;
	Thu, 10 Jan 2002 14:02:29 -0500
Message-ID: <3C3DE5C8.7060504@acm.org>
Date: Thu, 10 Jan 2002 13:04:40 -0600
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux ppc; en-US; rv:0.9.7) Gecko/20011221
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Problem with IDE harddrive and ATA FLASH on the same IDE channel
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am working on a board that has both an IDE drive and an ATA flash on 
the same IDE channel.  If I use them independently, they work fine.  If 
I try to use them together (say, copy files from one to the other) I get 
lost interrupts, spurrious interrupts, etc.  Can you have a HDD and 
FLASH on the same IDE channel?  This is on a Serverworks OSB4, I've 
tried various kernels.  One wierd thing, if I compile the Redhat 7.2 
kernel with Redhat's compile, it does seem to work.  If I compile it 
with a 2.95.3 compiler (on SuSE) it doesn't work.  I've tried playing 
with timing, with and without DMA, etc.

Any ideas on this or how to debug this?

Thanks,

-Corey

heres the kernel output on the error:

hdb: status error: status=0x58 { DriveReady SeekComplete DataRequest }
hdb: drive not ready for command
ide0: unexpected interrupt, status=0x58, count=1
hdb: status error: status=0x58 { DriveReady SeekComplete DataRequest }
hdb: drive not ready for command
hdb: status error: status=0x58 { DriveReady SeekComplete DataRequest }
hdb: drive not ready for command
hdb: status error: status=0x58 { DriveReady SeekComplete DataRequest }
hdb: drive not ready for command
ide0: reset: success
hdb: status error: status=0x58 { DriveReady SeekComplete DataRequest }
hdb: drive not ready for command
hdb: status error: status=0x58 { DriveReady SeekComplete DataRequest }
hdb: drive not ready for command
hdb: status error: status=0x58 { DriveReady SeekComplete DataRequest }
hdb: drive not ready for command
hdb: status error: status=0x58 { DriveReady SeekComplete DataRequest }
hdb: drive not ready for command
ide0: reset: success
hdb: status error: status=0x58 { DriveReady SeekComplete DataRequest }
end_request: I/O error, dev 03:41 (hdb), sector 32780
hdb: drive not ready for command
EXT2-fs error (device ide0(3,65)): ext2_write_inode: unable to read 
inode block
- inode=3945, block=16390
hdb: lost interrupt
hdb: status error: status=0x58 { DriveReady SeekComplete DataRequest }
hdb: drive not ready for command
hdb: status error: status=0x58 { DriveReady SeekComplete DataRequest }
hdb: drive not ready for command
hdb: status error: status=0x58 { DriveReady SeekComplete DataRequest }
hdb: drive not ready for command
hdb: status error: status=0x58 { DriveReady SeekComplete DataRequest }
hdb: drive not ready for command
ide0: unexpected interrupt, status=0x58, count=5
ide0: reset: master: error (0x80?); slave: failed
hda: status timeout: status=0x80 { Busy }
hda: drive not ready for command
ide0: reset: success
hdb: lost interrupt
hdb: lost interrupt
hdb: lost interrupt
hdb: lost interrupt
hdb: lost interrupt
hdb: lost interrupt
end_request: I/O error, dev 03:41 (hdb), sector 32780
hdb: drive not ready for command
EXT2-fs error (device ide0(3,65)): ext2_write_inode: unable to read 
inode block
- inode=3945, block=16390
hdb: lost interrupt
hdb: status error: status=0x58 { DriveReady SeekComplete DataRequest }
hdb: drive not ready for command
hdb: status error: status=0x58 { DriveReady SeekComplete DataRequest }
hdb: drive not ready for command
hdb: status error: status=0x58 { DriveReady SeekComplete DataRequest }
hdb: drive not ready for command
hdb: status error: status=0x58 { DriveReady SeekComplete DataRequest }
hdb: drive not ready for command
ide0: unexpected interrupt, status=0x58, count=5
ide0: reset: master: error (0x80?); slave: failed
hda: status timeout: status=0x80 { Busy }
hda: drive not ready for command
ide0: reset: success
hdb: lost interrupt
hdb: lost interrupt
hdb: lost interrupt
hdb: lost interrupt
hdb: lost interrupt
hdb: lost interrupt
hdb: lost interrupt
hdb: lost interrupt
hdb: lost interrupt

