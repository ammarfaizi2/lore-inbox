Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263551AbUDBCGG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 21:06:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263553AbUDBCGG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 21:06:06 -0500
Received: from fw.osdl.org ([65.172.181.6]:40096 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263551AbUDBCFx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 21:05:53 -0500
Date: Thu, 1 Apr 2004 18:08:02 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: hugh@veritas.com, vrajesh@umich.edu, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [RFC][PATCH 1/3] radix priority search tree - objrmap
 complexity fix
Message-Id: <20040401180802.219ece99.akpm@osdl.org>
In-Reply-To: <20040402020022.GN18585@dualathlon.random>
References: <20040402001535.GG18585@dualathlon.random>
	<Pine.LNX.4.44.0404020145490.2423-100000@localhost.localdomain>
	<20040402011627.GK18585@dualathlon.random>
	<20040401173649.22f734cd.akpm@osdl.org>
	<20040402020022.GN18585@dualathlon.random>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> wrote:
>
> I now fixed up the whole compound thing, it made no sense to keep
> compound off with HUGETLBSF=N, that's a generic setup for all order > 0
> not just for hugetlbfs, so it has to be enabled always or never, or it's
> just asking for troubles.

It was a modest optimisation for non-hugetlb architectures and configs. 
Having it optional has caused no problem in a year.

Was there some reason why you _required_ that it be permanently enabled?

