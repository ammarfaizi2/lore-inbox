Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265630AbRFWE7d>; Sat, 23 Jun 2001 00:59:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265626AbRFWE7X>; Sat, 23 Jun 2001 00:59:23 -0400
Received: from james.kalifornia.com ([208.179.59.2]:4191 "EHLO
	james.kalifornia.com") by vger.kernel.org with ESMTP
	id <S265630AbRFWE7G>; Sat, 23 Jun 2001 00:59:06 -0400
Message-ID: <3B342213.9020603@blue-labs.org>
Date: Fri, 22 Jun 2001 21:58:59 -0700
From: David Ford <david@blue-labs.org>
Organization: Blue Labs
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.1+) Gecko/20010622
X-Accept-Language: en-us
MIME-Version: 1.0
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Cleanup kbuild for aic7xxx
In-Reply-To: <200106230307.f5N370U83109@aslan.scsiguy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is 2.4.5 plain with the old aic driver.


(scsi0) <Adaptec AIC-7896/7 Ultra2 SCSI host adapter> found at PCI 0/12/1
(scsi0) Wide Channel B, SCSI ID=7, 32/255 SCBs
(scsi0) Downloading sequencer code... 392 instructions downloaded
(scsi1) <Adaptec AIC-7896/7 Ultra2 SCSI host adapter> found at PCI 0/12/0
(scsi1) Wide Channel A, SCSI ID=7, 32/255 SCBs
(scsi1) Downloading sequencer code... 392 instructions downloaded
scsi0 : Adaptec AHA274x/284x/294x (EISA/VLB/PCI-Fast SCSI) 5.2.1/5.2.0
       <Adaptec AIC-7896/7 Ultra2 SCSI host adapter>
scsi1 : Adaptec AHA274x/284x/294x (EISA/VLB/PCI-Fast SCSI) 5.2.1/5.2.0
       <Adaptec AIC-7896/7 Ultra2 SCSI host adapter>

And then it breaks.

scsi : aborting command due to timeout : pid 0, scsi0, channel 0, id 0, 
lun 0 Inquiry 00 00 00 ff 00
(scsi0:0:0:0) Aborting scb 0, flags 0x6
SCSI host 0 abort (pid 0) timed out - resetting
SCSI bus is being reset for host 0 channel 0.
(scsi0:0:0:0) Sending WDTR message.
(scsi0:0:0:0) Reset called, scb 0, flags 0x16
(scsi0:0:0:0) Bus Device reset, scb flags 0x16, Message-Out phase
(scsi0:0:0:0) SCSISIGI 0xb6, SEQADDR 0xbd, SSTAT0 0x2, SSTAT1 0x3
(scsi0:0:0:0) Queueing device reset command.
(scsi0:-1:-1:-1) 0 commands found and queued for completion.
SCSI host 0 channel 0 reset (pid 0) timed out - trying harder
SCSI bus is being reset for host 0 channel 0.
(scsi0:0:0:0) Reset called, scb 0, flags 0x1076
(scsi0:0:-1:-1) Reset channel called, will initiate reset.
(scsi0:0:-1:-1) Resetting currently active channel.
(scsi0:0:-1:-1) Channel reset
(scsi0:0:-1:-1) Reset device, active_scb 0
(scsi0:0:0:-1) Cleaning up status information and delayed_scbs.
(scsi0:0:1:-1) Cleaning up status information and delayed_scbs.
(scsi0:0:2:-1) Cleaning up status information and delayed_scbs.
(scsi0:0:3:-1) Cleaning up status information and delayed_scbs.
(scsi0:0:4:-1) Cleaning up status information and delayed_scbs.
(scsi0:0:5:-1) Cleaning up status information and delayed_scbs.
(scsi0:0:6:-1) Cleaning up status information and delayed_scbs.
(scsi0:0:8:-1) Cleaning up status information and delayed_scbs.
(scsi0:0:9:-1) Cleaning up status information and delayed_scbs.
(scsi0:0:10:-1) Cleaning up status information and delayed_scbs.
(scsi0:0:11:-1) Cleaning up status information and delayed_scbs.
(scsi0:0:12:-1) Cleaning up status information and delayed_scbs.
(scsi0:0:13:-1) Cleaning up status information and delayed_scbs.
(scsi0:0:14:-1) Cleaning up status information and delayed_scbs.
(scsi0:0:15:-1) Cleaning up status information and delayed_scbs.
(scsi0:0:-1:-1) Cleaning QINFIFO.
(scsi0:0:-1:-1) Cleaning waiting_scbs.
(scsi0:0:-1:-1) Cleaning waiting for selection list.
(scsi0:0:-1:-1) Cleaning disconnected scbs list.
(scsi0:0:0:0) Aborting scb 0
(scsi0:0:0:0) Aborting scb 1
(scsi0:-1:-1:-1) 2 commands found and queued for completion.
SCSI host 0 abort (pid 0) timed out - resetting
SCSI bus is being reset for host 0 channel 0.
(scsi0:0:0:0) Sending WDTR message.
(scsi0:0:0:0) Reset called, scb 0, flags 0x6
(scsi0:0:0:0) Bus Device reset, scb flags 0x6, Message-Out phase
(scsi0:0:0:0) SCSISIGI 0xb6, SEQADDR 0xbd, SSTAT0 0x2, SSTAT1 0x3
(scsi0:0:0:0) Queueing device reset command.
(scsi0:-1:-1:-1) 0 commands found and queued for completion.
SCSI host 0 channel 0 reset (pid 0) timed out - trying harder
SCSI bus is being reset for host 0 channel 0.

And it happily loops on this over and over.

David


