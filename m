Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264889AbSK0WpI>; Wed, 27 Nov 2002 17:45:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264901AbSK0WpI>; Wed, 27 Nov 2002 17:45:08 -0500
Received: from dp.samba.org ([66.70.73.150]:52958 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S264889AbSK0WpH>;
	Wed, 27 Nov 2002 17:45:07 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: "Wang, Stanley" <stanley.wang@intel.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] [2.5.49] symbol_get doesn't work 
In-reply-to: Your message of "Tue, 26 Nov 2002 16:14:29 +0800."
             <957BD1C2BF3CD411B6C500A0C944CA2601F11696@pdsmsx32.pd.intel.com> 
Date: Wed, 27 Nov 2002 10:27:33 +1100
Message-Id: <20021127225227.746B12C0BD@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <957BD1C2BF3CD411B6C500A0C944CA2601F11696@pdsmsx32.pd.intel.com> you
 write:
> Hello,
> I found the symbol_get()/symbol_put() didn't work on my 2.5.49 build.
> I think the root cause is a wrong macro definition. The following patch
> could 
> fix this bug.

Hi Wang,

	Thanks for the bug report, but I think you misunderstand.
symbol_get() does not take a string, it takes an identifier.  This
way, we can ensure the type is correct.  eg.

	/* In header somewhere. */
	extern int their_integer;

	....
		int *ptr = symbol_get(their_integer);
		if (!ptr) ...

Does that help?
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
