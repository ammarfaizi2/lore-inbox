Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129412AbQKGVTA>; Tue, 7 Nov 2000 16:19:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129414AbQKGVSv>; Tue, 7 Nov 2000 16:18:51 -0500
Received: from [202.106.187.156] ([202.106.187.156]:64272 "HELO sina.com")
	by vger.kernel.org with SMTP id <S129412AbQKGVSp>;
	Tue, 7 Nov 2000 16:18:45 -0500
Date: Wed, 8 Nov 2000 05:14:57 +0800
From: hugang <linuxbest@sina.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux v2.2.17: IDE disk error on Compact Flash device
In-Reply-To: <88256990.0062E87E.00@hqoutbound.ops.3com.com>
In-Reply-To: <88256990.0062E87E.00@hqoutbound.ops.3com.com>
X-Mailer: Sylpheed version 0.4.4 (GTK+ 1.2.8; Linux 2.4.0-test10; i686)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20001107211847Z129412-31179+1843@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Nov 2000 11:58:48 -0600
Steven_Snyder@3com.com wrote:

> 
> 
> Hello.
> 
> When attempting to boot Linux kernel v2.2.17 from a Compact Flash (CF) device I
> am getting the errors shown below.  This CF device is in a PCMCIA form factor
> and is the Master device on the secondary IDE controller
> 
> Before we get to the errors, though, a little background.  I can reproduce this
> boot error on 2 different systems, and have seen the same error messages
> (non-booting) on a 3rd system.  For both boot systems the CF device is the only
> IDE device and is the Master on the secondary IDE controller (/dev/hdc).  For
> the non-booting system the device is in a PCMCIA slot (/dev/hde).
> 
> This is what I see at boot time:
> 
> ide1 at 0x170-0x177,0x376 on irq 15
> hdc: SanDisk SDCFB-128, 122MB /w1kB Cache, CHS=980/8/32
> Partition check:
>  hdc: hdc1 hdc2
>  hdc: hdc1 hdc2
> hdc: drive_cmd: status=0x51 { DriveReady SeekComplete Error }  <- see /Document/Config.help
> hdc: drive_cmd: error=0x04 { DriveStatusError }


	Try to set CONFIG_IDEDISK_MULTI_MODE y.



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
