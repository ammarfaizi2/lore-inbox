Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261741AbUKADvH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261741AbUKADvH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 22:51:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261742AbUKADvH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 22:51:07 -0500
Received: from siaag2ac.compuserve.com ([149.174.40.133]:43720 "EHLO
	siaag2ac.compuserve.com") by vger.kernel.org with ESMTP
	id S261741AbUKADvG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 22:51:06 -0500
Date: Sun, 31 Oct 2004 22:46:19 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [PATCH 475] HP300 LANCE
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>
Message-ID: <200410312250_MC3-1-8DAC-4170@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 31 Oct 2004 at 02:48:40 -0800 Andrew Morton <akpm@osdl.org> wrote:

> It comes out visually OK once the patch is applied.  But it's a
> useful reminder of how much dreck we have in the tree.

That's for sure:

[me@nb linux-2.6.9]$ find . -name "*.[ch]" | xargs egrep -H -n '^[[:space:]]+if\(' | \
> tee if_should_be_followed_by_space | wc -l
18991


And my favorite pet peeve:

[me@nb linux-2.6.9]$ find . -name "*.[ch]" | \
> xargs egrep -H -n '^[[:space:]]+return[[:space:]]*\([^)]+\);' | \
> tee return_is_not_a_function | wc -l
9867

There are a lot more than that but I could find no obvious way of including
"return(parenthesized expr)" while excluding "return (typecast)(expr)".


--Chuck Ebbert  31-Oct-04  23:46:37
