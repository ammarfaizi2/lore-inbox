Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261249AbVG0X1d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261249AbVG0X1d (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 19:27:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261238AbVG0X13
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 19:27:29 -0400
Received: from smtp.osdl.org ([65.172.181.4]:25289 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261195AbVG0X1L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 19:27:11 -0400
Date: Wed, 27 Jul 2005 16:26:04 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Brown, Len" <len.brown@intel.com>
Cc: thecwin@gmail.com, acpi-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: ACPI buttons in 2.6.12-rc4-mm2
Message-Id: <20050727162604.66efd801.akpm@osdl.org>
In-Reply-To: <F7DC2337C7631D4386A2DF6E8FB22B300428CA9E@hdsmsx401.amr.corp.intel.com>
References: <F7DC2337C7631D4386A2DF6E8FB22B300428CA9E@hdsmsx401.amr.corp.intel.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Brown, Len" <len.brown@intel.com> wrote:
>
> 
> >Len Brown <len.brown@intel.com> wrote:
> >> I deleted /proc/acpi/button on purpose,
> >> did you have a use for those files?
> >
> >Can we put it back, please?
> 
> of course.

Thanks.

> >We cannot go ripping out stuff which applications and users 
> >are currently using without quite a lot of preparation.
> 
> Agreed.  Although the implementation of the /proc lid status
> file is fundamentally flawed in that even its name in /proc
> is able to change and thus it is a totally bogus user-space API,
> it was not thoughtful to delete it.
> 
> I'm open to suggestions on how to approach this transition.
> I can make ACPI_PROC a static build option -- what else
> can I do to ease the transition in this, our stable release?

Well I don't know how awkward this would be from an implementation POV, but
can we just leave the legacy /proc stuff there until the /sys interface is
all in place and userspace is upgraded?  Then kill all the /proc stuff
later?

We could also print a rude message the first time someone tries to use a
deprecated /proc file, just to help push the userspace tool developers
along.  Although I note that sys_bdflush() is still with us ;)

