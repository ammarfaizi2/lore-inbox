Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261419AbUDNQHh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 12:07:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261422AbUDNQHg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 12:07:36 -0400
Received: from palrel11.hp.com ([156.153.255.246]:46031 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S261419AbUDNQHf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 12:07:35 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16509.25006.96933.584153@napali.hpl.hp.com>
Date: Wed, 14 Apr 2004 09:07:10 -0700
To: Jamie Lokier <jamie@shareable.org>
Cc: David Mosberger-Tang <davidm@hpl.hp.com>, linux-ia64@linuxia64.org,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Andrew Morton <akpm@osdl.org>, Kurt Garloff <garloff@suse.de>,
       linux-kernel@vger.kernel.org, mingo@redhat.com
Subject: Re: [PATCH] (IA64) Fix ugly __[PS]* macros in <asm-ia64/pgtable.h>
In-Reply-To: <20040414113753.GA9413@mail.shareable.org>
References: <9AB83E4717F13F419BD880F5254709E5011EBABA@scsmsx402.sc.intel.com>
	<20040414082355.GA8303@mail.shareable.org>
	<20040414113753.GA9413@mail.shareable.org>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



 Jamie> Patch: ia64-pgtable-2.6.5.patch
 Jamie> That mixture of PAGE_* and __pgprot() definitions for the __[PS]*
 Jamie> macros in asm-ia64/pgtable.h is really ugly and just makes the code
 Jamie> unnecessarily confusing:

 Jamie> #define __P000  PAGE_NONE
 Jamie> #define __P001  PAGE_READONLY
 Jamie> #define __P010  PAGE_READONLY
 Jamie> #define __P011  PAGE_READONLY
 Jamie> #define __P100  __pgprot(__ACCESS_BITS | _PAGE_PL_3 | _PAGE_AR_X_RX)
 Jamie> #define __P101  __pgprot(__ACCESS_BITS | _PAGE_PL_3 | _PAGE_AR_RX)
 Jamie> #define __P110  PAGE_COPY
 Jamie> #define __P111  PAGE_COPY

 Jamie> The PAGE_* macros which are used in __[PS]* aren't used
 Jamie> anywhere else: their entire reason for existing is to make the
 Jamie> __[PS]* macros clearer.  It looks as though the people who
 Jamie> implemented the IA-64 port didn't realise that.

Huh?  You haven't actually checked, have you?
I don't pollute namespace for no good reason.

 Jamie> Here is a page (untested) which cleans up those definitions.
 Jamie> It was made from 2.6.5.

If the same names are adopted by the other platforms, I'm fine with it.
Otherwise, see my comment above.

	--david
