Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264180AbUDHI3C (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 04:29:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264211AbUDHI3C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 04:29:02 -0400
Received: from smtp-29.ig.com.br ([200.226.132.157]:13254 "HELO
	smtp-29.ig.com.br") by vger.kernel.org with SMTP id S264180AbUDHI26
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 04:28:58 -0400
Message-ID: <40750CCE.1080406@ig.com.br>
Date: Thu, 08 Apr 2004 05:26:54 -0300
From: "Olavo Borges D'Antonio" <olavobdantonio@ig.com.br>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Error trying to mount cdrom after 2.6.4
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Something strange is happening since i migrated from 2.4.25 to 2.6.4.
I cannot mount my cd-rom just after boot. (The cd-rom works fine in 
2.4.25 and works on Windows, so it's not problem with device). In many 
cases, if I open my fstab and delete something, close, re-open and 
rewrite what I deleted, and close again, works (I don't know why!). In 
others I just have to waiting a fews hours to be able to mount my device.

The dmesg shows me:

ide-cd: cmd 0x28 timed out
hdd: DMA timeout retry
hdd: timeout waiting for DMA
hdd: command error: status=0x51 { DriveReady SeekComplete Error }
hdd: command error: error=0x50
end_request: I/O error, dev hdd, sector 18446744073707859296
isofs_fill_super: bread failed, dev=hdd, iso_blknum=16, block=16

my fstab is:
/dev/cdrom      /mnt/cdrom      iso9660         users,noauto,ro         
0   0

/dev/cdrom is a link for /dev/hdd

my /proc/ide/drivers:
ide-cdrom version 4.61
ide-disk version 1.18

cd-rom model:
LG CD-RW CED-8080B

/proc/ide/hdd/settings:
name                    value           min             max             mode
----                         -----              ---               ---    
            ----
current_speed     34                 0               70                rw
dsc_overlap         0                   0               1              
    rw
ide-scsi                0                   0               
1                  rw
init_speed            34                 0               70              
  rw
io_32bit                0                   0               
3                  rw
keepsettings        0                   0               
1                  rw
nice1                    1                   0               
1                  rw
number                3                   0               
3                  rw
pio_mode             write-only     0               255              w
unmaskirq           0                   0               
1                  rw
using_dma           0                   0               
1                  rw

Thanks,
             Olavo B. D'Antonio
