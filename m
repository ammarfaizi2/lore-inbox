Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263660AbRFHTNB>; Fri, 8 Jun 2001 15:13:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264291AbRFHTMv>; Fri, 8 Jun 2001 15:12:51 -0400
Received: from codeblau.walledcity.de ([212.84.209.34]:27915 "EHLO codeblau.de")
	by vger.kernel.org with ESMTP id <S264256AbRFHTMg>;
	Fri, 8 Jun 2001 15:12:36 -0400
Date: Fri, 8 Jun 2001 21:12:47 +0200
From: Felix von Leitner <leitner@fefe.de>
To: "David S. Miller" <davem@redhat.com>
Cc: Felix von Leitner <leitner@fefe.de>, linux-kernel@vger.kernel.org
Subject: Re: Linux kernel headers violate RFC2553
Message-ID: <20010608211247.A12925@codeblau.de>
In-Reply-To: <20010608195719.A4862@fefe.de> <15137.8668.590390.10485@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
In-Reply-To: <15137.8668.590390.10485@pizda.ninka.net>; from davem@redhat.com on Fri, Jun 08, 2001 at 12:05:00PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thus spake David S. Miller (davem@redhat.com):
>  > glibc works around this, but the diet libc uses the kernel headers and
>  > thus exports the wrong API to user land.
> Don't user kernel headers for userspace.

What choice do I have?
Duplicate everything and then be out of sync when the specs change?

Using glibc-2.1.* for IPv6 did not work for 2.4 kernels for more than
ONE YEAR because of this, then glibc 2.2 became available.  I am not
willing to follow this shining example of "Linux brokenness" that is
still being laughed about by avid BSD followers.

I hereby volunteer to submit patches for all places where the kernel
headers are not RFC compliant.  The kernel headers are actually
_intended_ to be used from user space, as kernel specific parts are
escaped using "#ifdef __KERNEL__" all over the place.  What reason would
there be for this if the kernel headers were not used from user space?

Even when using glibc the kernel headers are included in most programs.

> Kernel headers and user headers are distinctly different namespaces,
> and you have pointed out only one of many places where we use
> different names/structures/etc. for some kernel networking headers
> vs. what userspace wants.

Then, with all due respect, those places should be fixed.

There is no excuse for sloppy code and sloppy interfaces.  At any rate,
"don't use our code, then" is not a valid excuse in my humble opinion.

Felix
