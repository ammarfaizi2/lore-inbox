Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268896AbRHFRZ6>; Mon, 6 Aug 2001 13:25:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268906AbRHFRZt>; Mon, 6 Aug 2001 13:25:49 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:16132 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S268896AbRHFRZj>; Mon, 6 Aug 2001 13:25:39 -0400
Subject: Re: /proc/<n>/maps growing...
To: torvalds@transmeta.com (Linus Torvalds)
Date: Mon, 6 Aug 2001 18:26:52 +0100 (BST)
Cc: jakub@redhat.com (Jakub Jelinek), andrea@suse.de (Andrea Arcangeli),
        david_luyer@pacific.net.au (David Luyer), linux-kernel@vger.kernel.org,
        davem@redhat.com (David S. Miller)
In-Reply-To: <Pine.LNX.4.33.0108061015450.8972-100000@penguin.transmeta.com> from "Linus Torvalds" at Aug 06, 2001 10:17:02 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15To9U-0001PL-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Even worse, it means people not using -ac kernels cannot malloc a lot of
> > memory but by recompiling the kernel.
> 
> Hey guys. Let's calm down a bit, and look at the problem.
> 
> Why the hell is glibc doing something so stupid in the first place? Yes,
> we can work around it, but it sounds like the glibc apporoach is slow and
> stupid even if we _did_ work around it. Mind explaining what the logic of
> "fixing" the kernel is?

Its two problems

1.	mprotect not doing the right resource checks
2.	mprotect not doing the simple merges

The resource one is a kernel problem. I am curious why only specific apps
trip the second case
