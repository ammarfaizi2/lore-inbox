Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261816AbUCVJXI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 04:23:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261825AbUCVJXI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 04:23:08 -0500
Received: from nsmtp.pacific.net.th ([203.121.130.117]:53474 "EHLO
	nsmtp.pacific.net.th") by vger.kernel.org with ESMTP
	id S261816AbUCVJXE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 04:23:04 -0500
Date: Mon, 22 Mar 2004 17:18:57 +0800
From: "Michael Frank" <mhf@linuxmail.org>
To: pcg@goof.com
Cc: "Pavel Machek" <pavel@suse.cz>,
       "Software Suspend - Mailing Lists" 
	<swsusp-devel@lists.sourceforge.net>,
       "kernel list" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=US-ASCII;
	format=flowed	delsp=yes
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <opr49atvpk4evsfm@smtp.pacific.net.th>
User-Agent: Opera M2/7.50 (Linux, build 615)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Mar 2004 01:29:34 +0100, Pavel Machek <pavel@ucw.cz> wrote:
>
> +/*
> + * Copyright (c) 2000-2002 Marc Alexander Lehmann <pcg@goof.com>
> + *
> + * Redistribution and use in source and binary forms, with or without modifica-
> + * tion, are permitted provided that the following conditions are met:
> + *
> + *   1.  Redistributions of source code must retain the above copyright notice,
> + *       this list of conditions and the following disclaimer.
> + *
> + *   2.  Redistributions in binary form must reproduce the above copyright
> + *       notice, this list of conditions and the following disclaimer in the
> + *       documentation and/or other materials provided with the distribution.
> + *
> + *   3.  The name of the author may not be used to endorse or promote products
> + *       derived from this software without specific prior written permission.
>
> lzf compression should go under /lib, not under kernel/power, and
> probably should go in separately.
>
> This looks like BSD with advertising clause. I do not think you are
> allowed to link this with kernel. It does not follow kernel coding style.

Hello Marc,

As you will be aware, everone using swsusp2 loves to use your LZF functionality
which yields effective suspend/resume transfer rates of well above 100MB/s.

With inclusion of swsusp2 into kernel mainline drawing nearer, one _major_
issue was raised, which is the BSD license you released LZF under.

As said, BSD-only licensed code is _invalid_ to be linked with kernel code,
therefor swsusp2 will have to drop LZF alltogether unless you relicense it.

Would you please consider to relicense under GPL2, or GPL2 + BSD.
Intel does something like GPL2 + BSD this with ACPI btw. Please have a look
at their license.

This means in practice that GPL2 allows inclusion into the kernel, which
being opensource credits you, and other proprietary apps using the BSD
license will credit you in their documentation.

Also, as Pavel mentioned, LZF code should be put in /lib and cleaned up. This
is a chance to get LZF into the kernel and it would be much appreciated if you
please would take care of this. Thank you!

Regards
Michael

