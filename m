Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267190AbUGVTrU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267190AbUGVTrU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 15:47:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267191AbUGVTrT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 15:47:19 -0400
Received: from smtp10.wanadoo.fr ([193.252.22.21]:13391 "EHLO
	mwinf1002.wanadoo.fr") by vger.kernel.org with ESMTP
	id S267190AbUGVTnT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 15:43:19 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date: Thu, 22 Jul 2004 21:44:15 +0200
From: Pascal Brisset <pascal.brisset@wanadoo.fr>
To: hpa@zytor.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Delete cryptoloop
In-Reply-To: <2kMAw-rl-15@gated-at.bofh.it>
Message-Id: <20040722194308.7C19E1C00215@mwinf1002.wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hpa@zytor.com (H. Peter Anvin) wrote in message
news:<2kMAw-rl-15@gated-at.bofh.it>...
> So does cryptoloop use a different IV for different blocks?  The need
> for the IV to be secret is different for different ciphers, but for
> block ciphers the rule is that is must not repeat, and at least
> according to some people must not be trivially predictable. [...]

The IV is predictable in cryptoloop and in other implementations.
This causes specially crafted watermarks to be detectable through
the encryption [1].  Pretty bad, but whether this is really a
concern or not depends a lot on what you are encrypting.

-- Pascal

[1] Markku-Juhani Saarinen: Encrypted Watermarks; Security Vulnerabilities in Laptop Encryption (Security Forum Workshop 2004)

