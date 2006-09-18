Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965216AbWIRBiT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965216AbWIRBiT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 21:38:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965213AbWIRBiT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 21:38:19 -0400
Received: from moutng.kundenserver.de ([212.227.126.188]:40947 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S965205AbWIRBiS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 21:38:18 -0400
Message-Id: <20060918012740.407846000@klappe.arndb.de>
In-Reply-To: <1158079495.9189.125.camel@hades.cambridge.redhat.com>
Date: Mon, 18 Sep 2006 03:27:40 +0200
From: Arnd Bergmann <arnd@arndb.de>
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [patch 0/8] Re: All arch maintainers: 'make headers_check' fails on most architectures.
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 12 September 2006 18:44, David Woodhouse wrote:

> Basically all but PowerPC and i386 have problems; and the latter works
> only if you apply the patches I sent to Linus a few days ago.
>
> This is just a basic check that the headers which _are_ exported don't
> try to include other headers which aren't. This can happen either
> because the former should not, or the latter _should_ be exported.
> Mostly, however, the solution is just to make sure the latter is
> included only within #ifdef __KERNEL__, because it's only needed within
> that ifdef anyway.

I have extended that script somewhat to check for more problems,
and fixed a number of problems in the process.

The bad news is that with this extended script, there will be even
more work for each architecture maintainer to make it check without
warnings.

	Arnd <><

