Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965363AbWHOK1k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965363AbWHOK1k (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 06:27:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965366AbWHOK1k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 06:27:40 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:49034
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S965363AbWHOK1j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 06:27:39 -0400
Date: Tue, 15 Aug 2006 03:27:40 -0700 (PDT)
Message-Id: <20060815.032740.10248213.davem@davemloft.net>
To: johnpol@2ka.mipt.ru
Cc: ak@suse.de, akpm@osdl.org, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/1] network memory allocator.
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060815100228.GC1092@2ka.mipt.ru>
References: <20060815002724.a635d775.akpm@osdl.org>
	<p738xlqa0aw.fsf@verdi.suse.de>
	<20060815100228.GC1092@2ka.mipt.ru>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Date: Tue, 15 Aug 2006 14:02:28 +0400

> I had a version with per-cpu data - it is not very convenient to use
> here with it's per_cpu_ptr dereferencings....

It does eat lots of space though, even for non-present cpus, and for
local cpu case the access may even get optimized to a single register
+ offset computation on some platforms :-)
