Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262012AbUBWTm0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 14:42:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262013AbUBWTm0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 14:42:26 -0500
Received: from [64.62.200.227] ([64.62.200.227]:5794 "EHLO
	bluesmobile.specifixinc.com") by vger.kernel.org with ESMTP
	id S262012AbUBWTmX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 14:42:23 -0500
Subject: Re: Kernel Cross Compiling [update]
From: Jim Wilson <wilson@specifixinc.com>
To: Herbert Poetzl <herbert@13thfloor.at>
Cc: linux-kernel@vger.kernel.org, Judith Lebzelter <judith@osdl.org>,
       Dan Kegel <dank@kegel.com>, cliff white <cliffw@osdl.org>,
       "Timothy D. Witham" <wookie@osdl.org>
In-Reply-To: <20040222035350.GB31813@MAIL.13thfloor.at>
References: <20040222035350.GB31813@MAIL.13thfloor.at>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-11) 
Date: 23 Feb 2004 11:42:31 -0800
Message-Id: <1077565352.1054.22.camel@leaf.tuliptree.org>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-02-21 at 19:53, Herbert Poetzl wrote:
> Here is an update to the Kernel Cross Compiling thread 
> I started ten days ago ...

If you want gcc to be fixed so the inhibit_libc builds work for linux
targets, then I suggest opening an FSF gcc bugzilla bug report.  Sending
mail to me or to the linux kernel mailing list is unlikely to accomplish
this.

FYI David Mosberger sent me a comment in private mail pointing out that
if you are trying to bootstrap linux on a new target, then requiring a
glibc port before the kernel port is a problem.  I consider this a good
reason to make this feature work.

However, my recommendation still stands.  In general, I do not recommend
building inhibit_libc crosses for linux targets, even though such
crosses are likely to work fine for building a kernel.  As a gcc
maintainer, it makes my job harder when people are building the compiler
different ways, because I may get bug reports that I can't reproduce or
understand.  Also, there is a risk that a kernel-only cross compiler
will accidentally be used for some other purpose, resulting in a bug
report that wastes the time of the gcc maintainers.
-- 
Jim Wilson, GNU Tools Support, http://www.SpecifixInc.com

