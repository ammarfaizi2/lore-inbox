Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753017AbWKLUBH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753017AbWKLUBH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 15:01:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753020AbWKLUBH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 15:01:07 -0500
Received: from aa013msr.fastwebnet.it ([85.18.95.73]:16836 "EHLO
	aa013msr.fastwebnet.it") by vger.kernel.org with ESMTP
	id S1753017AbWKLUBG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 15:01:06 -0500
Date: Sun, 12 Nov 2006 21:00:17 +0100
From: Paolo Ornati <ornati@fastwebnet.it>
To: pseelig@debian.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: 2.6.18.2 kernel BUG at mm/vmscan.c:606!
Message-ID: <20061112210017.5b42b880@localhost>
In-Reply-To: <45577194.4030406@debian.org>
References: <45577194.4030406@debian.org>
X-Mailer: Sylpheed-Claws 2.4.0 (GTK+ 2.8.19; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Nov 2006 20:10:12 +0100
Paul Seelig <pseelig@debian.org> wrote:

> Almost daily, my IBM ThinkPad T23 (Modell 2647-9RG) with 1GB of RAM and
> normally running the latest of Debian/unstable is getting an Oops
> displaying "kernel BUG at mm/vmscan.c:606!" in the syslog. This happened
> both with 2.6.18.1 and now 2.6.18.2 various times.

1) you don't have to run ksymoops with 2.6.x kernels (only with <=2.4.x)


2) your kernel is tainted:
ath_hal: module license 'Proprietary' taints kernel.

http://www.tux.org/lkml/#s1-18


3) your kernel is also patched (Suspend2 isn't in vanilla kernels)

Suspend2 Core.
Suspend2 Compression Driver loading.
Suspend2 Encryption Driver loading.


So I suggest you to reproduce the problem with a vanilla/not tainted
2.6.18.2:

http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.18.2.tar.bz2

-- 
	Paolo Ornati
	Linux 2.6.19-rc5 on x86_64
