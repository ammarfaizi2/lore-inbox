Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263663AbUJ3COx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263663AbUJ3COx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 22:14:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263462AbUJ3COw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 22:14:52 -0400
Received: from cantor.suse.de ([195.135.220.2]:33754 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263459AbUJ3COF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 22:14:05 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Semaphore assembly-code bug
References: <417550FB.8020404@drdos.com.suse.lists.linux.kernel>
	<1098218286.8675.82.camel@mentorng.gurulabs.com.suse.lists.linux.kernel>
	<41757478.4090402@drdos.com.suse.lists.linux.kernel>
	<20041020034524.GD10638@michonline.com.suse.lists.linux.kernel>
	<1098245904.23628.84.camel@krustophenia.net.suse.lists.linux.kernel>
	<1098247307.23628.91.camel@krustophenia.net.suse.lists.linux.kernel>
	<Pine.LNX.4.61.0410200744310.10521@chaos.analogic.com.suse.lists.linux.kernel>
	<Pine.LNX.4.61.0410290805570.11823@chaos.analogic.com.suse.lists.linux.kernel>
	<Pine.LNX.4.58.0410290740120.28839@ppc970.osdl.org.suse.lists.linux.kernel>
	<Pine.LNX.4.61.0410291316470.3945@chaos.analogic.com.suse.lists.linux.kernel>
	<20041029175527.GB25764@redhat.com.suse.lists.linux.kernel>
	<Pine.LNX.4.61.0410291416040.4844@chaos.analogic.com.suse.lists.linux.kernel>
	<Pine.LNX.4.58.0410291133220.28839@ppc970.osdl.org.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 30 Oct 2004 04:13:10 +0200
In-Reply-To: <Pine.LNX.4.58.0410291133220.28839@ppc970.osdl.org.suse.lists.linux.kernel>
Message-ID: <p73sm7xymvd.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> Anyway, it's quite likely that for several CPU's the fastest sequence ends 
> up actually being 
> 
> 	movl 4(%esp),%ecx
> 	movl 8(%esp),%edx
> 	movl 12(%esp),%eax
> 	addl $16,%esp
> 
> which is also one of the biggest alternatives.

For K8 it should be the fastest way. K7 probably too.

-Andi
