Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261582AbSJAL2E>; Tue, 1 Oct 2002 07:28:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261583AbSJAL2E>; Tue, 1 Oct 2002 07:28:04 -0400
Received: from mta05bw.bigpond.com ([139.134.6.95]:1996 "EHLO
	mta05bw.bigpond.com") by vger.kernel.org with ESMTP
	id <S261582AbSJAL2D>; Tue, 1 Oct 2002 07:28:03 -0400
Message-ID: <090e01c2693e$4a32fea0$41368490@archaic>
From: "David McIlwraith" <quack@bigpond.net.au>
To: "Martin Diehl" <lists@mdiehl.de>
Cc: <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.21.0210011324110.485-100000@notebook.diehl.home>
Subject: Re: calling context when writing to tty_driver
Date: Tue, 1 Oct 2002 21:32:56 +1000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.3663.0
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3663.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Spinlocks *could* be used in place, if this is the case. Having not examined
the code, I don't know the implementation specifics.

----- Original Message -----
From: "Martin Diehl" <lists@mdiehl.de>
To: "David McIlwraith" <quack@bigpond.net.au>
Cc: "Martin Diehl" <lists@mdiehl.de>; <linux-kernel@vger.kernel.org>
Sent: Tuesday, October 01, 2002 9:28 PM
Subject: Re: calling context when writing to tty_driver


> On Tue, 1 Oct 2002, David McIlwraith wrote:
>
> > Semaphores may sleep - therefore, they cannot be used from a 'non-sleep'
> > context.
>
> Yes, sure. Sorry if I wasn't clear enough - the point is whether those
> tty_driver write/write_room() calls are allowed to sleep or not. If yes,
> the usbserial implementation is right and it is impossible to do further
> writing directly from write_wakeup() callback (which would be really bad
> IMHO) - if not, usbserial needs to avoid the down() somehow.
>
> Martin
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

