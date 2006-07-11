Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965104AbWGKEKu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965104AbWGKEKu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 00:10:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965105AbWGKEKu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 00:10:50 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:58805 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S965104AbWGKEKt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 00:10:49 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sysctl: Document that sys_sysctl will be removed.
References: <m1psgdkrt8.fsf@ebiederm.dsl.xmission.com>
	<20060710155051.326e49da.rdunlap@xenotime.net>
Date: Mon, 10 Jul 2006 22:10:12 -0600
In-Reply-To: <20060710155051.326e49da.rdunlap@xenotime.net> (Randy Dunlap's
	message of "Mon, 10 Jul 2006 15:50:51 -0700")
Message-ID: <m1veq4kcij.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Randy.Dunlap" <rdunlap@xenotime.net> writes:

>
> aha, patch 1/2 and patch 2/2 would have helped that.  :)

Sorry.  I finally have found the original deprecation commit.

> commit 073cd7b5515a7f5b74dbb4917c717e3c390013e7
> Author: ak <ak>
> Date:   Sat Jul 12 16:45:55 2003 +0000
> 
>     [PATCH] Deprecate numerical sysctl
>     
>     Deprecate the numerical sysctl name space. People can use /proc/sys
>     instead.
>     
>     The numeric name space was never well maintained and especially
>     in distribution kernels is not very consistent (everybody has their
>     own extensions, conflicting with others). It's also a great
>     source of rejects when merging patches.  The name-based /proc/sys
>     is a much better interface for this, which people should use instead.
>     
>     Discussion of this on l-k found no advocate for it, so it seems to not
>     be very popular anyways.
>     
>     This patch deprecates numerical name space accesses to make it possible
>     to remove them in the future. The only exception is kernel.version,
>     which is used by glibc (this one has to be maintained forever)
>     
>     BKrev: 3f103b43JQH2fwSWpRLoTKziIiqH1w

The comment about kernel.version is odd. That information is available in
uname so I can't imagine why sys_sysctl would be an interesting source.
Also kernel.version is the compile string so it is pretty uninteresting
to glibc.

I guess if it is really needed someone will scream before the code gets
deleted completely.

Eric
