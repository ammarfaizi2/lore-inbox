Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283015AbRK1EBD>; Tue, 27 Nov 2001 23:01:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281870AbRK1EAx>; Tue, 27 Nov 2001 23:00:53 -0500
Received: from cc767368-b.etntwn1.nj.home.com ([67.161.97.60]:21816 "HELO
	daemon.kingsqueak.org") by vger.kernel.org with SMTP
	id <S281865AbRK1EAt>; Tue, 27 Nov 2001 23:00:49 -0500
Date: Tue, 27 Nov 2001 23:00:48 -0500
From: Chris <kingsqueak@kingsqueak.org>
To: linux-kernel@vger.kernel.org
Subject: question about ide-scsi timeouts
Message-ID: <20011127230048.A13751@kingsqueak.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
X-Mailer: Mutt http://www.mutt.org/
X-Uptime: 23:39
X-URL: http://www.kingsqueak.org/
X-Accept-Language: en
X-Editor: Vim  http://www.vim.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Forgive me if this winds up being stupidity, but I am not much of a
coder and I'm pretty much at the end of my rope troubleshooting this
issue.

I have a Memorex 48x and HP 9100i CD drives on my system, using
ide-scsi, both drives are detected fine, but no matter what ide
controller or slave/master configuration I try, I'm having real
problems with timeouts reading from them.  Specifically ripping tracks
from audio CD's.  I think I might need to increase the timeout and
wasn't able to grok from ide-scsi.c where to do so, thus this letter.

Here are some stats.

Both drives have been tried with multiple IDE cables, and in any
combination as master/slave and on controller channels with another
master/slave or alone.

I have tried disabling DMA, forcing PIO4 and results have been reduced
function to no function at all.

Best possible combination is the CDR HP drive as slave on second
channel alone, but still times out.

Both drives are known good under other OS's in the same configuration.

Both drives functioned properly quite a while back under 2.0.x
kernels.

Kernel versions all with same errors 2.2.19, 2.2.20, 2.4.13, 2.4.16

The errors I'm getting;

hdb: irq timeout: status=0xd0 { Busy }
hdb: ATAPI reset complete

scsi_read error: sector=15622 length=1 retry=4
                 Sense key: 3 ASC: 2 ASCQ: 0
		 Transport error: Medium reading data from medium
                 System error: Input/output error

Device stats;

Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor:   ATAPI  Model: 48X CDROM        Rev: 3.00
    Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 01 Lun: 00
   Vendor: HP       Model: CD-Writer+ 9100  Rev: 1.0c
    Type:   CD-ROM                           ANSI SCSI revision: 02


VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 6
    ide0: BM-DMA at 0xe000-0xe007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xe008-0xe00f, BIOS settings: hdc:DMA, hdd:DMA
hda: WDC WD172AA, ATA DISK drive
hdb: ATAPI 48X CDROM, ATAPI CD/DVD-ROM drive
hdd: Hewlett-Packard CD-Writer Plus 9100, ATAPI CD/DVD-ROM drive

Any assistance is greatly appreciated, any additional info needed,
just tell me what to send.

Thanks;

-- 
   __ ___                                  __  
  / //_(_)__  _http://www.kingsqueak.org _/ /__
 / ,< / / _ \/ _ `(_-</ _ `/ // / -_) _ `/  '_/
/_/|_/_/_//_/\_, /___/\_, /\_,_/\__/\_,_/_/\_\ 
            /___/      /_/GPG KEY finger 
	    	      @daemon.kingsqueak.org		
