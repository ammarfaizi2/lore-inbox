Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932343AbVJCP6V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932343AbVJCP6V (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 11:58:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932346AbVJCP6V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 11:58:21 -0400
Received: from odin.selfhtml.org ([213.198.84.177]:38539 "EHLO
	odin.selfhtml.org") by vger.kernel.org with ESMTP id S932343AbVJCP6B
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 11:58:01 -0400
Message-ID: <4341550C.90502@selfhtml.org>
Date: Mon, 03 Oct 2005 17:58:04 +0200
From: Christian Seiler <christian.seiler@selfhtml.org>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050403)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Bug at mm/rmap.c:493, Kernel 2.6.13.2
References: <4340108F.7030604@selfhtml.org> <Pine.LNX.4.61.0510030532340.3832@goblin.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.61.0510030532340.3832@goblin.wat.veritas.com>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> Please try Linus' patch at the bottom: on dual Opteron, our best guess
> is that yours is a different manifestation of the same underlying issue.  

Thanks a lot - this patch really seems to help. The server is now up for
1.5 hours with the kernel patch and the error did not occur anymore.

Furthermore, another issue I had on that computer, seems to be fixed by
this patch, too: gcc and ld sometimes failed to compile/link a file at
random, gcc exiting with error code 1 and no message and ld exiting with
the error message:

Inconsistency detected by ld.so: rtld.c: 1075: dl_main: Assertion
`_rtld_local._dl_rtld_map.l_libname' failed!

This error occured at random. It seems to be gone now. I didn't report
it here because I thought it was an issue with binutils, gcc or glibc
but it seems that this kernel patch fixes it, too.

Thanks!

Christian
