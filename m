Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261647AbUKITsO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261647AbUKITsO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 14:48:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261643AbUKITsL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 14:48:11 -0500
Received: from fw.osdl.org ([65.172.181.6]:57492 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261649AbUKITrI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 14:47:08 -0500
Date: Tue, 9 Nov 2004 11:46:46 -0800
From: Andrew Morton <akpm@osdl.org>
To: Dave Kleikamp <shaggy@austin.ibm.com>
Cc: andrea@novell.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] zap_pte_range should not mark non-uptodate pages dirty
Message-Id: <20041109114646.1781757a.akpm@osdl.org>
In-Reply-To: <1100009730.7478.1.camel@localhost>
References: <1098393346.7157.112.camel@localhost>
	<20041021144531.22dd0d54.akpm@osdl.org>
	<20041021223613.GA8756@dualathlon.random>
	<20041021160233.68a84971.akpm@osdl.org>
	<20041021232059.GE8756@dualathlon.random>
	<20041021164245.4abec5d2.akpm@osdl.org>
	<20041022003004.GA14325@dualathlon.random>
	<20041022012211.GD14325@dualathlon.random>
	<20041021190320.02dccda7.akpm@osdl.org>
	<20041022161744.GF14325@dualathlon.random>
	<20041022162433.509341e4.akpm@osdl.org>
	<1100009730.7478.1.camel@localhost>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Kleikamp <shaggy@austin.ibm.com> wrote:
>
> Andrew & Andrea,
> What is the status of this patch?  It would be nice to have it in the
> -mm4 kernel.
> 

I found that the patch was causing I/O errors to be reported with one of
the LTP tests:

testcases/bin/growfiles -W gf15 -b -e 1 -u -r 1-49600 -I r -u -i 0 -L 120 Lgfile1

So I dropped it out pending a bit more work.
