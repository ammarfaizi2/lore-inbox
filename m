Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315414AbSFXXND>; Mon, 24 Jun 2002 19:13:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315415AbSFXXNC>; Mon, 24 Jun 2002 19:13:02 -0400
Received: from host.greatconnect.com ([209.239.40.135]:21513 "EHLO
	host.greatconnect.com") by vger.kernel.org with ESMTP
	id <S315414AbSFXXNB>; Mon, 24 Jun 2002 19:13:01 -0400
Subject: Re: Unexpected busfree in Data-in phase ,
	2.4.18-ac3+smp+raid0+aic-7880U+ext3
From: Samuel Flory <sflory@rackable.com>
To: Dimitris Zilaskos <dzila@tassadar.physics.auth.gr>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0206250012320.8301-100000@tassadar.physics.auth.gr>
References: <Pine.LNX.4.44.0206250012320.8301-100000@tassadar.physics.auth.gr>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 24 Jun 2002 16:12:23 -0700
Message-Id: <1024960344.2742.608.camel@flory.corp.rackablelabs.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  In general "Unexpected busfree" indicates bad cabling or termination.

On Mon, 2002-06-24 at 14:38, Dimitris Zilaskos wrote:
> 
>  I have a raid0 array with 3* 9 gb ultra wide scsi disks , 2 Quantum
> Viking 2 and and 1 IBM DNES . The controller is aic7880U on-board on a
> dual p2 266 system . Today I found the system unable to access data on the
> raid array and the following in the logs :
> 
> 
> Jun 24 15:23:23 foo kernel: (scsi0:A:2:0): Unexpected busfree in
> Data-in phase
> Jun 24 15:23:23 foo kernel: SEQADDR == 0x7d
> Jun 24 15:23:23 foo kernel: SCSI disk error : host 0 channel 0 id 2
> lun 0 return code = 10000
> Jun 24 15:23:23 foo kernel:  I/O error: dev 08:11, sector 1269344
> Jun 24 15:23:23 foo kernel: Device 08:11 not ready.
> Jun 24 15:23:23 foo kernel:  I/O error: dev 08:11, sector 1269344
> Jun 24 15:23:26 foo kernel: Device 08:11 not ready.
> Jun 24 15:23:26 foo kernel:  I/O error: dev 08:11, sector 1291968
> Jun 24 15:23:26 foo kernel: Device 08:11 not ready.
> Jun 24 15:23:26 foo kernel:  I/O error: dev 08:11, sector 1291968
> Jun 24 15:23:26 foo kernel: Device 08:11 not ready.
> Jun 24 15:23:26 foo kernel:  I/O error: dev 08:11, sector 4464
> Jun 24 15:23:27 foo kernel: Device 08:11 not ready.
> Jun 24 15:23:27 foo kernel:  I/O error: dev 08:11, sector 1292416
> 
> 
> and those messages go on for hours . Apart from that , the system works ok
> . A reboot followed by an fsck results in a system working ok , with no
> data loss . Extensive read/write operations ( copying of big files /many
> small ones ) seem to work ok . The message has not reappeared as yet .
>     The errors occured after roughly 7 days of uptime , during which
> there has been continuous read operation from the array , from 200
> kbytes/sec to 1 Mbyte/sec ( the system is a busy ftp server )
> 
> this the output of /proc/scsi/scsi
> Attached devices:
> Host: scsi0 Channel: 00 Id: 01 Lun: 00
>   Vendor: QUANTUM  Model: VIKING II 9.1WLS Rev: 5520
>   Type:   Direct-Access                    ANSI SCSI revision: 02
> Host: scsi0 Channel: 00 Id: 02 Lun: 00
>   Vendor: IBM      Model: DNES-309170W     Rev: SA30
>   Type:   Direct-Access                    ANSI SCSI revision: 03
> Host: scsi0 Channel: 00 Id: 04 Lun: 00
>   Vendor: QUANTUM  Model: VIKING II 9.1WLS Rev: 5520
>   Type:   Direct-Access                    ANSI SCSI revision: 02
> 
>   Any advice is welcomed .
> 
>  Regards ,
> --
> =============================================================================
> 
> Dimitris Zilaskos
> 
> Department of Physics @ Aristotle Univercity of Thessaloniki , Greece
> =============================================================================
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


