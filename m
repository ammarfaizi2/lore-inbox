Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262827AbTEBAbr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 20:31:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262831AbTEBAbr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 20:31:47 -0400
Received: from smtp-out.comcast.net ([24.153.64.115]:1927 "EHLO
	smtp-out.comcast.net") by vger.kernel.org with ESMTP
	id S262827AbTEBAbq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 20:31:46 -0400
Date: Thu, 01 May 2003 20:41:18 -0400
From: rmoser <mlmoser@comcast.net>
Subject: Re: Kernel source tree splitting
In-reply-to: <20030501170958.3f130646.rddunlap@osdl.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-kernel@vger.kernel.org
Message-id: <200305012041180300.00F3E2EE@smtp.comcast.net>
MIME-version: 1.0
X-Mailer: Calypso Version 3.30.00.00 (3)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
References: <200304301946130000.01139CC8@smtp.comcast.net>
 <20030430172102.69e13ce9.rddunlap@osdl.org>
 <20030501170958.3f130646.rddunlap@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



*********** REPLY SEPARATOR  ***********

On 5/1/2003 at 5:09 PM Randy.Dunlap wrote:

>On Wed, 30 Apr 2003 17:21:02 -0700 "Randy.Dunlap" <rddunlap@osdl.org>
>wrote:
>
>| Hi,
>|
>| I'm probably misreading this...but,
>|
>| Have you tried this yet?  Does it modify/customize all Kconfig
>| and Makefiles for the selected tree splits?
>|
>| A few days ago, in one tree, I rm-ed arch/{all that I don't need}
>| and drivers/{all that I don't need}.
>| After that I couldn't run "make *config" because it wants all of
>| those files, even if I don't want them.
>|
>| So there are many edits that needed to be done in lots of
>| Kconfig and Makefiles if one selectively pulls or omits certain
>| sub-directories.
>
>and on 2003-04-30 rddunlap wrote:
>| I seem to try for simple solutions when possible and feasible.
>|
>| In this case, if I were doing it, I would try changing (e.g.) in
>| arch/i386/kernel/Kconfig, this line:
>| source "drivers/eisa/Kconfig"
>| to
>| optsource "drivers/eisa/Kconfig"
>| where optsource means that the file is optional -- if not found,
>| ignore it.  And then see what happens, how far it can go,
>| what the next problem is....
>|
>| If this could be made to work, then entire subdirectories/subsystems
>| could be optional.
>
>So I did a proof-of-concept version of this, without modifying any
>source code.  I rm-ed arch/<many>, drivers/<many>, and fs/<many>
>and then wrote a shell script that looks for missing dirs, Kconfigs,
>and Makefile.lib files and puts empty ones back in their places.
>The shell script only works for what I rm-ed, but it could be made
>smarter if anyone wants to pursue this.  (attached)
>

Yes.  Well the build system (kernel configuration) would be modified
to instead of having a list of Kconfigs and dir's and Makefile.libs and
such, be able to scan a directory of files which tell it about those
things.  At least, in my design it would.

>After doing that I was able to build and boot that kernel, so it
>(concept) did work.
>

Well that's good.

>For a kernel source tree that hadn't been built/compiled in, the size
>was reduced from roughly 200 MB down to roughly 133 MB.
>

...............   You know.  Maybe it's not enough to split into categories.
Maybe it should be categories and categorical breakdowns.  I can see
3.0 or something (maybe even 2.8) reaching 1 gig.

--Bluefox Icy
>~Randy
>
>

