Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261760AbTCQQWc>; Mon, 17 Mar 2003 11:22:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261762AbTCQQWc>; Mon, 17 Mar 2003 11:22:32 -0500
Received: from mailout01.sul.t-online.com ([194.25.134.80]:39380 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S261760AbTCQQWb>; Mon, 17 Mar 2003 11:22:31 -0500
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.21-pre5 kksymoops for i386/ia64
From: Andi Kleen <ak@muc.de>
Date: Mon, 17 Mar 2003 17:33:07 +0100
In-Reply-To: <26040.1047888163@kao2.melbourne.sgi.com.suse.lists.linux.kernel> (Keith
 Owens's message of "17 Mar 2003 09:08:23 +0100")
Message-ID: <m3wuiyx8ak.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.090013 (Oort Gnus v0.13) Emacs/21.2 (i586-suse-linux)
References: <26040.1047888163@kao2.melbourne.sgi.com.suse.lists.linux.kernel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens <kaos@ocs.com.au> writes:

> Automatic decoding of oops on 2.5 has been very useful, so this patch
> adds kksymoops support to 2.4.21-pre5.  Currently only for i386 and
> ia64, other architectures are easy to add.

This 2.4 kallsyms patch doesn't work for cross compilation because
the modutils are terminally broken in this regard.

Rather than using this patch I would rather backport the 2.5 code
which works fine even for cross and compresses the symbol tables too.

-Andi
