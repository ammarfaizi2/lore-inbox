Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261406AbTHWFWD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 01:22:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261375AbTHWFWC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 01:22:02 -0400
Received: from mail.netapps.org ([12.162.17.40]:58808 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261406AbTHWFWA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 01:22:00 -0400
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>, kai.germaschewski@gmx.de,
       rusty@rustcorp.com.au
Subject: Re: [PATCH] eliminate gcc warnings on assert [__builtin_expect]
References: <20030822220500.6c0e1053.rddunlap@osdl.org>
X-Message-Flag: Warning: May contain useful information
X-Priority: 1
X-MSMail-Priority: High
From: Roland Dreier <roland@topspin.com>
Date: 22 Aug 2003 22:21:52 -0700
In-Reply-To: <20030822220500.6c0e1053.rddunlap@osdl.org>
Message-ID: <5265kp0wzz.fsf@topspin.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 23 Aug 2003 05:21:53.0562 (UTC) FILETIME=[769C6FA0:01C36936]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Randy" == Randy Dunlap <Randy.Dunlap> writes:

    Randy> Building genksyms on ia64 (gcc 3.3.1) produces these
    Randy> warnings:

        [...]

    Randy> Is there a problem with coercing the pointer parameter to
    Randy> be (int)?

Doesn't this produce "warning: cast from pointer to integer of different size"?
It would be better to do something like "!!__ptr" or "__ptr != 0" to
test if the pointer is NULL.  (This was discussed to death recently on LKML)

 - R.
