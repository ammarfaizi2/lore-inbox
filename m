Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261710AbUCDKAf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 05:00:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261613AbUCDKAf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 05:00:35 -0500
Received: from mx1.redhat.com ([66.187.233.31]:14469 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261710AbUCDKAO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 05:00:14 -0500
Date: Thu, 4 Mar 2004 05:00:06 -0500
From: Jakub Jelinek <jakub@redhat.com>
To: Dinesh Ahuja <mdlinux7@yahoo.co.in>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Using the Native POSIX Threading Library (NPTL) instead of linuxthreads.
Message-ID: <20040304100006.GQ31589@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <20040304093805.18936.qmail@web8304.mail.in.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040304093805.18936.qmail@web8304.mail.in.yahoo.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 04, 2004 at 09:38:05AM +0000, Dinesh Ahuja wrote:
> Hi Everbody,
> 
> I am new to Linux world and fascinated with it. I have
> an experience of 2.5 years in C++,C,COM,ATL,VC++ and
> want to get into Linux World.I have build and
> installed Linux Kernel 2.6.0 after struggling for four
> days.
> 
> I installed Linux 2.6.0 so that I should be able to
> work with NPTL which is POSIX1.b compliant. But, when
> I see ma for mq_open and mq_close functions, it
> doesn't shows me anything.

NPTL doesn't support _POSIX_MESSAGE_PASSING yet, because the
kernel doesn't support it yet (patches are floating around though
and as soon as kernel starts supporting NPTL will add support
for it).

> How can I see the detailed descriptions of the
> services provided by NPTL ? Please suggest me what are

#include <unistd.h> and check the various _POSIX_* macros
(or browse /usr/include/{,nptl/}bits/posix_opt.h) or use sysconf/getconf
(for mq_* sysconf (_SC_MESSAGE_PASSING) or getconf MESSAGE_PASSING).  See
http://www.opengroup.org/onlinepubs/007904975/basedefs/xbd_chap02.html
for details.

	Jakub
