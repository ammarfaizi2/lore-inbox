Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263170AbTIJNwA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 09:52:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263561AbTIJNwA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 09:52:00 -0400
Received: from hal-5.inet.it ([213.92.5.24]:52917 "EHLO hal-5.inet.it")
	by vger.kernel.org with ESMTP id S263170AbTIJNv6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 09:51:58 -0400
Message-ID: <04aa01c377a3$4e3cfc20$5aaf7450@wssupremo>
Reply-To: "Luca Veraldi" <luca.veraldi@katamail.com>
From: "Luca Veraldi" <luca.veraldi@katamail.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
References: <00f201c376f8$231d5e00$beae7450@wssupremo> <20030909175821.GL16080@Synopsys.COM> <001d01c37703$8edc10e0$36af7450@wssupremo> <20030910064508.GA25795@Synopsys.COM> <015601c3777c$8c63b2e0$5aaf7450@wssupremo> <1063185795.5021.4.camel@laptop.fenrus.com> <01c601c3777f$97c92680$5aaf7450@wssupremo> <1063198060.32726.32.camel@dhcp23.swansea.linux.org.uk>
Subject: Re: Efficient IPC mechanism on Linux
Date: Wed, 10 Sep 2003 15:56:14 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Probably, it is worse the case of copying a memory page,
> > because you have to hold some global lock all the time.
> > This is deadly in an SMP environment,
>
> You don't need a global lock to copy memory.

See sources. You neek to lock_kernel() for a great amount of instructions
like any nother kernel function.

There are kernel locks all around in sources.
So don't come here and talk about locking ineffiency.
Because scarse scalability of Linux on multiprocessor
is a reality nobody can hide.

With or without my primitives.

> One thing I do agree with you on is the API aspect - and that is
> problematic. The current API leaves data also owned by the source.
> If I write "fred" down a pipe I still own the "fred" bits.

Even with my API. Data doesn't disapper magically
from the sender logical address space.

Also, with minor changes, you can use my primitives
to implement a one-copy channel, if shared memory among processes
sounds to you as a blasfemy.

Always better than two-fase-copying current pipe implementation.

> The
> method you propose was added long ago go to Solaris (see "doors") and
> its not exactly the most used interface even there.

Sincerely, I COMPLETELY DON'T CARE.
If it is used or not, it's completely irrilevant, when valueing performance.

Good bye.
Luca

