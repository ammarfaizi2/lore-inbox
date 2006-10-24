Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161022AbWJXM37@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161022AbWJXM37 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 08:29:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161025AbWJXM37
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 08:29:59 -0400
Received: from cantor2.suse.de ([195.135.220.15]:9418 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1161022AbWJXM36 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 08:29:58 -0400
From: Andi Kleen <ak@suse.de>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH 1/2] x86_64 irq: Simplify the vector allocator.
Date: Mon, 23 Oct 2006 22:29:05 -0700
User-Agent: KMail/1.9.1
Cc: Muli Ben-Yehuda <muli@il.ibm.com>, Yinghai Lu <yinghai.lu@amd.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
References: <200610212100.k9LL0GtC018787@hera.kernel.org> <20061022085216.GQ5211@rhun.haifa.ibm.com> <m1ods3y7nc.fsf_-_@ebiederm.dsl.xmission.com>
In-Reply-To: <m1ods3y7nc.fsf_-_@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610232229.06240.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 22 October 2006 21:32, Eric W. Biederman wrote:
> There is no reason to remember a per cpu position of which vector
> to try.  Keeping a global position is simpler and more likely to
> result in a global vector allocation even if I don't need or require
> it.  For level triggered interrupts this means we are less likely to
> acknowledge another cpus irq, and cause the level triggered irq to
> harmlessly refire.
>
> This simplification makes it easier to only access data structures
> of  online cpus, by having fewer special cases to deal with.

Shouldn't this and the following patch be done on i386 too? 

-Andi

