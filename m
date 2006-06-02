Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751287AbWFBWN6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751287AbWFBWN6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 18:13:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751318AbWFBWN5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 18:13:57 -0400
Received: from xenotime.net ([66.160.160.81]:36044 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751287AbWFBWN4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 18:13:56 -0400
Date: Fri, 2 Jun 2006 15:16:39 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Ben Collins <bcollins@ubuntu.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Updated v3]: How to become a kernel driver maintainer
Message-Id: <20060602151639.7ce749c7.rdunlap@xenotime.net>
In-Reply-To: <1149284317.4533.312.camel@grayson>
References: <1136736455.24378.3.camel@grayson>
	<1136756756.1043.20.camel@grayson>
	<1136792769.2936.13.camel@laptopd505.fenrus.org>
	<1136813649.1043.30.camel@grayson>
	<1136842100.2936.34.camel@laptopd505.fenrus.org>
	<1141841013.24202.194.camel@grayson>
	<9a8748490603081105i3468fa84haac329d1e50faed4@mail.gmail.com>
	<1141845047.12175.7.camel@laptopd505.fenrus.org>
	<9a8748490603081127r1b830c5bg94f42e021e2a2d58@mail.gmail.com>
	<1149284317.4533.312.camel@grayson>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 02 Jun 2006 17:38:36 -0400 Ben Collins wrote:

> This got back-burnered for awhile, but here's the fixed up copy from the
> last round of feedback. Thanks to everyone that's given input. It's all
> been helpful and I think this copy reflects everything that was
> discussed last time.
> 
> If there's no major changes requested, the next time will be in diff
> format for Documentation/ inclusion.

Having the text inline for review/comments sure would be a lot
easier on reviewers.


| There are also many targets in the kernel build system (KBuild) that will
| help check your code as well. These targets are listed if you type "make
| help" in the kernel tree. Some targets of note are, checkstack,
| buildcheck and namespacecheck. You can also add C=1 to the make arguments,
| in order to use the sparse tool for checking your code.

'buildcheck' is gone.  It is done automatically at the end of
every build.

Grammar fixes:
Some targets of note are "checkstack" and "namespacecheck".
You can also add C=1 to the 'make' arguments
in order to use the sparse tool for checking your code.

|   - When creating the Kconfig entries

I would add something like:
Also do not enable (y or m) Kconfig options by default.
Users should enable them and we don't want to increase kernel size
for people who don't need this.

Spello:
and your users (and is often times seen as a rite of passage).
"oftentimes"
and later:
Often times, it is necessary
"Oftentimes,"

| This is where some maintainers fail, and is the reason the kernel
| developers are so reluctant to allow new drivers into the main tree.

I still disagree with that conclusion (as I also wrote on
8-Mar-2006).  I think that it's basically a matter of if the
(driver) submitter is willing to do the work as documented in
Documentation/* and listen to review feedback and act on that
or explain why changes shouldn't be made, then the code will
likely be accepted (if it's *correct*, of course).

| There are times where changes
should be
"times when" or "places where"


---
~Randy
