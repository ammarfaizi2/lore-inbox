Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267936AbUH3O0R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267936AbUH3O0R (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 10:26:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268163AbUH3O0R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 10:26:17 -0400
Received: from 104.engsoc.carleton.ca ([134.117.69.104]:63908 "EHLO
	certainkey.com") by vger.kernel.org with ESMTP id S267936AbUH3O0L
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 10:26:11 -0400
Date: Mon, 30 Aug 2004 09:24:53 -0400
From: Jean-Luc Cooke <jlcooke@certainkey.com>
To: linux-kernel@vger.kernel.org
Subject: CryptoAPI: schedual while atomic
Message-ID: <20040830132453.GG11307@certainkey.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While I was playing with using the CryptoAPI in /dev/random for my own
purposes, I noticed that I was getting quite a few "schedual while atomic!"
console messages.

Talking with Michal Ludvig, I seem to think that a "!is_atomic()" check
inside crypto_yield() or passing a flag during crypto_alloc_tfm() would make
a lot of sense.

This may be more directed at James Morris, but here it goes:

Can we have some logic to either check for or turn off crypto_yield()'s in
crypto/internal.h's crypto_yield() ?

Cheers,

JLC
