Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281902AbRKUPAN>; Wed, 21 Nov 2001 10:00:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281901AbRKUPAD>; Wed, 21 Nov 2001 10:00:03 -0500
Received: from ns.suse.de ([213.95.15.193]:10500 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S281395AbRKUO7s> convert rfc822-to-8bit;
	Wed, 21 Nov 2001 09:59:48 -0500
To: root@chaos.analogic.com
Cc: Jan Hudec <bulb@ucw.cz>, linux-kernel@vger.kernel.org
Subject: Re: [BUG] Bad #define, nonportable C, missing {}
In-Reply-To: <Pine.LNX.3.95.1011121085737.21389A-100000@chaos.analogic.com>
X-Yow: I'm pretending that we're all watching PHIL SILVERS
 instead of RICARDO MONTALBAN!
From: Andreas Schwab <schwab@suse.de>
Date: 21 Nov 2001 15:59:46 +0100
In-Reply-To: <Pine.LNX.3.95.1011121085737.21389A-100000@chaos.analogic.com> ("Richard B. Johnson"'s message of "Wed, 21 Nov 2001 09:12:56 -0500 (EST)")
Message-ID: <jelmh09nkt.fsf@sykes.suse.de>
User-Agent: Gnus/5.090003 (Oort Gnus v0.03) Emacs/21.1.30
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" <root@chaos.analogic.com> writes:

|> On Wed, 21 Nov 2001, Jan Hudec wrote:
|> 
|> > > >     *a++ = byte_rev[*a]
|> > > It looks perferctly okay to me. Anyway, whenever would you listen to a
|> > > C++ book talking about good C coding :p
|> > 
|> 
|> It's simple. If any object is modified twice without an intervening
|> sequence point, the results are undefined. The sequence-point in
|> 
|> 	*a++ = byte_rev[*a];
|> 
|> ... is the ';'.
|> 
|> So, we look at 'a' and see if it's modified twice.

No, the rule much stricter. 

         -- Between two sequence points, an object is modified more
            than once, or  is  modified  and  the  prior  value  is
            accessed other than to determine the value to be stored
            (6.5).

Andreas.

-- 
Andreas Schwab                                  "And now for something
Andreas.Schwab@suse.de				completely different."
SuSE Labs, SuSE GmbH, Schanzäckerstr. 10, D-90443 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
