Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266010AbSKKUBz>; Mon, 11 Nov 2002 15:01:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266015AbSKKUBy>; Mon, 11 Nov 2002 15:01:54 -0500
Received: from ns.suse.de ([213.95.15.193]:20234 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S266010AbSKKUBy>;
	Mon, 11 Nov 2002 15:01:54 -0500
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Ray Lee <ray-lk@madrabbit.org>, <hps@intermeta.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: sscanf("-1", "%d", &i) fails, returns 0
References: <Pine.LNX.4.33L2.0211111019300.23954-100000@dragon.pdx.osdl.net>
X-Yow: Yow!  Are we wet yet?
From: Andreas Schwab <schwab@suse.de>
Date: Mon, 11 Nov 2002 21:08:41 +0100
In-Reply-To: <Pine.LNX.4.33L2.0211111019300.23954-100000@dragon.pdx.osdl.net> ("Randy.Dunlap"'s
 message of "Mon, 11 Nov 2002 11:09:28 -0800 (PST)")
Message-ID: <je1y5rhnsm.fsf@sykes.suse.de>
User-Agent: Gnus/5.090007 (Oort Gnus v0.07) Emacs/21.3.50 (ia64-suse-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Randy.Dunlap" <rddunlap@osdl.org> writes:

|> Andreas Schwab wrote:
|> |> IOW, asking for an unsigned number (in the format string)
|> |> and getting "-123" does return 0.
|> 
|> | Not in C.  According to the standard scanf is supposed to convert the
|> | value to unsinged and return that.
|> OK, thanks, I found that in the C spec.
|> 
|> Now what does it mean to "convert the value to an unsigned and return
|> that."  This is the same as above, isn't it?
|> I.e., on the scanf() side, there is no conversion needed; just store the
|> value.

The C standard also supports ones-complement and sign-magnitude
representation of signed integers where signed<->unsigned conversion is a
non-trivial operation in the sense that the bit representation does
change.  And scanf knows the signedness of the destination due to the
format spec.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Deutschherrnstr. 15-19, D-90429 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
