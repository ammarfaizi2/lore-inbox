Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136152AbRDVOTv>; Sun, 22 Apr 2001 10:19:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136151AbRDVOTn>; Sun, 22 Apr 2001 10:19:43 -0400
Received: from [212.150.182.35] ([212.150.182.35]:59662 "EHLO
	exchange.guidelet.com") by vger.kernel.org with ESMTP
	id <S136150AbRDVOTT>; Sun, 22 Apr 2001 10:19:19 -0400
Message-ID: <001301c0cb3f$a550d490$910201c0@zapper>
From: "Alon Ziv" <alonz@nolaviz.org>
To: <linux-kernel@vger.kernel.org>
Cc: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <E14rJEP-0005l6-00@the-village.bc.nu>
Subject: Re: light weight user level semaphores
Date: Sun, 22 Apr 2001 17:19:38 +0200
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

Well, that's the reason for my small-negative-integer semaphore-FD idea...
(It won't support select() easily, but poll() is prob'ly good enough)
Still, there is the problem of read()/write()/etc. semantics; sure, we can
declare that 'negative FDs' have their own semantics which just happen to
include poll(), but it sure looks like a kludge...

    -az

----- Original Message -----
From: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
To: "Alon Ziv" <alonz@nolaviz.org>
Cc: <linux-kernel@vger.kernel.org>
Sent: Sunday, April 22, 2001 14:44
Subject: Re: light weight user level semaphores


> > All of this FD allocation stuff is truly distrurbing.
> > This appears to be the one place where Win32 got it (almost) right---
> > quite about every kernel object looks to userland just like an opaque
> > handle, and the same operations apply to all of them.
>
> Unix got this right, then AT&T broke it in System III. One very good
reason
> for pipe based semaphore stuff is precisely that it works in
poll/select/SIGIO
>
> Alan
>
>
>

