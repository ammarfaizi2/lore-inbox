Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266129AbUGEP67@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266129AbUGEP67 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 11:58:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266130AbUGEP67
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 11:58:59 -0400
Received: from cantor.suse.de ([195.135.220.2]:63884 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S266129AbUGEP65 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 11:58:57 -0400
To: Benjamin Collar <benjamin.collar@siemens.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: using _syscall4 to call sys_futex with -fPIC won't
 compile
References: <1089023944.8355.52.camel@mhpajh5c>
From: Andreas Schwab <schwab@suse.de>
X-Yow: I know things about TROY DONAHUE that can't even be PRINTED!!
Date: Mon, 05 Jul 2004 17:58:56 +0200
In-Reply-To: <1089023944.8355.52.camel@mhpajh5c> (Benjamin Collar's message
 of "Mon, 05 Jul 2004 12:39:04 +0200")
Message-ID: <je1xjqigxr.fsf@sykes.suse.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Collar <benjamin.collar@siemens.com> writes:

> Greetings
>
> [1.]
> If I use _syscall4 in order to call sys_futex and compile with -fPIC, I
> receive this compiler error:
> "can't find a register in class `BREG' while reloading `asm'"

Don't do that then.

> [2.]
> I'm using futexes in a project and I have to build a shared library;
> thus I need to use -fPIC when compiling. When doing so, I get the error
> mentioned in [1.].

Don't use kernel headers in user space.  Use syscall(3) instead.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
