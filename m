Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268724AbUIXMtQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268724AbUIXMtQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 08:49:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268717AbUIXMtQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 08:49:16 -0400
Received: from cantor.suse.de ([195.135.220.2]:5507 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S268735AbUIXMtK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 08:49:10 -0400
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Pawe?? Sikora <pluto@pld-linux.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: unresolved symbol __udivsi3_i4
References: <20040924021050.689.qmail@web53608.mail.yahoo.com>
	<200409240801.57848.pluto@pld-linux.org>
	<Pine.GSO.4.61.0409241031410.27692@waterleaf.sonytel.be>
	<20040924105207.GH22710@lug-owl.de>
	<Pine.GSO.4.61.0409241314530.27692@waterleaf.sonytel.be>
	<20040924112954.GI22710@lug-owl.de>
From: Andreas Schwab <schwab@suse.de>
X-Yow: CHUBBY CHECKER owns my BUILDING!
Date: Fri, 24 Sep 2004 14:49:08 +0200
In-Reply-To: <20040924112954.GI22710@lug-owl.de> (Jan-Benedict Glaw's
 message of "Fri, 24 Sep 2004 13:29:54 +0200")
Message-ID: <je4qlnltmj.fsf@sykes.suse.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan-Benedict Glaw <jbglaw@lug-owl.de> writes:

> Well, the kernel is (or should be) a freestanding program, so it
> shouldn't use *any* external code (and it doesn't, intentionally).
> We're working hard not linking in libgcc.a

libgcc is an intrinsic part of the freestanding implementation provided by
the compiler, just like <stdarg.h>.

> So people started doing freestanding implementations of eg. __udivsi3 in
> their kernel files. But why should they? GCC also could have emitted
> inlined code to do that task, without ever calling an external function
> for that.

Inlining can be less efficient due to icache issues.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
