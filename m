Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278665AbRKAKm6>; Thu, 1 Nov 2001 05:42:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278664AbRKAKmr>; Thu, 1 Nov 2001 05:42:47 -0500
Received: from mail209.mail.bellsouth.net ([205.152.58.149]:8101 "EHLO
	imf09bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S278663AbRKAKmk>; Thu, 1 Nov 2001 05:42:40 -0500
Message-ID: <3BE1271C.6CDF2738@mandrakesoft.com>
Date: Thu, 01 Nov 2001 05:42:36 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.14-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5 PROPOSAL: Replacement for current /proc of shit.
In-Reply-To: <E15zF9H-0000NL-00@wagner>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> No kernel-formatted tables: use a directory.  (eg. kernel symbols
> become a directory of symbol names, each containing the symbol value).
> 
> For cases when you don't want to take the overhead of creating a new
> proc entry (eg. tcp socket creation), you can create directories on
> demand when a user reads them using:
> 
>         proc_dir("net", "subdir", dirfunc, NULL);
>         unproc_dir("net", "subdir");
> 
> Note that with kbuild 2.5, you can do something like:
> 
>         proc(KBUILD_OBJECT, "foo", my_foo, int, 0644);
> 
> And with my previous parameter patch:
>         PARAM(foo, int, 0444);

Is this designed to replace sysctl?

In general we want to support using sysctl and similar features WITHOUT
procfs support at all (of any type).  Nice for embedded systems
especially.

sysctl may be ugly but it provides for a standard way of manipulating
kernel variables... sysctl(2) or via procfs or via /etc/sysctl.conf.

AFAICS your proposal, while nice and clean :), doesn't offer all the
features that sysctl presently does.

	Jeff



-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno

