Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281480AbRKRW2V>; Sun, 18 Nov 2001 17:28:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281490AbRKRW2M>; Sun, 18 Nov 2001 17:28:12 -0500
Received: from mailout5-1.nyroc.rr.com ([24.92.226.169]:46378 "EHLO
	mailout5.nyroc.rr.com") by vger.kernel.org with ESMTP
	id <S281480AbRKRW2C>; Sun, 18 Nov 2001 17:28:02 -0500
Message-ID: <053d01c1707e$8c941630$1a01a8c0@allyourbase>
From: "Dan Maas" <dmaas@dcine.com>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: <linux-kernel@vger.kernel.org>, "war" <war@starband.net>,
        <stilgar2k@wanadoo.fr>
In-Reply-To: <fa.inl6g6v.1mmbp4@ifi.uio.no> <fa.heevhav.sjs8an@ifi.uio.no>
Subject: Re: Swap
Date: Sun, 18 Nov 2001 17:15:36 -0500
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

> >Yep. There's a reason for that: the kernel is *ALWAYS*
> >able to swap pages out to disk - even without "swap space".
> >Disabling swapspace simply forces the kernel to swap out
> >more code, since it cannot swap out any data.
>
> Sure ??? Where ?? What disk space uses it to swap pages to ?

The executables and binaries on your regular filesystems... Even with no
swap space, the kernel can "page out" (i.e. drop from memory) read-only file
mappings, since they can always be reloaded from disk if needed.

In other words, there is still a big difference between running without swap
space, and having every program do an mlockall() (which *really* forces all
pages to be permanently resident in RAM).

Still, it puzzles me why a system with no swap space would appear to be more
responsive than one with swap (assuming their working sets are quite a bit
smaller than total amount of RAM)... Can you do a controlled test somehow,
to rule out any sort of placebo effect?

Regards,
Dan

