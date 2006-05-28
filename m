Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751265AbWE1HFK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751265AbWE1HFK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 May 2006 03:05:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751267AbWE1HFK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 May 2006 03:05:10 -0400
Received: from ns.dynamicweb.hu ([195.228.155.139]:36051 "EHLO dynamicweb.hu")
	by vger.kernel.org with ESMTP id S1751265AbWE1HFJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 May 2006 03:05:09 -0400
Message-ID: <004501c68225$00add170$1800a8c0@dcccs>
From: =?iso-8859-1?Q?Haar_J=E1nos?= <djani22@netcenter.hu>
To: "Jim Crilly" <jim@why.dont.jablowme.net>
Cc: <linux-kernel@vger.kernel.org>
References: <01b701c6818d$4bcd37b0$1800a8c0@dcccs> <20060527234350.GA13881@voodoo.jdc.home>
Subject: Re: How to send a break? - dump from frozen 64bit linux
Date: Sun, 28 May 2006 09:04:27 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


----- Original Message ----- 
From: "Jim Crilly" <jim@why.dont.jablowme.net>
To: "Haar János" <djani22@netcenter.hu>
Cc: <linux-kernel@vger.kernel.org>
Sent: Sunday, May 28, 2006 1:43 AM
Subject: Re: How to send a break?


> On 05/27/06 02:58:44PM +0200, Haar János wrote:
> > Hello, list,
> >
> > I wish to know, how to send a "BREAK" to trigger the sysreq functions on
the
> > serial line, using echo.
> >
> > I mean like this:
> >
> > #!/bin/bash
> > echo "?BREAK?" >/dev/ttyS0
> > sleep 2
> > echo "m" >/dev/ttyS0
> >
>
> Is there a reason you can't use "echo -n m > /proc/sysrq-trigger"?

Yes, i want to dump my frequently frozen remote server, automatically, if it
is possible.  (using null-modem cable, and another server.)

Anyway, i made it this time by hand.

Here is the dump:
http://download.netcenter.hu/bughunt/20060528/log.txt  (400KB!)

Can somebody tell me, what is wrong exactly?

Anyway, i interested about, how can i -a single user- interpret these dump
to made error reporting more useful?


The problem:
I used one stable system on 32bit, but i need to switch to X86_64, because
the nbd cannot use >2TB devices on 32bit.
I have reinstall the RH 9.0 to FC 5.0, and recompiled everything what i used
to serving. (the OS is only for external tasks.)

But on 64bit, my system becomes unstable.
Sometimes it is frozen, but no error message at all!
I can see, the crond-jobs is hangs too, but syslog can post messages, but no
valuable at all.
(I cannot login with ssh.)

Thats why i need to dump with serial console.

Can somebody help me? :-)

Here is the "normal" dmesg message:
http://download.netcenter.hu/bughunt/20060528/dmesg.txt  (21KB)

Thanks,
Janos


>
> Jim.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

