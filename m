Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265534AbUGHMMG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265534AbUGHMMG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 08:12:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265798AbUGHMMG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 08:12:06 -0400
Received: from mail.tpgi.com.au ([203.12.160.113]:41158 "EHLO mail.tpgi.com.au")
	by vger.kernel.org with ESMTP id S265534AbUGHMMD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 08:12:03 -0400
Subject: Re: GCC 3.4 and broken inlining.
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Jakub Jelinek <jakub@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040708120719.GS21264@devserv.devel.redhat.com>
References: <1089287198.3988.18.camel@nigel-laptop.wpcb.org.au>
	 <20040708120719.GS21264@devserv.devel.redhat.com>
Content-Type: text/plain
Message-Id: <1089288664.2687.23.camel@nigel-laptop.wpcb.org.au>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 08 Jul 2004 22:11:05 +1000
Content-Transfer-Encoding: 7bit
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Thu, 2004-07-08 at 22:07, Jakub Jelinek wrote:
> Try passing -Winline, it will tell you when a function marked inline is not
> actually inlined.

That's what I was using; no error message is printed. It is for other
functions.

> Presence of inline keyword is not a guarantee the function will not be
> inlined, it is a hint to the compiler.


> GCC 3.4 is much bettern than earlier 3.x GCCs in actually inlining functions
> marked as inline, but there are still cases when it decides not to inline
> for various reasons.  E.g. in C++ world, lots of things are inline, yet
> honoring that everywhere would mean very inefficient huge programs.
> If a function relies for correctness on being inlined, then it should use
> inline __attribute__((always_inline)).

Okay. I'll do that then.

Thanks.

Nigel

