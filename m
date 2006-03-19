Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751182AbWCSXIG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751182AbWCSXIG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Mar 2006 18:08:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751193AbWCSXIG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Mar 2006 18:08:06 -0500
Received: from smtp.osdl.org ([65.172.181.4]:42175 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751182AbWCSXIF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Mar 2006 18:08:05 -0500
Date: Sun, 19 Mar 2006 15:04:50 -0800
From: Andrew Morton <akpm@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: viro@ftp.linux.org.uk, kernel-stuff@comcast.net,
       linux-kernel@vger.kernel.org, alex-kernel@digriz.org.uk,
       jun.nakajima@intel.com, davej@redhat.com
Subject: Re: OOPS: 2.6.16-rc6 cpufreq_conservative
Message-Id: <20060319150450.3befd2e1.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0603191429580.3826@g5.osdl.org>
References: <200603181525.14127.kernel-stuff@comcast.net>
	<Pine.LNX.4.64.0603181321310.3826@g5.osdl.org>
	<20060318165302.62851448.akpm@osdl.org>
	<Pine.LNX.4.64.0603181827530.3826@g5.osdl.org>
	<Pine.LNX.4.64.0603191034370.3826@g5.osdl.org>
	<Pine.LNX.4.64.0603191050340.3826@g5.osdl.org>
	<Pine.LNX.4.64.0603191125220.3826@g5.osdl.org>
	<20060319194004.GZ27946@ftp.linux.org.uk>
	<Pine.LNX.4.64.0603191148160.3826@g5.osdl.org>
	<Pine.LNX.4.64.0603191217560.3826@g5.osdl.org>
	<20060319124701.41e16e7b.akpm@osdl.org>
	<Pine.LNX.4.64.0603191412270.3826@g5.osdl.org>
	<Pine.LNX.4.64.0603191429580.3826@g5.osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:
>
> Here's another uninlining patch if you want it.
>

Yes, the bitops need that.

We have a 50-patch series against the bitops code queued up.  It's from
Akinobu Mita.  It consolidates of all the C-coded operations which
archtectures are presently duplicating.  In toto:

 80 files changed, 1271 insertions(+), 4999 deletions(-)

It does include uninlining of the hweight functions, although I note that
include/asm-generic/bitops/__ffs.h remains inlined.  I don't know how many
architectures are using the generic code though.

