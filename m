Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279406AbRJ2Tec>; Mon, 29 Oct 2001 14:34:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279412AbRJ2Tdh>; Mon, 29 Oct 2001 14:33:37 -0500
Received: from mailout00.sul.t-online.com ([194.25.134.16]:45204 "EHLO
	mailout00.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S279408AbRJ2Td0>; Mon, 29 Oct 2001 14:33:26 -0500
Date: 27 Oct 2001 14:45:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <8BfMOaZmw-B@khms.westfalen.de>
In-Reply-To: <3BCDCF1D.6030202@usa.net>
Subject: Re: [Q] pivot_root and initrd
X-Mailer: CrossPoint v3.12d.kh7 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
In-Reply-To: <3BCDCF1D.6030202@usa.net>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ebrower@usa.net (Eric)  wrote on 17.10.01 in <3BCDCF1D.6030202@usa.net>:

> You are simply doing the following, I assume with success:

>    exec /sbin/init "$@"

> whereas I am doing something like the following:

>    exec chroot . sh -c 'umount $OLDROOT; exec -a init.new /sbin/init
>      $INITARGS' <dev/console >dev/console 2>&1

> I am mystified that the call to 'exec /sbin/init' works if you are using
> the standard (you mention "based on RedHat7.1" util-linux") /sbin/init
> proggie, and that a standard RH7.1 initscripts would not complain when
> the root filesystem is already mounted r/w.

It works because the PID is 1, of course.

/linuxrc (or however you call it) runs with PID=1, so when it exec's /sbin/ 
init, the PID is still 1.

OTOH, you have chroot run a shell as a child, which therefore does *not*  
have PID=1.

MfG Kai
