Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261716AbUKHARx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261716AbUKHARx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 19:17:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261717AbUKHARx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 19:17:53 -0500
Received: from sweetums.bluetronic.net ([24.199.150.42]:14291 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id S261716AbUKHARw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 19:17:52 -0500
Date: Sun, 7 Nov 2004 19:15:33 -0500 (EST)
From: Ricky Beam <jfbeam@bluetronic.net>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
cc: <linux-kernel@vger.kernel.org>, Andy Lutomirski <luto@myrealbox.com>
Subject: Re: 32-bit segfaults on x86_64 in recent mm kernels
In-Reply-To: <200411072253.34806.rjw@sisk.pl>
Message-ID: <Pine.GSO.4.33.0411071910540.9358-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 Nov 2004, Rafael J. Wysocki wrote:
>This is because of the flex mmap patch for x86-64.  You can try the following
>workaround from Andi Kleen:
...
> #ifdef HAVE_ARCH_PICK_MMAP_LAYOUT
>-int sysctl_legacy_va_layout;
>+int sysctl_legacy_va_layout = 1;
> #endif

One does not need to patch the kernel to do this...

	% sysctl -w vm.legacy_va_layout=1

(some systems process an /etc/sysctl.conf during boot)

Of course, if you need 32bit apps before that can be set during boot-up,
messing with the kernel will be necessary.  I will point out, the sysctl
var totally disables flex mmap.

--Ricky


