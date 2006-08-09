Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030464AbWHIEeO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030464AbWHIEeO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 00:34:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030466AbWHIEeO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 00:34:14 -0400
Received: from mail.suse.de ([195.135.220.2]:3523 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030464AbWHIEeN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 00:34:13 -0400
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: rohitseth@google.com, Dave Hansen <haveblue@us.ibm.com>,
       Kirill Korotaev <dev@sw.ru>, vatsa@in.ibm.com,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       mingo@elte.hu, sam@vilain.net, linux-kernel@vger.kernel.org,
       dev@openvz.org, efault@gmx.de, balbir@in.ibm.com, sekharan@us.ibm.com,
       nagar@watson.ibm.com, pj@sgi.com, Andrey Savochkin <saw@sw.ru>
Subject: Re: memory resource accounting (was Re: [RFC, PATCH 0/5] Going forward with Resource Management - A	cpu controller)
References: <20060804050753.GD27194@in.ibm.com>
	<20060803223650.423f2e6a.akpm@osdl.org>
	<20060803224253.49068b98.akpm@osdl.org>
	<1154684950.23655.178.camel@localhost.localdomain>
	<20060804114109.GA28988@in.ibm.com> <44D35F0B.5000801@sw.ru>
	<44D388DF.8010406@mbligh.org> <44D6EAFA.8080607@sw.ru>
	<44D74F77.7080000@mbligh.org> <44D76B43.5080507@sw.ru>
	<1154975486.31962.40.camel@galaxy.corp.google.com>
	<1154976236.19249.9.camel@localhost.localdomain>
	<1154977257.31962.57.camel@galaxy.corp.google.com>
	<44D798B1.8010604@mbligh.org> <44D89D7D.8040006@yahoo.com.au>
From: Andi Kleen <ak@suse.de>
Date: 09 Aug 2006 06:33:54 +0200
In-Reply-To: <44D89D7D.8040006@yahoo.com.au>
Message-ID: <p73d5bao7d9.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> writes:
> 
> - each struct page has a backpointer to its billed container. At the mm
>    summit Linus said he didn't want back pointers, but I clarified with him
>    and he isn't against them if they are easily configured out when not using
>    memory controllers.

This would need to be done at runtime though, otherwise it's useless
for distributions and other people who want single kernel binary images.

Probably would need a second parallel table, but for that you would
need to know at boot already if you plan to use them or not. Ugly.

-Andi
