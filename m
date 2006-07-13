Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932335AbWGMCee@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932335AbWGMCee (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 22:34:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932336AbWGMCee
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 22:34:34 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:939 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932335AbWGMCed (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 22:34:33 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Theodore Tso <tytso@mit.edu>
Cc: Andi Kleen <ak@suse.de>, Ulrich Drepper <drepper@redhat.com>,
       Arjan van de Ven <arjan@infradead.org>,
       "Randy.Dunlap" <rdunlap@xenotime.net>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, libc-alpha@sourceware.org
Subject: Re: [PATCH] Use uname not sysctl to get the kernel revision
References: <m1psgdkrt8.fsf@ebiederm.dsl.xmission.com>
	<m1hd1mafe0.fsf@ebiederm.dsl.xmission.com>
	<20060712232414.GI9040@thunk.org> <200607130131.46753.ak@suse.de>
	<20060713001222.GJ9040@thunk.org>
Date: Wed, 12 Jul 2006 20:33:05 -0600
In-Reply-To: <20060713001222.GJ9040@thunk.org> (Theodore Tso's message of
	"Wed, 12 Jul 2006 20:12:22 -0400")
Message-ID: <m13bd66xpa.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Tso <tytso@mit.edu> writes:

> That may be true, but it doesn't answer the question, what's the cost
> of leaving in sys_sysctl in there for now?  

Among other things the implementation of all of: 
CTL_KERN, {KERN_OSTYPE, KERN_OSRELEASE, KERN_OSREV, KERN_VERSION,
          KERN_SECUREMASK,KERN_PROF,KERN_NODENAME,KERN_DOMAINNAME }
are broken in kernel/sysctl.c because the locking is missing.

Eric
