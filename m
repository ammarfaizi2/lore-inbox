Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261463AbTISKDC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 06:03:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261468AbTISKDC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 06:03:02 -0400
Received: from ns.suse.de ([195.135.220.2]:9914 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261463AbTISKDA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 06:03:00 -0400
To: kaih@khms.westfalen.de (Kai Henningsen)
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Athlon/Opteron Prefetch Fix for 2.6.0test5 + numbers
References: <20030917202100.GC4723@wotan.suse.de>
	<Pine.LNX.4.44.0309171332200.2523-100000@laptop.osdl.org>
	<Pine.LNX.4.44.0309171332200.2523-100000@laptop.osdl.org>
	<20030917211200.GA5997@wotan.suse.de> <8uAuunHHw-B@khms.westfalen.de>
From: Andreas Schwab <schwab@suse.de>
X-Yow: I am deeply CONCERNED and I want something GOOD for BREAKFAST!
Date: Fri, 19 Sep 2003 12:02:56 +0200
In-Reply-To: <8uAuunHHw-B@khms.westfalen.de> (Kai Henningsen's message of
 "19 Sep 2003 08:55:00 +0200")
Message-ID: <jeoexhqenj.fsf@sykes.suse.de>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kaih@khms.westfalen.de (Kai Henningsen) writes:

> ak@suse.de (Andi Kleen)  wrote on 17.09.03 in <20030917211200.GA5997@wotan.suse.de>:
>
>> On Wed, Sep 17, 2003 at 01:50:59PM -0700, Linus Torvalds wrote:
>
>> > Also, you do things like comparing pointers for less/greater than, and at
>> > least some versions of gcc has done that wrong - using signed comparisons.
>>
>> Really? Is that any version we still support (2.95+) ?
>> It is certainly legal ISO-C. I changed it for now.
>
> It certainly is *not* legal ISO C, and never was.

Certainly the kernel isn't using ISO C, and never will.

IMHO you can just compare two pointers to char in GNU C and expect to get
a meaningful result.  I think the bug Linus was thinking of was some
problems with counting loops where gcc transformed the index variable into
a pointer, but then got the terminating comparison wrong.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Deutschherrnstr. 15-19, D-90429 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
