Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262889AbSJLLZh>; Sat, 12 Oct 2002 07:25:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262892AbSJLLZh>; Sat, 12 Oct 2002 07:25:37 -0400
Received: from smtp01.iprimus.net.au ([210.50.30.70]:42511 "EHLO
	smtp01.iprimus.net.au") by vger.kernel.org with ESMTP
	id <S262889AbSJLLZd>; Sat, 12 Oct 2002 07:25:33 -0400
Message-Id: <5.1.0.14.0.20021012192828.0183aa08@mail.bur.st>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sat, 12 Oct 2002 19:29:49 +0800
To: Alan Chandler <alan@chandlerfamily.org.uk>
From: Lathiat <lathiat@irc-desk.net>
Subject: Re: How does ide-scsi get loaded?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200210121106.58559.alan@chandlerfamily.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
X-OriginalArrivalTime: 12 Oct 2002 11:29:18.0848 (UTC) FILETIME=[9A80E000:01C271E2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

well the standard places are
- /etc/modules
- initrd
or
/etc/modules.conf
if it is in modules something like alias char-major-blah ide-scsi, then 
change ide-scsi to 'off'

Else it may be compiled into the kernel, try passing ide-scsi=none or 
something similar to the kernel (check the docs)

At 11:06 AM 12/10/2002 +0100, you wrote:
>-----BEGIN PGP SIGNED MESSAGE-----
>Hash: SHA1
>
>Please cc me on replies as I am not subscribed to the list.
>
>I am running a standard debian 2.4.19-k7 kernel on a configuration that 
>has an
>ide dvd rom drive and a scsi cd writer.
>
>Sometime during boot sequence (I can't find where in any log or dmesg - but
>looking at the text flying by - soon after the scsi adapter is found and the
>bus is being scanned for scsi devices) the module ide-scsi gets loaded.
>
>The problem is, I don't want it loaded because it prevents mplayer playing my
>dvds
>
>I initially assumed it was something in the debian start up that caused it but
>
>a) asking on the debian-user mailing list has not elicited any useful reponse
>b) grep -r ide-scsi /etc throws up nothing (ie there is not reference to
>ide-scsi in modules or modules.conf or any initialisation sequence doing a
>modprobe ide-scsi)
>c) scanning all through the initrd.img (loaded through the loop device) does
>not show any reference to ide-scsi either (although grep finds the sequence
>in bin/mount and then hangs locking my keyboard)
>d) modules.dep only shows ide-scsi needing other modules (ide-mod, scsi-mod)
>not the other way round.
>
>I am stuck, where can I look next?
>
>[and I know I could just do a rmmod at the end of the start up sequence but
>...]
>- --
>Alan Chandler
>alan@chandlerfamily.org.uk
>-----BEGIN PGP SIGNATURE-----
>Version: GnuPG v1.2.0 (GNU/Linux)
>
>iD8DBQE9p/RCuFHxcV2FFoIRAiqmAJ4y7pWivbaNV/L4LKqLyBYpu+VsUgCgnSK2
>5YnCzrh6yVM+iwnBVk1BZQE=
>=N3vq
>-----END PGP SIGNATURE-----
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

