Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261607AbVFHUpf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261607AbVFHUpf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 16:45:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261611AbVFHUpf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 16:45:35 -0400
Received: from ns.suse.de ([195.135.220.2]:54925 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261607AbVFHUp2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 16:45:28 -0400
From: Andreas Schwab <schwab@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Paul Mackerras <paulus@samba.org>, akpm@osdl.org, anton@samba.org,
       linux-kernel@vger.kernel.org, jk@blackdown.de
Subject: Re: [PATCH] ppc64: Fix PER_LINUX32 behaviour
References: <17062.56723.535978.961340@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.58.0506081022030.2286@ppc970.osdl.org>
X-Yow: ..  over in west Philadelphia a puppy is vomiting..
Date: Wed, 08 Jun 2005 22:45:23 +0200
In-Reply-To: <Pine.LNX.4.58.0506081022030.2286@ppc970.osdl.org> (Linus
	Torvalds's message of "Wed, 8 Jun 2005 10:24:59 -0700 (PDT)")
Message-ID: <jey89kbmsc.fsf@sykes.suse.de>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> On Wed, 8 Jun 2005, Paul Mackerras wrote:
>> 
>> * uname(2) doesn't respect PER_LINUX32, it returns 'ppc64' instead of 'ppc'
>
> I think this is a feature, not a bug, and I suspect you just broke
> compiling a 64-bit kernel by default on ppc64.

The uname syscall that Paul is referring to (__NR_olduname) isn't actually
used nowadays any more.  The current uname syscall (__NR_uname, which is
implemented by ppc64_newuname) already translates ppc64 to ppc depending
on the personality.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
