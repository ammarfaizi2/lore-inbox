Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262192AbTLUE7b (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Dec 2003 23:59:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262196AbTLUE7a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Dec 2003 23:59:30 -0500
Received: from fw.osdl.org ([65.172.181.6]:8145 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262192AbTLUE73 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Dec 2003 23:59:29 -0500
Date: Sat, 20 Dec 2003 20:54:33 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Difference between select and enable in Kconfig
Message-Id: <20031220205433.195037e8.rddunlap@osdl.org>
In-Reply-To: <1071974814.2684.41.camel@pegasus>
References: <1071974814.2684.41.camel@pegasus>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Dec 2003 03:46:54 +0100 Marcel Holtmann <marcel@holtmann.org> wrote:

| Hi,
| 
| while porting some of my drivers to 2.6 which use the firmware loader
| for example I came to the question whether to use select or enable to
| achieve the desired result. Looking at the documention don't gives me
| the answer and from zconf.l I feel that both options are the same. Can
| anyone please explain me the differences if there are any?

I agree, they look like synonyms.
There's nothing about "enable" in Documentation/kbuild/kconfig-language.txt
and there's evidence in zconf.l (as you mention) and in menu.c
that they are the same:

			case P_SELECT:
				sym2 = prop_get_symbol(prop);
				if ((sym->type != S_BOOLEAN && sym->type != S_TRISTATE) ||
				    (sym2->type != S_BOOLEAN && sym2->type != S_TRISTATE))
					fprintf(stderr, "%s:%d:warning: enable is only allowed with boolean and tristate symbols\n",
					                                ~~~~~~


--
~Randy
