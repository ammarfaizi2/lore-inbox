Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263637AbTLURXM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 12:23:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263645AbTLURXM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 12:23:12 -0500
Received: from linux-bt.org ([217.160.111.169]:13738 "EHLO mail.holtmann.net")
	by vger.kernel.org with ESMTP id S263637AbTLURXI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 12:23:08 -0500
Subject: Re: Difference between select and enable in Kconfig
From: Marcel Holtmann <marcel@holtmann.org>
To: Randy Dunlap <rddunlap@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Roman Zippel <zippel@linux-m68k.org>
In-Reply-To: <20031220205433.195037e8.rddunlap@osdl.org>
References: <1071974814.2684.41.camel@pegasus>
	 <20031220205433.195037e8.rddunlap@osdl.org>
Content-Type: text/plain
Message-Id: <1072027326.2684.72.camel@pegasus>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 21 Dec 2003 18:22:06 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

> | while porting some of my drivers to 2.6 which use the firmware loader
> | for example I came to the question whether to use select or enable to
> | achieve the desired result. Looking at the documention don't gives me
> | the answer and from zconf.l I feel that both options are the same. Can
> | anyone please explain me the differences if there are any?
> 
> I agree, they look like synonyms.
> There's nothing about "enable" in Documentation/kbuild/kconfig-language.txt
> and there's evidence in zconf.l (as you mention) and in menu.c
> that they are the same:
> 
> 			case P_SELECT:
> 				sym2 = prop_get_symbol(prop);
> 				if ((sym->type != S_BOOLEAN && sym->type != S_TRISTATE) ||
> 				    (sym2->type != S_BOOLEAN && sym2->type != S_TRISTATE))
> 					fprintf(stderr, "%s:%d:warning: enable is only allowed with boolean and tristate symbols\n",
> 					                                ~~~~~~

so both options achieve the same result. Why do we have two different
options for the same stuff? Should we not remove one?

Regards

Marcel


