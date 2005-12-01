Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932137AbVLAKhw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932137AbVLAKhw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 05:37:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932138AbVLAKhw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 05:37:52 -0500
Received: from smtp.osdl.org ([65.172.181.4]:41657 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932137AbVLAKhv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 05:37:51 -0500
Date: Thu, 1 Dec 2005 02:37:14 -0800
From: Andrew Morton <akpm@osdl.org>
To: Wu Fengguang <wfg@mail.ustc.edu.cn>
Cc: linux-kernel@vger.kernel.org, christoph@lameter.com, riel@redhat.com,
       a.p.zijlstra@chello.nl, npiggin@suse.de, andrea@suse.de,
       marcelo.tosatti@cyclades.com, magnus.damm@gmail.com,
       wfg@mail.ustc.edu.cn
Subject: Re: [PATCH 02/12] mm: supporting variables and functions for
 balanced zone aging
Message-Id: <20051201023714.612f0bbf.akpm@osdl.org>
In-Reply-To: <20051201101933.936973000@localhost.localdomain>
References: <20051201101810.837245000@localhost.localdomain>
	<20051201101933.936973000@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wu Fengguang <wfg@mail.ustc.edu.cn> wrote:
>
>  The zone aging rates are currently imbalanced,

ZONE_DMA is out of whack.  It shouldn't be, and I'm not aware of anyone
getting in and working out why.  I certainly wouldn't want to go and add
all this stuff without having a good understanding of _why_ it's out of
whack.  Perhaps it's just some silly bug, like the thing I pointed at in
the previous email.

> the gap can be as large as 3 times,

What's the testcase?

> which can severely damage read-ahead requests and shorten their
>  effective life time.

Have you any performance numbers for this?
