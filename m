Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286343AbSA1Vmp>; Mon, 28 Jan 2002 16:42:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286336AbSA1Vmf>; Mon, 28 Jan 2002 16:42:35 -0500
Received: from colorfullife.com ([216.156.138.34]:64525 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S286303AbSA1Vm0>;
	Mon, 28 Jan 2002 16:42:26 -0500
Message-ID: <001401c1a844$ae7c51b0$010411ac@local>
From: "Manfred Spraul" <manfred@colorfullife.com>
To: "Daniel Jacobowitz" <dan@debian.org>
Cc: <linux-kernel@vger.kernel.org>, "Andrew Morton" <akpm@zip.com.au>
Subject: Re: [PATCH?] Crash in 2.4.17/ptrace
Date: Mon, 28 Jan 2002 22:33:35 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >
> > Not with this patch, I'm afraid.  For your testing purposes you
> > could just remove the VALID_PAGE() test in
mm/memory.c:get_page_map(),
> > and then gdb should be able to get at the framebuffer.
>
> I'm sure there's a good reason to not do that in general.  Mind
> enlightening me?

Please don't do it at all.
The test is there to ensure that there is a 'struct page' for address
found in the pages tables.
For framebuffers addresses, there is no page structure, and then the
page reference count updates read/write to random memory.

--
    Manfred

