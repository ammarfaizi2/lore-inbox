Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262547AbUDEOIf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 10:08:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262592AbUDEOIf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 10:08:35 -0400
Received: from [151.39.82.11] ([151.39.82.11]:5345 "HELO abbeynet.it")
	by vger.kernel.org with SMTP id S262547AbUDEOIa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 10:08:30 -0400
Message-ID: <4071685B.20906@abbeynet.it>
Date: Mon, 05 Apr 2004 16:08:27 +0200
From: Marco Fais <marco.fais@abbeynet.it>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; it-IT; rv:1.4.2) Gecko/20040308
X-Accept-Language: it, en, en-us
MIME-Version: 1.0
To: Marco Roeland <marco.roeland@xs4all.nl>
CC: linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at page_alloc.c:98 -- compiling with distcc
References: <406D3E8F.20902@abbeynet.it> <20040402131551.GA10920@localhost> <6.0.0.22.2.20040402163334.02abe7d8@pop.localnet> <20040402150535.GA13340@localhost> <407137FD.3040407@abbeynet.it> <20040405114650.GA16079@localhost>
In-Reply-To: <20040405114650.GA16079@localhost>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.24.0.7; VDF: 6.24.0.86; host: abbeynet.it)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marco Roeland ha scritto:

> There is an '8139cp' driver too, it's supposed to be working better
> as well, perhaps that one might not free the pages that are to be
> zero_copied across the network before they are sent?! That is the real
> problem if I understand Andrew's mail correctly.

Just tried that, unfortunately this network card isn't supported from 
8139cp driver.

> You might send a 'linux 8139too sendfile() panic' kind of bugreport
> to the 'netdev@oss.sgi.com' mailing list. That is the list where the
> networking gurus are supposed to be hanging out. Although IMVHO this bug

Andrew's messages are in CC: to the netdev@oss.sgi.com list, so I think 
they're already aware of the problem.

> is more on the kernel than on the network side. Also filing an entry to
> bugzilla.kernel.org might speed up someone fixing the real problem.

Ok, let see if we get a patch from this discussion, otherwise I'll file 
a new bugzilla entry.

> Easiest workaround might be to just use a customised distcc for the
> machines involved: just download the source from 'distcc.samba.org', do
> a regular './configure', and then in the generated 'src/config.h' hand
> edit '#undef HAVE_SENDFILE' and '#undef HAVE_SYS_SENDFILE_H'. That
> should stop distcc from using sendfile().

Great! I'm going to test that right now, surely better than deploying 
customized kernels in all servers until an "official" patch comes out.

Thank you very much, Marco.

