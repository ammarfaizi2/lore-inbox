Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261214AbUJ3CPy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261214AbUJ3CPy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 22:15:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263024AbUJ3CPP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 22:15:15 -0400
Received: from cantor.suse.de ([195.135.220.2]:983 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263620AbUJ3CJ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 22:09:56 -0400
To: dean gaudet <dean-list-linux-kernel@arctic.org>
Cc: linux-os@analogic.com, Andreas Steinmetz <ast@domdv.de>,
       Richard Henderson <rth@redhat.com>, Andi Kleen <ak@muc.de>,
       Andrew Morton <akpm@osdl.org>, Jan Hubicka <jh@suse.cz>,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: Semaphore assembly-code bug
References: <Pine.LNX.4.58.0410181540080.2287@ppc970.osdl.org.suse.lists.linux.kernel>
	<417550FB.8020404@drdos.com.suse.lists.linux.kernel>
	<1098218286.8675.82.camel@mentorng.gurulabs.com.suse.lists.linux.kernel>
	<41757478.4090402@drdos.com.suse.lists.linux.kernel>
	<20041020034524.GD10638@michonline.com.suse.lists.linux.kernel>
	<1098245904.23628.84.camel@krustophenia.net.suse.lists.linux.kernel>
	<1098247307.23628.91.camel@krustophenia.net.suse.lists.linux.kernel>
	<Pine.LNX.4.61.0410200744310.10521@chaos.analogic.com.suse.lists.linux.kernel>
	<Pine.LNX.4.61.0410290805570.11823@chaos.analogic.com.suse.lists.linux.kernel>
	<Pine.LNX.4.58.0410290740120.28839@ppc970.osdl.org.suse.lists.linux.kernel>
	<41826A7E.6020801@domdv.de.suse.lists.linux.kernel>
	<Pine.LNX.4.61.0410291255400.17270@chaos.analogic.com.suse.lists.linux.kernel>
	<Pine.LNX.4.58.0410291103000.28839@ppc970.osdl.org.suse.lists.linux.kernel>
	<Pine.LNX.4.61.0410291631250.8616@twinlark.arctic.org.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 30 Oct 2004 04:04:22 +0200
In-Reply-To: <Pine.LNX.4.61.0410291631250.8616@twinlark.arctic.org.suse.lists.linux.kernel>
Message-ID: <p73y8hpyna1.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dean gaudet <dean-list-linux-kernel@arctic.org> writes:
> 
> it's worse than that in general -- lea typically goes through the AGU 
> which has either less throughput or longer latency than the ALUs... 
> depending on which x86en.  it's 4 cycles for a lea on p4, vs. 1 for a pop.  
> it's 2 cycles for a lea on k8 vs. 1 for a pop.

On D stepping and later K8 the lea is 1 cycle latency because the
decoder optimizes the lea into an add.

-Andi

