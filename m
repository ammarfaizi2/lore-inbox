Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266986AbUAXSQG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 13:16:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266987AbUAXSQG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 13:16:06 -0500
Received: from fw.osdl.org ([65.172.181.6]:24267 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266986AbUAXSP7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 13:15:59 -0500
Date: Sat, 24 Jan 2004 10:17:04 -0800
From: Andrew Morton <akpm@osdl.org>
To: Serge Belyshev <33554432@mtu-net.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arch/i386/Makefile,scripts/gcc-version.sh,Makefile
 small fixes
Message-Id: <20040124101704.3bf3ada2.akpm@osdl.org>
In-Reply-To: <87oestsard.fsf@mtu-net.ru>
References: <87oestsard.fsf@mtu-net.ru>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Serge Belyshev <33554432@mtu-net.ru> wrote:
>
> [This patch is against 2.6.2-rc1-mm2]

Is appreciated, thanks.

> arch/i386/Makefile:
> *  omitted $(KBUILD_SRC)/ in script call.

OK

> scripts/gcc-version.sh:
> *  GNU tail no longer supports 'tail -1' syntax.

OK.

> Makefile: 
> *  There is no point in adding -funit-at-a-time option because it is
>    enabled by default at levels -Os, -O2 and -O3.

hm.  Didn't Andi say that adding -fno-unit-at-a-time caused code shrinkage?

> *  Consider adding -fweb option:

What does it do?

>    vanilla:
>    $ size vmlinux
>       text    data     bss     dec     hex filename
>    3056270  526780  386056 3969106  3c9052 vmlinux
> 
>    with -fweb:
>    $ size vmlinux
>       text    data     bss     dec     hex filename
>    3049523  526780  386056 3962359  3c75f7 vmlinux
> 
>    Also note 0.1 ... 1.0% speedup in various benchmarks.
>    This option is not enabled by default at -O2 because it
>    (like -fomit-frame-pointer) makes debugging impossible.

OK, then we'd need a config option for it.


