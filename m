Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264610AbRFYPH3>; Mon, 25 Jun 2001 11:07:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264613AbRFYPHT>; Mon, 25 Jun 2001 11:07:19 -0400
Received: from ns.suse.de ([213.95.15.193]:43015 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S264610AbRFYPHL>;
	Mon, 25 Jun 2001 11:07:11 -0400
To: Alan Shutko <ats@acm.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: sizeof problem in kernel modules
In-Reply-To: <Pine.LNX.3.95.1010625072259.5434A-100000@chaos.analogic.com>
	<87ofrcbryf.fsf@wesley.springies.com>
	<87g0cobrgz.fsf@wesley.springies.com>
X-Yow: I brought my BOWLING BALL - and some DRUGS!!
From: Andreas Schwab <schwab@suse.de>
Date: 25 Jun 2001 17:07:09 +0200
In-Reply-To: <87g0cobrgz.fsf@wesley.springies.com> (Alan Shutko's message of "Mon, 25 Jun 2001 09:59:32 -0400")
Message-ID: <jeofrc38f6.fsf@sykes.suse.de>
User-Agent: Gnus/5.090003 (Oort Gnus v0.03) Emacs/21.0.103
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Shutko <ats@acm.org> writes:

|> Alan Shutko <ats@acm.org> writes:
|> 
|> > You can look at other things too... you can memcpy structures, pass
|> > them into functions, call sizeof, put them in arrays... it _is_ a
|> > physical representation.
|> 
|> One more tidbit: ISO/IEC 9899:1990 3.14
|> 
|>   3.14 object: A region of data storage in the execution environment,
|>     the contents of which can represent values.  Except for
|>     bit-fields, objects are composed of contiguous sequences of one or
|>     more bytes, the number, order and encoding of which are either
|>     explicitely specified or implementation-defined.
|> 
|> This would specifically prohibit separating any part of a structure
|> from the rest.

But only under the as-if rule, that is, if you never take the address of a
structure object the compiler can actually put the parts of it anywhere it
likes, because you couldn't notice the difference.

Andreas.

-- 
Andreas Schwab                                  "And now for something
SuSE Labs                                        completely different."
Andreas.Schwab@suse.de
SuSE GmbH, Schanzäckerstr. 10, D-90443 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
