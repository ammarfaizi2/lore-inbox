Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267363AbUJBJ2r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267363AbUJBJ2r (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 05:28:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267368AbUJBJ2r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 05:28:47 -0400
Received: from [205.233.218.70] ([205.233.218.70]:13577 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S267363AbUJBJ2p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 05:28:45 -0400
Subject: Re: [patch] inotify: make user visible types portable
From: David Woodhouse <dwmw2@infradead.org>
To: Robert Love <rml@novell.com>
Cc: John McCutchan <ttb@tentacle.dhs.org>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
In-Reply-To: <1096583447.4203.88.camel@betsy.boston.ximian.com>
References: <1096410792.4365.3.camel@vertex>
	 <1096583108.4203.86.camel@betsy.boston.ximian.com>
	 <1096583447.4203.88.camel@betsy.boston.ximian.com>
Content-Type: text/plain
Date: Sat, 02 Oct 2004 10:21:59 +0100
Message-Id: <1096708920.5191.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 (2.0.1-2) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-09-30 at 18:30 -0400, Robert Love wrote:
> On Thu, 2004-09-30 at 18:25 -0400, Robert Love wrote:
> 
> > (speaking of which, we had 'mask' as an 'unsigned long' inside inotify.c,
> > so this change was needed anyhow).
> 
> Ugh.  We _also_ add mask sprinkled about as an int.
> 
> This patch makes those __u32 types, too.

Don't want for the cleanup of kernel headers to be done by someone else.
Stop polluting them more. Take the user-visible structures and put them
into a separate header file, possibly in a separate directory. Then
include that from your kernel header. Then there's _already_ a
'sanitised' header file for userspace. See the contents of include/mtd/
for an example, although I think there may be one or two things in there
I still need to clean up.

I probably still need to change some __u32 to uint32_t for portability,
for example. You should do that too.

-- 
dwmw2

