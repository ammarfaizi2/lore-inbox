Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262649AbUKELwV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262649AbUKELwV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 06:52:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262650AbUKELwV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 06:52:21 -0500
Received: from cantor.suse.de ([195.135.220.2]:64924 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262649AbUKELwU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 06:52:20 -0500
Date: Fri, 5 Nov 2004 12:43:29 +0100
From: Andi Kleen <ak@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andi Kleen <ak@suse.de>, Lorenzo Allegrucci <l_allegrucci@yahoo.it>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc1-mm3
Message-ID: <20041105114329.GE8349@wotan.suse.de>
References: <20041105001328.3ba97e08.akpm@osdl.org> <200411051041.17940.l_allegrucci@yahoo.it> <20041105102204.GA4730@elte.hu> <20041105110951.GA29702@elte.hu> <20041105111751.GC8349@wotan.suse.de> <20041105112404.GA32198@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041105112404.GA32198@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> indeed ... But in the do_munmap() case we dont even clip to PGD
> boundary. So shouldnt we at least do the patch below?

It shouldn't be needed. The functions below the pgd level ignore
the additional bits because they always free whole levels.

-Andi
