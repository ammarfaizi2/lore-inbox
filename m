Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261375AbTHWFsA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 01:48:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261711AbTHWFsA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 01:48:00 -0400
Received: from fw.osdl.org ([65.172.181.6]:12931 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261375AbTHWFr6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 01:47:58 -0400
Message-ID: <33171.4.4.25.4.1061617669.squirrel@www.osdl.org>
Date: Fri, 22 Aug 2003 22:47:49 -0700 (PDT)
Subject: Re: [PATCH] eliminate gcc warnings on assert [__builtin_expect]
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: <roland@topspin.com>
In-Reply-To: <5265kp0wzz.fsf@topspin.com>
References: <20030822220500.6c0e1053.rddunlap@osdl.org>
        <5265kp0wzz.fsf@topspin.com>
X-Priority: 1
Importance: High
Cc: <linux-kernel@vger.kernel.org>, <kai.germaschewski@gmx.de>,
       <rusty@rustcorp.com.au>
X-Mailer: SquirrelMail (version 1.2.11)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>>> "Randy" == Randy Dunlap <Randy.Dunlap> writes:
>
>     Randy> Building genksyms on ia64 (gcc 3.3.1) produces these
>     Randy> warnings:
>
>         [...]
>
>     Randy> Is there a problem with coercing the pointer parameter to Randy>
> be (int)?
>
> Doesn't this produce "warning: cast from pointer to integer of different
> size"? It would be better to do something like "!!__ptr" or "__ptr != 0" to
> test if the pointer is NULL.  (This was discussed to death recently on LKML)

Argh, you are right (on both counts).

I'll try that.

Thanks.

~Randy



