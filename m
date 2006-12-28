Return-Path: <linux-kernel-owner+w=401wt.eu-S964923AbWL1FmQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964923AbWL1FmQ (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 00:42:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964922AbWL1FmQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 00:42:16 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:40454
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S964923AbWL1FmP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 00:42:15 -0500
Date: Wed, 27 Dec 2006 21:41:49 -0800 (PST)
Message-Id: <20061227.214149.74746689.davem@davemloft.net>
To: gordonfarquharson@gmail.com
Cc: torvalds@osdl.org, ranma@tdiedrich.de, tbm@cyrius.com,
       a.p.zijlstra@chello.nl, andrei.popa@i-neo.ro, akpm@osdl.org,
       hugh@veritas.com, nickpiggin@yahoo.com.au, arjan@infradead.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: fix page_mkclean_one
From: David Miller <davem@davemloft.net>
In-Reply-To: <97a0a9ac0612272120g144d2364n932d6f66728f162e@mail.gmail.com>
References: <97a0a9ac0612272032uf5358c4qf12bf183f97309a6@mail.gmail.com>
	<Pine.LNX.4.64.0612272039411.4473@woody.osdl.org>
	<97a0a9ac0612272120g144d2364n932d6f66728f162e@mail.gmail.com>
X-Mailer: Mew version 5.1.52 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Gordon Farquharson" <gordonfarquharson@gmail.com>
Date: Wed, 27 Dec 2006 22:20:20 -0700

> and for some reason I get
> 
> linus-test.c: In function 'remap':
> linus-test.c:61: error: 'POSIX_FADV_DONTNEED' undeclared (first use in
> this function)
> 
> when I compile the program, so I replaced POSIX_FADV_DONTNEED with 4
> as defined in /usr/include/bits/fcntl.h.

Me too, I added "-D_POSIX_C_SOURCE=200112" to "fix" this.

Perhaps Linus's GCC sets that by default and our's doesn't.
