Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265248AbTFWIpc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 04:45:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265395AbTFWIpc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 04:45:32 -0400
Received: from hera.cwi.nl ([192.16.191.8]:16830 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S265248AbTFWIpb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 04:45:31 -0400
From: Andries.Brouwer@cwi.nl
Date: Mon, 23 Jun 2003 10:59:35 +0200 (MEST)
Message-Id: <UTC200306230859.h5N8xZ811407.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, hch@infradead.org
Subject: Re: [PATCH] loop.c - part 1 of many
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> IMHO we should replace it with a by-name selection

>> That is what CryptoAPI does

> CryptoAPI did _not_ replace it but add another level of indirection

Right. That is backwards compatibility for you.
algorithm 0: no encryption
algorithm 1: XOR
algorithm 2: DES
...
algorithm 16: AES
...
algorithm 18: CryptoAPI - select by name

Changing this, while at the same time remaining backwards compatible,
would only uglify the kernel, for no reason whatsoever.
And I am not breaking user space, if I can avoid it.

Andries
