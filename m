Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262156AbULLWXS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262156AbULLWXS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Dec 2004 17:23:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262158AbULLWXR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Dec 2004 17:23:17 -0500
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:13239 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S262156AbULLWXP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Dec 2004 17:23:15 -0500
Date: Sun, 12 Dec 2004 23:23:12 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Pavel Machek <pavel@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: dynamic-hz
Message-ID: <20041212222312.GN16322@dualathlon.random>
References: <20041211142317.GF16322@dualathlon.random> <20041212163547.GB6286@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041212163547.GB6286@elf.ucw.cz>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 12, 2004 at 05:35:47PM +0100, Pavel Machek wrote:
> It certainly helps with singing capacitors... What is overhead of

;)

> this?

The overhead is a single l1 cacheline in the paths manipulating HZ
(rather than having an immediate value hardcoded in the asm, it reads it
from a memory location not in the icache). Plus there are some
conversion routines in the USER_HZ usages. It's not a measurable
difference.
