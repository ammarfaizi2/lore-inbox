Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284177AbRLKX5p>; Tue, 11 Dec 2001 18:57:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284182AbRLKX5f>; Tue, 11 Dec 2001 18:57:35 -0500
Received: from www3.aname.net ([62.119.28.103]:31421 "EHLO www3.aname.net")
	by vger.kernel.org with ESMTP id <S284177AbRLKX5P>;
	Tue, 11 Dec 2001 18:57:15 -0500
From: "Johan Ekenberg" <johan@ekenberg.se>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: <linux-kernel@vger.kernel.org>
Subject: SV: Lockups with 2.4.14 and 2.4.16
Date: Wed, 12 Dec 2001 00:56:33 +0100
Message-ID: <000a01c1829f$75daf7a0$050010ac@FUTURE>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook 8.5, Build 4.71.2377.0
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
In-Reply-To: <E16Dwct-0007QB-00@the-village.bc.nu>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >  - My not-so-professional guess is that the machine is locked
> > up waiting for some disk i/o that never happens, either to swap
> > or normal filesystem. But, I might be all wrong.
>
> I agree 100% with your diagnostic. Its directly as if your
> /var/spool volume hung and the mylex stopped responding
> on that channel.

/ and /var/spool are on the same channel on the Mylex. If it's a question of
an entire channel hung up, / must be blocked too. Please note, this happened
on several machines so I guess it's not a hardware fault in the Mylex card.

> I take it there is nothing in dmesg ?

I'll check that next time if the command is runnable.

> touch /foo &
> hit return
> (should report it finished)
> touch /var/spool/foo &
> (if this never returns you know you /var/spool choked for some reason)

Thanks, I'll try that also next time.

In the meantime, are there any patches I should apply or other things to
try? I'd rather see there is no "next time"... Since we also upgraded to
ReiserFS 3.6 it seems difficult/impossible to quickly revert to a
2.2-kernel.(?) These are production machines and people are getting upset
about these lockups.

All help appreciated,
regards Johan


