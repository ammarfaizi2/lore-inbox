Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262809AbTEGEBs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 00:01:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262810AbTEGEBs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 00:01:48 -0400
Received: from pizda.ninka.net ([216.101.162.242]:53484 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262809AbTEGEBr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 00:01:47 -0400
Date: Tue, 06 May 2003 20:06:38 -0700 (PDT)
Message-Id: <20030506.200638.78728404.davem@redhat.com>
To: dwmw2@infradead.org
Cc: thomas@horsten.com, hch@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.21-rc1: byteorder.h breaks with __STRICT_ANSI__
 defined (trivial)
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <1052255946.7532.66.camel@imladris.demon.co.uk>
References: <1052215397.983.25.camel@rth.ninka.net>
	<200305061510.04619.thomas@horsten.com>
	<1052255946.7532.66.camel@imladris.demon.co.uk>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: David Woodhouse <dwmw2@infradead.org>
   Date: Tue, 06 May 2003 22:19:06 +0100

   The correct fix is to provide a userland-only version of cdrom.h which
   doesn't use the private kernel types.h. Or a file containing _only_
   those parts which can be shared between kernel and userland, defined
   using standard types such as uint32_t etc. 

Correct in your world only :-)

Listen, what do you think is the latency every time I add something
to rtnetlink.h or pfkeyv2.h?  Should I just sit and twiddle my thumbs
waiting for everyone to update their glibc or kernel-headers or
whatever package before they can compile networking apps using the
new feature?

The fact is, until that issue is solved, we have to assume that
programs are going to include kernel headers and there is nothing
we can do about it until we provide a better situation than exists
now.

Therefore, making inclusions of these kinds of headers work from
userspace is in some sense a requirement.
