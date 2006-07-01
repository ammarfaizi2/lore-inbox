Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750834AbWGAATE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750834AbWGAATE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 20:19:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750967AbWGAATE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 20:19:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:25016 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750834AbWGAATC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 20:19:02 -0400
Date: Fri, 30 Jun 2006 17:22:22 -0700
From: Andrew Morton <akpm@osdl.org>
To: jesse.brandeburg@gmail.com, linux-kernel@vger.kernel.org,
       johnstul@us.ibm.com
Subject: Re: 2.6.17-mm4
Message-Id: <20060630172222.39c000ec.akpm@osdl.org>
In-Reply-To: <20060630171212.50630182.akpm@osdl.org>
References: <20060629013643.4b47e8bd.akpm@osdl.org>
	<4807377b0606291053g602f3413gb3a60d1432a62242@mail.gmail.com>
	<20060629120518.e47e73a9.akpm@osdl.org>
	<4807377b0606301653n68bee302t33c2cc28b8c5040@mail.gmail.com>
	<20060630171212.50630182.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:
>
> Have you tried
> earlyprintk=vga or, better, earlyprintk=serial,ttyS0,9600?

Or, cruder, put a `for(;;);' at the start of timekeeping_init(), check that
it doesn't reboot.  Then move it to the end of timekeeping_init(), check
that it does reboot then keep going until we identify the offending
statement.

