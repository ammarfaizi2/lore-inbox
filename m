Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131104AbRCGQXt>; Wed, 7 Mar 2001 11:23:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131105AbRCGQXj>; Wed, 7 Mar 2001 11:23:39 -0500
Received: from colorfullife.com ([216.156.138.34]:50443 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S131104AbRCGQX3>;
	Wed, 7 Mar 2001 11:23:29 -0500
Message-ID: <003701c0a722$f6b02700$5517fea9@local>
From: "Manfred Spraul" <manfred@colorfullife.com>
To: "Jamie Lokier" <lk@tantalophile.demon.co.uk>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <000201c0a71f$3a48fae0$5517fea9@local> <20010307171020.A10607@pcep-jamie.cern.ch>
Subject: Re: Hashing and directories
Date: Wed, 7 Mar 2001 17:23:26 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Jamie Lokier" <lk@tantalophile.demon.co.uk>
> Manfred Spraul wrote:
> > I'm not sure that this is the right way: It means that every exec()
> > must call dup_mmap(), and usually only to copy a few hundert
> > bytes. But I don't see a sane alternative. I won't propose to
> > create a temporary file in a kernel tmpfs mount ;-)
>
> Every exec creates a whole new mm anyway, after copying data from the
> old mm.  The suggestion is to create the new mm before copying the
> data, and to copy the data from the old mm directly to the new one.
>

exec_mmap currenly avoids mm_alloc()/activate_mm()/mm_drop() for single
threaded apps, and that would become impossible.
I'm not sure how expensive these calls are.

--
    Manfred


