Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261997AbUKDARI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261997AbUKDARI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 19:17:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261995AbUKDAQp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 19:16:45 -0500
Received: from siaag1ag.compuserve.com ([149.174.40.13]:46770 "EHLO
	siaag1ag.compuserve.com") by vger.kernel.org with ESMTP
	id S261997AbUKDAN7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 19:13:59 -0500
Date: Wed, 3 Nov 2004 19:10:52 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [PATCH 504] m68k: smp_lock.h: Avoid recursive include
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Hans Reiser <reiser@namesys.com>
Message-ID: <200411031913_MC3-1-8DE3-3DD@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Nov 2004 at 22:28:36 +0100 Geert Uytterhoeven wrote:

> > You can discuss about that: reiserfs_fs.h used current including sched.h.
>                                                        ^
> Oops, there's a missing `without' here...

Yes, but reiserfs_fs.h includes smp_lock.h, and that included sched.h until
you removed it.  Now that sched.h is back in smp_lock.h, its inclusion directly
in reiserfs_fs.h should be unnecessary...


--Chuck Ebbert  03-Nov-04  20:06:17
