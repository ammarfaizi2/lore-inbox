Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750914AbVLBH1h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750914AbVLBH1h (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 02:27:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751756AbVLBH1h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 02:27:37 -0500
Received: from smtp.osdl.org ([65.172.181.4]:62343 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751751AbVLBH1g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 02:27:36 -0500
Date: Thu, 1 Dec 2005 23:27:05 -0800
From: Andrew Morton <akpm@osdl.org>
To: Wu Fengguang <wfg@mail.ustc.edu.cn>
Cc: marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org,
       christoph@lameter.com, riel@redhat.com, a.p.zijlstra@chello.nl,
       npiggin@suse.de, andrea@suse.de, magnus.damm@gmail.com
Subject: Re: [PATCH 02/12] mm: supporting variables and functions for
 balanced zone aging
Message-Id: <20051201232705.0721181e.akpm@osdl.org>
In-Reply-To: <20051202071849.GA4073@mail.ustc.edu.cn>
References: <20051201101810.837245000@localhost.localdomain>
	<20051201101933.936973000@localhost.localdomain>
	<20051201023714.612f0bbf.akpm@osdl.org>
	<20051201222846.GA3646@dmt.cnet>
	<20051201150349.3538638e.akpm@osdl.org>
	<20051202011924.GA3516@mail.ustc.edu.cn>
	<20051201214931.2dbc35fe.akpm@osdl.org>
	<20051202071849.GA4073@mail.ustc.edu.cn>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wu Fengguang <wfg@mail.ustc.edu.cn> wrote:
>
>  First we run into a large range of pinned chunks, which lowered the scan
>  priority.  And then there are plenty of reclaimable chunks, bomb...

It doesn't have to be that complex - the unreclaimable pages could be
referenced, or under writeback or even simply dirty.
