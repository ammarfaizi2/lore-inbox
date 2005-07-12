Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261580AbVGLQxV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261580AbVGLQxV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 12:53:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261653AbVGLQxG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 12:53:06 -0400
Received: from smtp3.brturbo.com.br ([200.199.201.164]:3305 "EHLO
	smtp3.brturbo.com.br") by vger.kernel.org with ESMTP
	id S261580AbVGLQvr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 12:51:47 -0400
Message-ID: <42D3F502.9040209@brturbo.com.br>
Date: Tue, 12 Jul 2005 13:51:14 -0300
From: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
User-Agent: Mozilla Thunderbird 1.0.2-3mdk (X11/20050322)
X-Accept-Language: pt-br, pt, es, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Olaf Hering <olh@suse.de>, linux-kernel@vger.kernel.org
Subject: [Fwd: [PATCH 0/82] changing CONFIG_LOCALVERSION rebuilds too much,
 for no good reason.]
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

	Do you intend to apply Olaf's patchsets to eliminate linux/version.h?
Some of them will not apply, because, at -mm2, KERNEL_VERSION isn't used
anymore.

	Maybe I can generate a patchset for V4L eliminating version.h, if you
want, against latest version.

Mauro.

-------- Original Message --------
Date: Sun, 10 Jul 2005 19:35:08 +0000
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org


The following series of patches removes almost all inclusions
of linux/version.h. The 3 #defines are unused in most of the touched files.

A few drivers use the simple KERNEL_VERSION(a,b,c) macro, which is
unfortunatly
in linux/version.h. This define moved to linux/utsname.h

There are also lots of #ifdef for long obsolete kernels, this will go as
well.


quilt vi `find * -type f -name "*.[ch]"|xargs grep -El
'(UTS_RELEASE|LINUX_VERSION_CODE|KERNEL_VERSION|linux/version.h)'|grep
-Ev '(/(boot|coda|drm)/|~$)'`

search pattern:
/UTS_RELEASE|LINUX_VERSION_CODE|KERNEL_VERSION|linux/(utsname|version).h

PS: I hope my script is working ok.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/


