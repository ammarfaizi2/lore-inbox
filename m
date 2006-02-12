Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750718AbWBLQsj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750718AbWBLQsj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 11:48:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750811AbWBLQsj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 11:48:39 -0500
Received: from mtagate1.de.ibm.com ([195.212.29.150]:47268 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750718AbWBLQsi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 11:48:38 -0500
Date: Sun, 12 Feb 2006 17:48:22 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Ulrich Drepper <drepper@redhat.com>
Cc: Olaf Hering <olh@suse.de>, akpm@osdl.org, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
Subject: Re: [PATCH] updated fstatat64 support
Message-ID: <20060212164822.GA10250@osiris.ibm.com>
References: <200602101528.k1AFSFIg011658@devserv.devel.redhat.com> <20060211112157.GA9371@osiris.boeblingen.de.ibm.com> <20060212130903.GA20732@suse.de> <43EF6473.3090607@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43EF6473.3090607@redhat.com>
User-Agent: mutt-ng/devel (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > s390 doesnt compile because sys_newfstatat() is not defined.
> > __ARCH_WANT_STAT64 is defined for 32bit build in
> > include/asm-s390/unistd.h. This change fixes compilation, but its likely
> > not correct to do it that way:
> Indeed.  You most probably want to change the reference in the syscall
> table to sys_fstatat64.

I sent a patch which fixes this earlier today:

http://lkml.org/lkml/2006/2/12/37

Thanks,
Heiko
