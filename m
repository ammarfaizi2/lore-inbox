Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261566AbUK1Syi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261566AbUK1Syi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 13:54:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261563AbUK1Syi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 13:54:38 -0500
Received: from postman1.arcor-online.net ([151.189.20.156]:57522 "EHLO
	postman.arcor.de") by vger.kernel.org with ESMTP id S261567AbUK1SyN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 13:54:13 -0500
Message-ID: <33443.192.168.0.5.1101660806.squirrel@192.168.0.10>
In-Reply-To: <slrncqk3so.19r.psavo@varg.dyndns.org>
References: <33133.192.168.0.2.1101499190.squirrel@192.168.0.10>
    <32942.192.168.0.2.1101549298.squirrel@192.168.0.10>
    <slrncqhqib.19r.psavo@varg.dyndns.org>
    <33262.192.168.0.2.1101597468.squirrel@192.168.0.10>
    <slrncqjcve.19r.psavo@varg.dyndns.org>
    <33050.192.168.0.5.1101651929.squirrel@192.168.0.10>
    <20041128165257.GA26714@suse.de>
    <slrncqk3so.19r.psavo@varg.dyndns.org>
Date: Sun, 28 Nov 2004 17:53:26 +0100 (CET)
Subject: Re: Is controlling DVD speeds via SET_STREAMING supported?
From: "Thomas Fritzsche" <tf@noto.de>
To: psavo@iki.fi
Cc: linux-kernel@vger.kernel.org, axboe@suse.de
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Parsi,

I updated the program to use O_RDWR ( http://noto.de/speed/speedcontrol.c )
and tested it with 2.6.10-rc1, but it's always works fine for me (also
with O_RDONLY / this should only prevents you sending command to the
device without permissions).

Sorry I'm running out of ideas :-(. Maybe your device do not support the
SET STREAMING command!? But if you received this sence message it means
that your device also do also not support the "classic"
ioctl(fd, CDROM_SELECT_SPEED, speed) call. Strange!
Do you have a media in the drive? What?
Do you also receive error messages with setcd -x [device]?

Thanks and regards,
 Thomas Fritzsche

> [This message has also been posted to gmane.linux.kernel.]
> * Jens Axboe <axboe@suse.de>:
>>> > I modified your speed-1.0 to open device O_RDWR, didn't help.
>>> > I modified it to also dump_sense after CMD_SEND_PACKET, it's just
>>> > duplicate packet.
>>>
>>> No this will definitively not solve this issue. I will try to check
>>> this
>>> in the kernel, but because I'm not a kernel developer I will CC Jens
>>> Axboe. Maybe he can help?
>>
>> Just fix the permission on the special file. Additionally, the program
>> must open the device O_RDWR.
>
> (under 2.6.10-rc2-mm1)
> I ran speed-1.0 program as root and also modified to open the device
> file as O_RDWR. This didn't help, it still reports same error.
>
> Booted into 2.4.28, speed-1.0 didn't do the trick there either. 'sense'
> reported was 00.00.00 though.
>
>
> --
>    Psi -- <http://www.iki.fi/pasi.savolainen>
>


