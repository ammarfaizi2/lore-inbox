Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932141AbVH3OQh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932141AbVH3OQh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 10:16:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932145AbVH3OQh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 10:16:37 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:3971 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932141AbVH3OQg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 10:16:36 -0400
Subject: Re: [PATCH] i386, x86_64 Initial PAT implementation
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Andi Kleen <ak@suse.de>
In-Reply-To: <m1psrwmg10.fsf@ebiederm.dsl.xmission.com>
References: <m1psrwmg10.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 30 Aug 2005 15:45:36 +0100
Message-Id: <1125413136.8276.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-08-29 at 18:20 -0600, Eric W. Biederman wrote:
> ways.  Currently this code only allows for an additional flavor
> of uncached access to physical memory addresses which should be hard
> to abuse, and should raise no additional aliasing problems.  No
> attempt has been made to fix theoretical aliasing problems.

Even an uncached/cached alias causes random memory corruption or an MCE
on x86 systems. In fact it can occur even for an alias not in theory
touched by the CPU if it happens to prefetch into or speculate the
address.

Also be sure to read the PII Xeon errata - early PAT has a bug or two.

Definitely a much needed improvement to the kernel though.

