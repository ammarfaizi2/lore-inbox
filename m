Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267598AbTBLQMm>; Wed, 12 Feb 2003 11:12:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267612AbTBLQMm>; Wed, 12 Feb 2003 11:12:42 -0500
Received: from ns.suse.de ([213.95.15.193]:5894 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S267598AbTBLQMl>;
	Wed, 12 Feb 2003 11:12:41 -0500
To: Dave Kleikamp <shaggy@austin.ibm.com>
Cc: Adrian Bunk <bunk@fs.tum.de>, Andrew Morton <akpm@digeo.com>,
       James Lamanna <james.lamanna@appliedminds.com>,
       "'Linus Torvalds'" <torvalds@transmeta.com>,
       jfs-discussion@www-124.southbury.usf.ibm.com,
       "'Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH - 2.5.60] JFS no longer compiles with gcc 2.95
X-Yow: This TOPS OFF my partygoing experience!  Someone I DON'T LIKE
 is talking to me about a HEART-WARMING European film..
From: Andreas Schwab <schwab@suse.de>
Date: Wed, 12 Feb 2003 17:22:29 +0100
In-Reply-To: <200302120942.01078.shaggy@austin.ibm.com> (Dave Kleikamp's
 message of "Wed, 12 Feb 2003 09:42:01 -0600")
Message-ID: <jey94lwjsq.fsf@sykes.suse.de>
User-Agent: Gnus/5.090014 (Oort Gnus v0.14) Emacs/21.3.50 (ia64-suse-linux)
References: <20030210204651.GE17128@fs.tum.de>
	<200302120852.36636.shaggy@austin.ibm.com>
	<20030212150435.GL17128@fs.tum.de>
	<200302120942.01078.shaggy@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Kleikamp <shaggy@austin.ibm.com> writes:

|> Interesting that the assert() macro in the same file is very similar, 
|> but apparently doesn't have the same problem.  Do you know if it's tied 
|> to the ## operator?

Yes, there is a difference in the handling of ## wrt. varargs macros in
the case of no arguments.  Previously the compiler removed everything
before ## upto the next whitespace, whereas it now removes exactly the
last token.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Deutschherrnstr. 15-19, D-90429 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
