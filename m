Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932099AbWHWAnw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932099AbWHWAnw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 20:43:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932153AbWHWAnw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 20:43:52 -0400
Received: from nz-out-0102.google.com ([64.233.162.194]:58472 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932097AbWHWAnv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 20:43:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kEtoHSO99bwo28qt2Lm11lZMtcTZbjDRADcbznMr76iJIkPk1UEGEPQM4K3yihBOeQaDHFeumR1pBXgFBBo+nHAI+mIw47e1FrUdIwVNVPRQ48VC3ajCZNj8Sx39d+eNimh8ULq4Hir7Tc/v5NpyBZaN5S3lIdhBjsgGzxt3nNY=
Message-ID: <b3f268590608221743o493080d0t41349bc4336bdd0b@mail.gmail.com>
Date: Wed, 23 Aug 2006 02:43:50 +0200
From: "Jari Sundell" <sundell.software@gmail.com>
To: "David Miller" <davem@davemloft.net>
Subject: Re: [take12 0/3] kevent: Generic event handling mechanism.
Cc: kuznet@ms2.inr.ac.ru, johnpol@2ka.mipt.ru, nmiell@comcast.net,
       linux-kernel@vger.kernel.org, drepper@redhat.com, akpm@osdl.org,
       netdev@vger.kernel.org, zach.brown@oracle.com, hch@infradead.org
In-Reply-To: <20060822.173200.126578369.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <b3f268590608221551q5e6a1057hd1474ee8b9811f10@mail.gmail.com>
	 <20060822231129.GA18296@ms2.inr.ac.ru>
	 <b3f268590608221728r6cffd03i2f2dd12421b9f37@mail.gmail.com>
	 <20060822.173200.126578369.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/23/06, David Miller <davem@davemloft.net> wrote:
> > There are system calls that take timespec, so I assume the magic is
> > already available for handling the timeout argument of kevent.
>
> System calls are one thing, they can be translated for these
> kinds of situations.  But this doesn't help, and nothing at
> all can be done, for datastructures exposed to userspace via
> mmap()'d buffers, which is what kevent will be doing.
>
> This is what Alexey is trying to explain to you.

Actually, I didn't miss that, it is an orthogonal issue. A timespec
timeout parameter for the syscall does not imply the use of timespec
in any timer event, etc. Nor is there any timespec timer in kqueue's
struct kevent, which is the only (interface related) thing that will
be exposed.

Rakshasa
