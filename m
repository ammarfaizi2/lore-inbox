Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130414AbQKGIuq>; Tue, 7 Nov 2000 03:50:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130495AbQKGIug>; Tue, 7 Nov 2000 03:50:36 -0500
Received: from shell.webmaster.com ([209.133.28.73]:60893 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S130414AbQKGIu2>; Tue, 7 Nov 2000 03:50:28 -0500
From: "David Schwartz" <davids@webmaster.com>
To: "Andrej Hosna" <hosna@ibl.sk>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: malloc(1/0) ??
Date: Tue, 7 Nov 2000 00:50:26 -0800
Message-ID: <NCBBLIEPOCNJOAEKBEAKMEAPLMAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
In-Reply-To: <00110709373507.05397@adino>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > The program can't possibly work because it invokes undefined
> behavior. It
> > is impossible to determine what a program that invokes
> undefined behavior is
> > 'supposed to do'.
>
> I dont think it's undefined behaviour ...

	You are correct. This is bahavior that is undefined by the C language, but
defined by the implementation. So determining what the program was supposed
to do requires determining whether the person who wrote it was familiar with
the implementation on which it is being used. Amusingly, this means the
program is supposed to do different things depending upon what
implementation of malloc you have.

	IIRC, malloc(0) is defined to return a unique block of memory that it is
valid to pass to free. However, doing anything with this memory (read/write)
is undefined by the C standard.

	DS

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
