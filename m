Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262339AbUFAPji@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262339AbUFAPji (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 11:39:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265082AbUFAPiu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 11:38:50 -0400
Received: from cantor.suse.de ([195.135.220.2]:63108 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265088AbUFAPih (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 11:38:37 -0400
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Mikael Pettersson <mikpe@csd.uu.se>, "H. Peter Anvin" <hpa@zytor.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.6.6-rc3] gcc-3.4.0 fixes
References: <200404292146.i3TLkfI0019612@harpo.it.uu.se>
	<c892nk$5pf$1@terminus.zytor.com>
	<16572.38987.239160.819836@alkaid.it.uu.se>
	<20040601150913.GU2093@holomorphy.com>
From: Andreas Schwab <schwab@suse.de>
X-Yow: With this weapon I can expose fictional characters and bring about
 sweeping reforms!!
Date: Tue, 01 Jun 2004 17:38:33 +0200
In-Reply-To: <20040601150913.GU2093@holomorphy.com> (William Lee Irwin,
 III's message of "Tue, 1 Jun 2004 08:09:13 -0700")
Message-ID: <jeaczn8f0m.fsf@sykes.suse.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> writes:

> On Tue, Jun 01, 2004 at 04:52:59PM +0200, Mikael Pettersson wrote:
>> You're assuming pointers have uniform representation.
>> C makes no such guarantees, and machines _have_ had
>> different types of representations in the past.
>> Some not-so-obsolete 64-bit machines in effect use fat
>> representations for pointers to functions (descriptors),
>> but they usually cheat and use pointers to the descriptors
>> instead. However, a C implementation could legally
>> represent a function pointer as a 128-bit value, while
>> data pointers remain 64 bits.
>
> IIRC for all types foo, sizeof(foo *) <= sizeof(void *), no?

No.  There is no implied relation between data pointers and function
pointers.  The only requirement is that all _function_ pointers smell
alike, because you can convert any function pointer to any other function
pointer and back without losing information.  There is no dedicated
generic function pointer type, any one can function as one.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
