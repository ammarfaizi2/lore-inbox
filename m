Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281262AbRKTTBN>; Tue, 20 Nov 2001 14:01:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281242AbRKTTA5>; Tue, 20 Nov 2001 14:00:57 -0500
Received: from sj-msg-core-3.cisco.com ([171.70.157.152]:60869 "EHLO
	sj-msg-core-3.cisco.com") by vger.kernel.org with ESMTP
	id <S280894AbRKTTAo>; Tue, 20 Nov 2001 14:00:44 -0500
Message-ID: <00a201c171f5$4855bff0$163147ab@cisco.com>
From: "Hua Zhong" <hzhong@cisco.com>
To: =?iso-8859-1?Q?Lu=EDs_Henriques?= <lhenriques@criticalsoftware.com>,
        "Andreas Dilger" <adilger@turbolabs.com>
Cc: "Anton Altaparmakov" <aia21@cam.ac.uk>, <linux-kernel@vger.kernel.org>
In-Reply-To: <5.1.0.14.2.20011120165440.00a745b0@pop.cus.cam.ac.uk> <200111201714.fAKHEc276467@criticalsoftware.com> <20011120114124.T1308@lynx.no> <200111201849.fAKInr205178@criticalsoftware.com>
Subject: Re: copy to suer space
Date: Tue, 20 Nov 2001 10:58:02 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Why not SIGSTOP/SIGCONT instead?

I don't see any reason why you should change the code segment (reminded me
some ugly Windows hacks of changing DLL entries).

----- Original Message -----
From: "Luís Henriques" <lhenriques@criticalsoftware.com>
To: "Andreas Dilger" <adilger@turbolabs.com>
Cc: "Anton Altaparmakov" <aia21@cam.ac.uk>; <linux-kernel@vger.kernel.org>
Sent: Tuesday, November 20, 2001 10:44 AM
Subject: Re: copy to suer space


>
> > Maybe if you describe the actual problem that you are trying to solve,
and
> > not the actual way you are trying to solve it, there may be a better
> > method. Usually, if something you are trying to do is very hard to do,
> > there is a different (much better) way of doing it.
> >
> > Cheers, Andreas
>
> OK, here it goes:
>
> I'm developping a kernel module that needs to delay a process, that is, he
> receives a PID and, when a specific event occurs, that process shall be
> delayed. This delay shall be done in a way that the process keeps burning
CPU
> time (it can not be, e.g., put in a waiting-list...).
> The solution I found was to change its code segment, putting a loop in it.
> After a specified period of time, the original code must be restored and
the
> process must keep going as nothing happened.
> The main problem I found was already explained: can't write to the CS!
>
> --
> Luís Henriques
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

