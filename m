Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263338AbTETAbC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 20:31:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263349AbTETAbC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 20:31:02 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:56673 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP id S263338AbTETAa7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 20:30:59 -0400
To: Valdis.Kletnieks@vt.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: Recent changes to sysctl.h breaks glibc
References: <20030519165623.GA983@mars.ravnborg.org>
	<Pine.LNX.4.44.0305191039320.16596-100000@home.transmeta.com>
	<babhik$sbd$1@cesium.transmeta.com>
	<m1d6ie37i8.fsf@frodo.biederman.org> <3EC95B58.7080807@zytor.com>
	<m18yt235cf.fsf@frodo.biederman.org> <3EC9660D.2000203@zytor.com>
	<m14r3q331h.fsf@frodo.biederman.org>
	<200305200024.h4K0OnPc025466@turing-police.cc.vt.edu>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 19 May 2003 18:40:18 -0600
In-Reply-To: <200305200024.h4K0OnPc025466@turing-police.cc.vt.edu>
Message-ID: <m1y9121mdp.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu writes:

> On Mon, 19 May 2003 17:55:06 MDT, Eric W. Biederman said:
> > If things must be maintained in concert it is a bug.  
> > 
> > With a fixed ABI people take advantage of new features as they
> > care for them.  And in general to use new features requires new code.
> 
> And if the kernel headers aren't maintained in concert with the kernel,
> new userspace code can't reach the new features.
> 
> Therefor, by your definition, the current situation is a bug.

Yes, glibc uses kernel headers.

> Try compiling code that uses futexes on a system that has a kernel that
> supports them, but kernel-headers that haven't been upgraded to mention them.
> The kernel has the new code, the userspace has the new code, but gcc will
> turn around and whinge about the new code because there's a piece missing in
> between.  So people *CANT* take advantage of the new features (unless they
> do something silly like drag their own foo.h file around where it can get
> out of sync with reality).

Or the build against a library that does that.  There are not that
many libraries.

For a lot of system calls it is actively dangerous to assume dev_t ==
__kernel_dev_t.  As glibc does some cute things in there.

Eric
