Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136146AbREJMbt>; Thu, 10 May 2001 08:31:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136148AbREJMbk>; Thu, 10 May 2001 08:31:40 -0400
Received: from host-64-65-206-13.choiceone.net ([64.65.206.13]:18000 "EHLO
	isaiah.tpr-east.com") by vger.kernel.org with ESMTP
	id <S136146AbREJMb2>; Thu, 10 May 2001 08:31:28 -0400
Message-ID: <3AFA8A1D.A9BBB4DF@tpr.com>
Date: Thu, 10 May 2001 08:31:25 -0400
From: Mark Bratcher <bratcher@tpr.com>
Organization: Torrey Pines Research
X-Mailer: Mozilla 4.75 [en] (Win98; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Tim Moore <timothymoore@bigfoot.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: ATAPI Tape Driver Failure in Kernel 2.4.4, More
In-Reply-To: <3AF9558F.9C76953C@tpr.com> <3AF9B411.2A0F3F43@tpr.com> <3AF9B876.FDB1B6DD@bigfoot.com>
Content-Type: multipart/mixed;
 boundary="------------260CEFE2D397BBDB74D3D382"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------260CEFE2D397BBDB74D3D382
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Tim,

Thanks for the input.

Sadly, it didn't work. I tried the SCSI emulation (which I already had running
on the CD-ROM, which works), but it fails for the tape.

With SCSI emulation turned on, the system recognizes the tape drive as SCSI. 
However, an attempt at the following command:

mt -f /dev/st0 rewind

yields the following errors:

May 10 07:49:33 isaiah kernel: st0: Error with sense data: [valid=0] Info
fld=0x0,
Current st09:00: sense key Illegal Request 
May 10 07:49:33 isaiah kernel: Additional sense indicates Invalid command
operation code 

This all works OK in kernel 2.2.17. But it fails in 2.4.4.

Mark

Tim Moore wrote:
> 
> Use SCSI emulation instead of ATAPI for the tape device.  Also make sure
> your mt is >= 0.5.
> 
> [tim@abit tim]# mt -v
> mt-st v. 0.5b
> [tim@abit linux]# dump -v
> dump 0.4b
> [tim@abit linux]# restore -v
> restore 0.4b17
> 
> [dmesg exerpts - tape is /dev/st0]
> ...
> hdd: HP COLORADO 20GB, ATAPI TAPE drive
> ...
> scsi0 : SCSI host adapter emulation for IDE ATAPI devices
> scsi : 1 host.
>   Vendor: HP        Model: COLORADO 20GB     Rev: 4.01
>   Type:   Sequential-Access                  ANSI SCSI revision: 02
> Detected scsi tape st0 at scsi0, channel 0, id 0, lun 0
> ...
> 
> for 2.2.x .config:
> 
> CONFIG_BLK_DEV_IDESCSI
> #CONFIG_BLK_DEV_IDETAPE
> CONFIG_SCSI
> CONFIG_CHR_DEV_ST
> 
> > immediately after the backup completes and I try to write a file mark with "mt":
> >
> > May  9 16:50:49 isaiah kernel: ide-tape: Reached idetape_chrdev_open
> > May  9 16:52:05 isaiah kernel: hdd: irq timeout: status=0xd0 { Busy }
> > May  9 16:52:05 isaiah kernel: hdd: ATAPI reset complete
> > May  9 16:52:05 isaiah kernel: ide-tape: Couldn't write a filemark
> > May  9 16:52:06 isaiah kernel: ide-tape: Reached idetape_chrdev_open
> > May  9 16:54:06 isaiah kernel: ide-tape: ht0: DSC timeout
> > May  9 16:54:06 isaiah kernel: hdd: ATAPI reset complete
> > ...
> 
> --
>   |  650.390.9613  |  6502247437@messaging.cellone-sf.com
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
--------------260CEFE2D397BBDB74D3D382
Content-Type: text/x-vcard; charset=us-ascii;
 name="bratcher.vcf"
Content-Transfer-Encoding: 7bit
Content-Description: Card for Mark Bratcher
Content-Disposition: attachment;
 filename="bratcher.vcf"

begin:vcard 
n:Bratcher;Mark
tel;fax:716/288-4604
tel;work:716/288-7220
x-mozilla-html:FALSE
url:www.tpr.com
org:Torrey Pines Research
version:2.1
email;internet:bratcher@tpr.com
title:Director of Software Development
adr;quoted-printable:;;565 Blossom Road=0D=0ASuite A;Rochester;New York;14610;USA
x-mozilla-cpt:;19472
fn:Bratcher, Mark
end:vcard

--------------260CEFE2D397BBDB74D3D382--

