Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265147AbTLCUKM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 15:10:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265145AbTLCUJo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 15:09:44 -0500
Received: from fw.osdl.org ([65.172.181.6]:15580 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265130AbTLCUJX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 15:09:23 -0500
Date: Wed, 3 Dec 2003 12:09:16 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
cc: Srivatsa Vaddagiri <vatsa@in.ibm.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lhcs-devel@lists.sourceforge.net
Subject: Re: kernel BUG at kernel/exit.c:792!
In-Reply-To: <Pine.LNX.4.58.0312032100100.4424@earth>
Message-ID: <Pine.LNX.4.58.0312031208130.7406@home.osdl.org>
References: <20031203153858.C14999@in.ibm.com> <Pine.LNX.4.58.0312030748240.5258@home.osdl.org>
 <Pine.LNX.4.58.0312032100100.4424@earth>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 3 Dec 2003, Ingo Molnar wrote:
>
> i'd like to keep the BUG() - it has caught this bug

It did nothing of the sort. It didn't catch a bug at all, it _caused_ a
bug.

> The next_thread() use of procfs is clearly illegal if it happens after a
> thread has been removed from the tasklist.

Why? I disagree with the "clearly". Even if it were illegal, it sure as
hell is not "clear".

		Linus
