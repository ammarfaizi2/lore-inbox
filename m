Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261964AbTJAHlo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 03:41:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261967AbTJAHlo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 03:41:44 -0400
Received: from ns.suse.de ([195.135.220.2]:2533 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261964AbTJAHln (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 03:41:43 -0400
Date: Wed, 1 Oct 2003 09:41:42 +0200
From: Andi Kleen <ak@suse.de>
To: Jamie Lokier <jamie@shareable.org>
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Mutilated form of Andi Kleen's AMD prefetch errata patch
Message-ID: <20031001074142.GM15853@wotan.suse.de>
References: <7F740D512C7C1046AB53446D3720017304AFCF@scsmsx402.sc.intel.com.suse.lists.linux.kernel> <20031001053833.GB1131@mail.shareable.org.suse.lists.linux.kernel> <20030930224853.15073447.akpm@osdl.org.suse.lists.linux.kernel> <20031001061348.GE1131@mail.shareable.org.suse.lists.linux.kernel> <20030930233258.37ed9f7f.akpm@osdl.org.suse.lists.linux.kernel> <p73k77pzc69.fsf@oldwotan.suse.de> <20031001000015.69007e85.akpm@osdl.org> <20031001070620.GK15853@wotan.suse.de> <20031001073132.GK1131@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031001073132.GK1131@mail.shareable.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 01, 2003 at 08:31:32AM +0100, Jamie Lokier wrote:
> doesn't that fix the problem and while also being an improvement in
> lots of other ways?  The only reason it wouldn't work is if the VMA
> list can contain regions >= TASK_SIZE, but I don't think that is done.

vsyscalls has at least one vma > TASK_SIZE for ptrace, but it is afaik not
included in the vma tree.

> search_exception_table doesn't take any locks for non-module entries,
> so it can fixup the __get_user in __is_prefetch when that occurs
> inside locked regions of the kernel.

Hmm. Good point. Yes, I agree the check could be removed now.

-Andi
