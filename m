Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265508AbSKKOba>; Mon, 11 Nov 2002 09:31:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265547AbSKKOba>; Mon, 11 Nov 2002 09:31:30 -0500
Received: from ns.suse.de ([213.95.15.193]:53009 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S265508AbSKKOb3>;
	Mon, 11 Nov 2002 09:31:29 -0500
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: "Henning P. Schmiedehausen" <hps@intermeta.de>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: sscanf("-1", "%d", &i) fails, returns 0
References: <Pine.LNX.4.33L2.0211101854350.22017-100000@dragon.pdx.osdl.net>
X-Yow: Talking Pinhead Blues:
 Oh, I LOST my ``HELLO KITTY'' DOLL and I get BAD reception on
  channel TWENTY-SIX!!
 Th'HOSTESS FACTORY is closin' down and I just heard ZASU PITTS
  has been DEAD for YEARS..  (sniff)
 My PLATFORM SHOE collection was CHEWED up by th'dog, ALEXANDER
  HAIG won't let me take a SHOWER 'til Easter.. (snurf)
 So I went to the kitchen, but WALNUT PANELING whup me
  upside mah HAID!! (on no, no, no..  Heh, heh)
From: Andreas Schwab <schwab@suse.de>
Date: Mon, 11 Nov 2002 15:38:15 +0100
In-Reply-To: <Pine.LNX.4.33L2.0211101854350.22017-100000@dragon.pdx.osdl.net> ("Randy.Dunlap"'s
 message of "Sun, 10 Nov 2002 19:05:05 -0800 (PST)")
Message-ID: <jewunkgoiw.fsf@sykes.suse.de>
User-Agent: Gnus/5.090007 (Oort Gnus v0.07) Emacs/21.3.50 (ia64-suse-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Randy.Dunlap" <rddunlap@osdl.org> writes:

|> On Sun, 10 Nov 2002, Henning P. Schmiedehausen wrote:
|> 
|> | "Randy.Dunlap" <rddunlap@osdl.org> writes:
|> |
|> | >+		digit = *str;
|> | >+		if (is_sign && digit == '-')
|> | >+			digit = *(str + 1);
|> |
|> | If signed is not allowed and you get a "-", you're in an error case
|> | again...
|> 
|> Yes, and a 0 value is returned.
|> IOW, asking for an unsigned number (in the format string)
|> and getting "-123" does return 0.

Not in C.  According to the standard scanf is supposed to convert the
value to unsinged and return that.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Deutschherrnstr. 15-19, D-90429 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
