Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750958AbWCSUvg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750958AbWCSUvg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Mar 2006 15:51:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750987AbWCSUvg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Mar 2006 15:51:36 -0500
Received: from smtp.osdl.org ([65.172.181.4]:62378 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750937AbWCSUvf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Mar 2006 15:51:35 -0500
Date: Sun, 19 Mar 2006 12:47:01 -0800
From: Andrew Morton <akpm@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: viro@ftp.linux.org.uk, kernel-stuff@comcast.net,
       linux-kernel@vger.kernel.org, alex-kernel@digriz.org.uk,
       jun.nakajima@intel.com, davej@redhat.com
Subject: Re: OOPS: 2.6.16-rc6 cpufreq_conservative
Message-Id: <20060319124701.41e16e7b.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0603191217560.3826@g5.osdl.org>
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
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:
>
>  For me, it made a 4970 byte difference in code size.
>

That's about the same saving as uninlining first_cpu() and next_cpu()
provides.

Anything which iterates across multiple CPUs is cachemiss heaven - I doubt
if this is performance-critical code.  Or at least if it is, we have bigger
problems..

