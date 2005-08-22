Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751088AbVHVXhY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751088AbVHVXhY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 19:37:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751309AbVHVXhX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 19:37:23 -0400
Received: from sp-260-1.net4.netcentrix.net ([4.21.254.118]:7955 "EHLO
	asmodeus.mcnaught.org") by vger.kernel.org with ESMTP
	id S1751088AbVHVXhW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 19:37:22 -0400
To: "Terry" <tmacmill@rivernet.net>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: Incorrect RAM Detected at kernel init
References: <001001c5a6c9$7a0e1df0$6301a8c0@finian.net>
From: Douglas McNaught <doug@mcnaught.org>
Date: Mon, 22 Aug 2005 19:36:59 -0400
In-Reply-To: <001001c5a6c9$7a0e1df0$6301a8c0@finian.net> (Terry's message of "Sun, 21 Aug 2005 23:27:51 -0400")
Message-ID: <m23bp11r38.fsf@Douglas-McNaughts-Powerbook.local>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (darwin)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Terry" <tmacmill@rivernet.net> writes:

> The kernel appears to compile perfectly, installs fine, but after reboot it
> is only reporting 16M of RAM. I have tried with and without the mem=768M

I've seen this happen with BIOSes of your vintage when there's a
"memory hole at 16M" turned on--the kernel doesn't see anything beyond
it.  See if you can get into the Setup program and turn that off.

Since earlier kernels work, the later kernels are probably trusting
the e820 tables which may not be set up properly...

[Not that I know that much about this stuff]

-Doug
