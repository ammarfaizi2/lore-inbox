Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261793AbSJIPB0>; Wed, 9 Oct 2002 11:01:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261795AbSJIPB0>; Wed, 9 Oct 2002 11:01:26 -0400
Received: from ns.suse.de ([213.95.15.193]:54789 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S261793AbSJIPBZ>;
	Wed, 9 Oct 2002 11:01:25 -0400
To: root@chaos.analogic.com
Cc: "J.A. Magallon" <jamagallon@able.es>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Writable global section?
References: <Pine.LNX.3.95.1021009103521.3016B-100000@chaos.analogic.com>
X-Yow: We have DIFFERENT amounts of HAIR --
From: Andreas Schwab <schwab@suse.de>
Date: Wed, 09 Oct 2002 17:06:55 +0200
In-Reply-To: <Pine.LNX.3.95.1021009103521.3016B-100000@chaos.analogic.com> ("Richard
 B. Johnson"'s message of "Wed, 9 Oct 2002 10:49:57 -0400 (EDT)")
Message-ID: <jen0pn1wj4.fsf@sykes.suse.de>
User-Agent: Gnus/5.090007 (Oort Gnus v0.07) Emacs/21.3.50 (ia64-suse-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" <root@chaos.analogic.com> writes:

|> If a variable is in the ".data" section, it is "seen" by all procedures
|> that are linked to the shared library, but any attempt to write to this
|> variable will seg-fault the task that attempts to modify it.

Your tests must be flawed, because a .data section *is* writable.  The
only difference between .data and .bss is that the latter has no
allocation in the image file, but they are mapped to the same, writable
segment.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Deutschherrnstr. 15-19, D-90429 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
