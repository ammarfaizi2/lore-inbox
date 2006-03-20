Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964925AbWCTQlt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964925AbWCTQlt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 11:41:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964970AbWCTQls
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 11:41:48 -0500
Received: from linuxwireless.org.ve.carpathiahost.net ([66.117.45.234]:64702
	"EHLO linuxwireless.org.ve.carpathiahost.net") by vger.kernel.org
	with ESMTP id S964925AbWCTQlq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 11:41:46 -0500
From: "Alejandro Bonilla" <abonilla@linuxwireless.org>
To: linux-kernel@vger.kernel.org
Subject: Re: kernel hda errors on dmesg - new VFS messages
Date: Mon, 20 Mar 2006 10:41:46 -0600
Message-Id: <20060320162753.M3577@linuxwireless.org>
In-Reply-To: <20060320033955.GC18898@eugeneteo.net>
References: <20060318081134.M30026@linuxwireless.org> <17915ac50603180054l4c3c6646ifcdee47e8f76887c@mail.gmail.com> <20060319235255.M28695@linuxwireless.org> <20060320033955.GC18898@eugeneteo.net>
X-Mailer: Open WebMail 2.40 20040816
X-OriginatingIP: 16.90.17.78 (abonilla@linuxwireless.org)
MIME-Version: 1.0
Content-Type: text/plain;
	charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After installing 2.6.16, it looks like the hda messages(below) changed to:

[4294840.149000] VFS: busy inodes on changed media.
[4294840.162000] VFS: busy inodes on changed media.
[4294840.251000] VFS: busy inodes on changed media.
[4294840.258000] VFS: busy inodes on changed media.
[4294850.829000] VFS: busy inodes on changed media.
[4294850.830000] VFS: busy inodes on changed media.
[4294850.831000] VFS: busy inodes on changed media.
[4294850.832000] VFS: busy inodes on changed media.
[4294850.837000] VFS: busy inodes on changed media.
[4294852.847000] VFS: busy inodes on changed media.
[4294852.848000] VFS: busy inodes on changed media.
-I inserted a CD and:-
[4294853.924000] UDF-fs: No VRS found
[4294854.199000] UDF-fs: No VRS found
[4294854.517000] ISO 9660 Extensions: Microsoft Joliet Level 3
[4294854.579000] ISO 9660 Extensions: RRIP_1991A

It looks like it was taking /dev/hda as the CDROM before, still I don't see a
symlink and still have no idea why this is flooding my dmesg.

It is a LightScribe CDROM in case it matters.

any idea?

Thanks,

> > I have an Compaq V2000 laptop with Ubuntu Dapper Drake, I'm getting flooded 
> > with the messages below: 
> > ON: Linux ubuntu 2.6.15-18-386 #1 PREEMPT Thu Mar 9 14:41:49 UTC 2006 i686 
> > GNU/Linux 
> > /dev/sda: FUJITSU MHV2060BH:
> > 
> > Why am I getting hda errors when I don't even have a hda drive? Mine is sda.
> > The syslog says is the kernel itself, no other application is causing this as
> > I have stopped most services and still happen.
> > 
> > I already wrote to the Ubuntu ML but had no luck. 
> > 
> > Any idea?
> > 
> > dmesg
> > 
> > [4295643.338000] ide: failed opcode was: 0xef 
> > [4295644.283000] hda: error code: 0x70  sense_key: 0x02   asc: 0x30  ascq:
0x00 
> > [4295644.295000] hda: error code: 0x70   sense_key: 0x02  asc: 0x30  ascq:
0x00 
> > [4295645.963000] hda: error code: 0x70  sense_key: 0x02   asc: 0x30  ascq:
0x00 
> > [4295645.966000] hda: drive_cmd: status=0x51 { DriveReady SeekComplete
Error } 
> > [4295645.966000] hda: drive_cmd: error=0x04 { AbortedCommand } 
> > [4295645.966000] ide: failed opcode was: 0xec 
> > [4295646.000000] hda: error code: 0x70  sense_key: 0x02  asc: 0x30  ascq:
0x00 
> > [4295646.003000] hda: drive_cmd: status=0x51 { DriveReady SeekComplete
Error } 
> > [4295646.003000 ] hda: drive_cmd: error=0x04 { AbortedCommand } 
> > [4295646.003000] ide: failed opcode was: 0xec 
> > [4295646.345000] hda: error code: 0x70  sense_key: 0x02  asc: 0x30  ascq:
0x00 
> > [4295646.357000] hda: error code: 0x70  sense_key: 0x02  asc: 0x30  ascq:
0x00 
> > [4295648.408000] hda: error code: 0x70  sense_key: 0x02   asc: 0x30  ascq:
0x00 
> > [4295648.421000] hda: error code: 0x70   sense_key: 0x02  asc: 0x30  ascq:
0x00 
> > [4295650.471000] hda: error code: 0x70  sense_key: 0x02  asc: 0x30   ascq:
0x00 
> > [4295650.483000] hda: error code: 0x70  sense_key: 0x02   asc: 0x30  ascq:
0x00 
> > [4295652.534000] hda: error code: 0x70   sense_key: 0x02  asc: 0x30  ascq:
0x00 
> > [4295652.546000] hda: error code: 0x70  sense_key: 0x02  asc: 0x30   ascq:
0x00 
> > [4295654.601000] hda: error code: 0x70  sense_key: 0x02   asc: 0x30  ascq:
0x00 
> > [4295654.612000] hda: error code: 0x70   sense_key: 0x02  asc: 0x30  ascq:
0x00
> > 
> > Thanks,
> > 
> > .Alejandro
> > 
> > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> 
> -- 
> 1024D/A6D12F80 print D51D 2633 8DAC 04DB 7265  9BB8 5883 6DAA A6D1 2F80
> main(i) { putchar(182623909 >> (i-1) * 5&31|!!(i<7)<<6) && main(++i)
> ; }


--
Open WebMail Project (http://openwebmail.org)

