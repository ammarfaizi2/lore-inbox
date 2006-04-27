Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030211AbWD0Tmc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030211AbWD0Tmc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 15:42:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965069AbWD0Tmb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 15:42:31 -0400
Received: from xenotime.net ([66.160.160.81]:59369 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S964928AbWD0Tmb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 15:42:31 -0400
Date: Thu, 27 Apr 2006 12:44:52 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Andi Kleen <ak@suse.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: checklist (Re: 2.6.17-rc2-mm1)
Message-Id: <20060427124452.432ad80d.rdunlap@xenotime.net>
In-Reply-To: <200604272126.30683.ak@suse.de>
References: <20060427014141.06b88072.akpm@osdl.org>
	<p73vesv727b.fsf@bragg.suse.de>
	<20060427121930.2c3591e0.akpm@osdl.org>
	<200604272126.30683.ak@suse.de>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > So at this point in time what I'd like to do is to encourage developers to
> > do these very basic things.  That's the low-hanging fruit right now.
> 
> Write a checklist for that?

I've been meaning to write up one myself, so I'll give it a shot.

This is all above and beyond good patch log descriptions.


1.  Build cleanly with applicable or modified CONFIG options =y, =m, and =n.
    No gcc warnings/errors, no linker warnings/errors.

2.  Build on multiple CPU arch-es by using local cross-compile tools
    or something like PLM at OSDL.

3.  Check cleanly with sparse.

4.  Make sure that any new or modified CONFIG options don't muck up
    the config menu.

5.  Use 'make checkstack' and 'make namespacecheck' and fix any
    problems that they find.  Note:  checkstack does not point out
    problems explicitly, but any one function that uses more than
    512 bytes on the stack is a candidate for change.

6.  Include kernel-doc to document global kernel APIs.  (Not required
    for static functions, but OK there also.)  Use 'make htmldocs'
    or 'make mandocs' to check the kernel-doc and fix any issues.


---
~Randy
