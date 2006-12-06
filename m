Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759148AbWLFA7n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759148AbWLFA7n (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 19:59:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759163AbWLFA7n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 19:59:43 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:58089
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1759131AbWLFA7m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 19:59:42 -0500
Date: Tue, 05 Dec 2006 16:59:48 -0800 (PST)
Message-Id: <20061205.165948.98864221.davem@davemloft.net>
To: mattjreimer@gmail.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: D-cache aliasing issue in cow_user_page
From: David Miller <davem@davemloft.net>
In-Reply-To: <f383264b0612051657r2b62c7acnf10b2800934ab8b3@mail.gmail.com>
References: <f383264b0612042338y2609dd76w8ba562394800bbd0@mail.gmail.com>
	<20061205.132412.116353924.davem@davemloft.net>
	<f383264b0612051657r2b62c7acnf10b2800934ab8b3@mail.gmail.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matt Reimer" <mattjreimer@gmail.com>
Date: Tue, 5 Dec 2006 16:57:12 -0800

> Right, but isn't he declaring that each architecture needs to take
> care of this? So, say, on ARM we'd need to make kunmap() not a NOP and
> call flush_dcache_page() ?

No.  He is only solving a problem that occurs on HIGHMEM
configurations on systems which can have D-cache aliasing
issues.
