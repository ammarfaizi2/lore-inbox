Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272314AbRHXUOv>; Fri, 24 Aug 2001 16:14:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272315AbRHXUOl>; Fri, 24 Aug 2001 16:14:41 -0400
Received: from sj-msg-core-1.cisco.com ([171.71.163.11]:59796 "EHLO
	sj-msg-core-1.cisco.com") by vger.kernel.org with ESMTP
	id <S272314AbRHXUOa>; Fri, 24 Aug 2001 16:14:30 -0400
Message-ID: <005a01c12cd9$2f153950$103147ab@cisco.com>
From: "Hua Zhong" <hzhong@cisco.com>
To: <ddade@digitalstatecraft.com>, "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <E15aNCX-0006PH-00@the-village.bc.nu>
Subject: Re: Is it bad to have lots of sleeping tasks?
Date: Fri, 24 Aug 2001 13:13:04 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Linus scheduler is pretty dire beyond about 8 runnable threads, but very
> good below that. It also has a refresh loop that is O(n) tasks, which is
> strange, and actually looks easily to eliminate.

So why not do it?  Or implement a nicer scheduler?  There are many good
ones.  There are o(1) schedulers that provide much better proportional
sharing.  They scale and also perform well even in "few running processes"
case.  They are also not hard to implement (I once implemented such a
scheduler with 100 lines of patch, and that fitted in the existing Linux
runqueue framework).  What's the resistence to scheduler changes?

> The critical bit is threads runnable at any given time. When that is low
as
> it is in almost all normal workloads the performance of the scheduler is
> very good indeed.
>
> > 2) If I have 1000 threads, and each calls sleep(), I assume that my
> ...
> > difference in the system's responsiveness?
>
> Read kernel/timer.c.
>
> Alan
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

