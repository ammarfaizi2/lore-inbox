Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932315AbVI2Wqc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932315AbVI2Wqc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 18:46:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932344AbVI2Wqc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 18:46:32 -0400
Received: from pilet.ens-lyon.fr ([140.77.167.16]:51620 "EHLO
	relaissmtp.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S932315AbVI2Wqb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 18:46:31 -0400
Message-ID: <433C60B1.8080003@ens-lyon.fr>
Date: Thu, 29 Sep 2005 23:46:25 +0200
From: Alexandre Buisse <alexandre.buisse@ens-lyon.fr>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050812)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rc2-mm2
References: <20050929143732.59d22569.akpm@osdl.org>
In-Reply-To: <20050929143732.59d22569.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.14-rc2/2.6.14-rc2-mm2/
>
>(temp copy at http://www.zip.com.au/~akpm/linux/patches/stuff/2.6.14-rc2-mm2.gz)
>


Hi Andrew,

just wanting to report that reiser4 as a module was not compiling
anymore. It failed with the following message :

In file included from fs/reiser4/lock.h:15,
                 from fs/reiser4/context.h:14,
                 from fs/reiser4/debug.c:25:
fs/reiser4/txnmgr.h: In function `spin_atom_init':
fs/reiser4/txnmgr.h:512: error: duplicate case value
fs/reiser4/txnmgr.h:512: error: previously used here
fs/reiser4/txnmgr.h: In function `spin_txnh_init':
fs/reiser4/txnmgr.h:513: error: duplicate case value
fs/reiser4/txnmgr.h:513: error: previously used here
fs/reiser4/txnmgr.h: In function `spin_txnmgr_init':
fs/reiser4/txnmgr.h:514: error: duplicate case value
fs/reiser4/txnmgr.h:514: error: previously used here
In file included from fs/reiser4/context.h:14,
                 from fs/reiser4/debug.c:25:
fs/reiser4/lock.h: In function `spin_stack_init':
fs/reiser4/lock.h:198: error: duplicate case value
fs/reiser4/lock.h:198: error: previously used here
In file included from fs/reiser4/znode.h:16,
                 from fs/reiser4/tree.h:15,
                 from fs/reiser4/super.h:9,
                 from fs/reiser4/debug.c:26:
fs/reiser4/jnode.h: In function `spin_jnode_init':
fs/reiser4/jnode.h:344: error: duplicate case value
fs/reiser4/jnode.h:344: error: previously used here
fs/reiser4/jnode.h: In function `spin_jload_init':
fs/reiser4/jnode.h:348: error: duplicate case value
fs/reiser4/jnode.h:348: error: previously used here
In file included from fs/reiser4/super.h:9,
                 from fs/reiser4/debug.c:26:
fs/reiser4/tree.h: In function `spin_epoch_init':
fs/reiser4/tree.h:169: error: duplicate case value
fs/reiser4/tree.h:169: error: previously used here
In file included from fs/reiser4/debug.c:26:
fs/reiser4/super.h: In function `spin_super_init':
fs/reiser4/super.h:379: error: duplicate case value
fs/reiser4/super.h:379: error: previously used here
make[2]: *** [fs/reiser4/debug.o] Error 1
make[1]: *** [fs/reiser4] Error 2
make: *** [fs] Error 2


I did not investigate further and simply removed the module.

Regards,
Alexandre

