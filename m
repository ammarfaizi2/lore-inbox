Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265633AbSLQRxI>; Tue, 17 Dec 2002 12:53:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265636AbSLQRxI>; Tue, 17 Dec 2002 12:53:08 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:3855 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265633AbSLQRxH>; Tue, 17 Dec 2002 12:53:07 -0500
Date: Tue, 17 Dec 2002 10:01:58 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ulrich Drepper <drepper@redhat.com>
cc: Dave Jones <davej@codemonkey.org.uk>, Ingo Molnar <mingo@elte.hu>,
       <linux-kernel@vger.kernel.org>, <hpa@transmeta.com>
Subject: Re: Intel P6 vs P7 system call performance
In-Reply-To: <3DFF6501.3080106@redhat.com>
Message-ID: <Pine.LNX.4.44.0212171000120.2702-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 17 Dec 2002, Ulrich Drepper wrote:
>
> If you don't like the process-global page thingy (anymore) the
> alternative would be a sysconf() system call.

Well, we do _have_ the process-global thingy now - it's the vsyscall page.
It's not settable by the process, but it's useful for information.
Together with an elf AT_ entry pointing to it, it's certainly sufficient
for this usage, and it should also be sufficient for "future use" (ie we
can add future system information in the page later: bitmaps of features
at offset "start + 128" for example).

		Linus

