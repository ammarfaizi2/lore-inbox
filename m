Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261224AbVBMATR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261224AbVBMATR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Feb 2005 19:19:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261228AbVBMATQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Feb 2005 19:19:16 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:63805 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261224AbVBMATE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Feb 2005 19:19:04 -0500
To: linux@horizon.com
Cc: ak@muc.de, arjan@infradead.org, bunk@stusta.de, chrisw@osdl.org,
       davem@redhat.com, hlein@progressive-comp.com,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com, shemminger@osdl.org,
       Valdis.Kletnieks@vt.edu
Subject: Re: [PATCH] OpenBSD Networking-related randomization port
X-Message-Flag: Warning: May contain useful information
References: <20050212232518.10838.qmail@science.horizon.com>
From: Roland Dreier <roland@topspin.com>
Date: Sat, 12 Feb 2005 16:18:14 -0800
In-Reply-To: <20050212232518.10838.qmail@science.horizon.com> (linux@horizon.com's
 message of "12 Feb 2005 23:25:18 -0000")
Message-ID: <527jld2tyx.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 13 Feb 2005 00:18:14.0294 (UTC) FILETIME=[8225C360:01C51161]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    linux> It's easy to make a smaller hash by just thowing bits away,
    linux> but a block cipher is a permutation, and has to be
    linux> invertible.

    linux> For example, if I take a k-bit counter and encrypt it with
    linux> a k-bit block cipher, the output is guaranteed not to
    linux> repeat in less than 2^k steps, but the value after a given
    linux> value is hard to predict.

Huh?  What if my cipher consists of XOR-ing with a k-bit pattern?
That's a permutation on the set of k-bit blocks but it happens to
decompose as a product of (non-overlapping) swaps.

In general for more realistic block ciphers like DES it seems
extremely unlikely that the cipher has only a single orbit when viewed
as a permutation.  I would expect a real block cipher to behave more
like a random permutation, which means that the expected number of
orbits for a k-bit cipher should be about ln(2^k) or roughly .7 * k.

 - R.
