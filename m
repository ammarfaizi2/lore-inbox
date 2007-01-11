Return-Path: <linux-kernel-owner+w=401wt.eu-S1030332AbXAKNG6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030332AbXAKNG6 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 08:06:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030333AbXAKNG6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 08:06:58 -0500
Received: from nikam-dmz.ms.mff.cuni.cz ([195.113.20.16]:32820 "EHLO
	nikam.ms.mff.cuni.cz" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1030332AbXAKNG5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 08:06:57 -0500
Date: Thu, 11 Jan 2007 14:06:54 +0100
From: Martin Mares <mj@ucw.cz>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Cc: Aubrey <aubreylee@gmail.com>, Hua Zhong <hzhong@gmail.com>,
       Hugh Dickins <hugh@veritas.com>, linux-kernel@vger.kernel.org,
       hch@infradead.org, kenneth.w.chen@intel.com, akpm@osdl.org,
       torvalds@osdl.org, mjt@tls.msk.ru
Subject: Re: O_DIRECT question
Message-ID: <mj+md-20070111.130016.22349.camellia@ucw.cz>
References: <6d6a94c50701101857v2af1e097xde69e592135e54ae@mail.gmail.com> <Pine.LNX.4.61.0701110724040.19233@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0701110724040.19233@chaos.analogic.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Maybe you need to say why you want to use O_DIRECT with its terrible
> performance?

Incidentally, I was writing an external-memory radix-sort some time ago
and it turned out that writing to 256 files at once is much faster with
O_DIRECT than through the page cache, very likely because the page cache
is flushing pages in essentially random order. Tweaking VM parameters
and block device queue size helped, but only a little.

				Have a nice fortnight
-- 
Martin `MJ' Mares                          <mj@ucw.cz>   http://mj.ucw.cz/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
Linux vs. Windows is a no-WIN situation.
