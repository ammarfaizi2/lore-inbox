Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751237AbWGLPck@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751237AbWGLPck (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 11:32:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751399AbWGLPck
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 11:32:40 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:41623 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751237AbWGLPcj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 11:32:39 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sysctl: Allow /proc/sys without sys_sysctl
References: <m1u05pkruk.fsf@ebiederm.dsl.xmission.com>
	<200607121532.05227.ak@suse.de>
	<m1ac7edgne.fsf@ebiederm.dsl.xmission.com>
	<200607121652.21920.ak@suse.de>
Date: Wed, 12 Jul 2006 09:32:02 -0600
In-Reply-To: <200607121652.21920.ak@suse.de> (Andi Kleen's message of "Wed, 12
	Jul 2006 16:52:21 +0200")
Message-ID: <m1lkqyc00d.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> writes:

>> So it will correctly handle that sysctl being compiled out, and
>> the fallback to using /proc.  The code seems to have been
>> doing that since it was added to glibc in 2000.
>
> Using /proc is extremly slow for this.

How so it is the same code in the kernel.  Is open much slower than
sys_sysctl?

> You added significant cost to each program startup.

Not each program only the ones that use pthreads.

> I still think it's a good idea to simulate that sysctl and printk
> the others.

To reduce the noise something like that makes sense.  I'm going to
see if I can get glibc to use uname which should have the same effect.

Eric
