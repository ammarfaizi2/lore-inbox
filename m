Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266273AbUIMJDq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266273AbUIMJDq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 05:03:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266427AbUIMJDp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 05:03:45 -0400
Received: from fw.osdl.org ([65.172.181.6]:58274 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266273AbUIMJDo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 05:03:44 -0400
Date: Mon, 13 Sep 2004 02:01:43 -0700
From: Andrew Morton <akpm@osdl.org>
To: Krzysztof "Sierota (o2.pl/tlen.pl)" <Krzysztof.Sierota@firma.o2.pl>
Cc: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: Re: [BUG] kernel BUG at fs/jbd/checkpoint.c:646!
Message-Id: <20040913020143.12983b51.akpm@osdl.org>
In-Reply-To: <1094866100.1770.338.camel@rakieeta>
References: <1094866100.1770.338.camel@rakieeta>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof "Sierota (o2.pl/tlen.pl)" <Krzysztof.Sierota@firma.o2.pl> wrote:
>
>  the following bug is present on kernels: 2.6.7-mm6, 2.6.9-rc1-mm1,
>  2.6.8.1-mm3. If any testing would be needed I can trigger it here in the
>  matter of hours.
> 
>  Oops from 2.6.8.1-mm3 attached.
> 
>  Hope that someone will be able to find a solution for this.
> 
>  tia,
>  Krzysztof
> 
> 
> [2.6.8.1-mm3-oo1  text/plain (2745 bytes)]
>  Assertion failure in __journal_drop_transaction() at fs/jbd/checkpoint.c:646: "transaction->t_forget == NULL"

You're using data=journal?  If so, you'd best turn it off.

I'm not able to reproduce this, as usual.  It's on my list of things to ponder.
