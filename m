Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267935AbTAHWHS>; Wed, 8 Jan 2003 17:07:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267940AbTAHWHS>; Wed, 8 Jan 2003 17:07:18 -0500
Received: from bjl1.asuk.net.64.29.81.in-addr.arpa ([81.29.64.88]:25506 "EHLO
	bjl1.asuk.net") by vger.kernel.org with ESMTP id <S267935AbTAHWHR>;
	Wed, 8 Jan 2003 17:07:17 -0500
Date: Wed, 8 Jan 2003 22:19:56 +0000
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Wolfgang Fritz <wolfgang.fritz@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Asterisk] DTMF noise
Message-ID: <20030108221956.GA7507@bjl1.asuk.net>
References: <D6889804-2291-11D7-901B-000393950CC2@karlsbakk.net> <3E1BD88A.4080808@users.sf.net> <3E1C1CDE.8090600@sktc.net> <3E1C4872.7080508@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E1C4872.7080508@gmx.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wolfgang Fritz wrote:
> There exists a long text about DTMF detection somewhere on the net (I 
> may have the link in the office but I'm on vacation now). What I 
> remember is that a "correct" DTMF detection requires much more computing 
> power as the present i4l implementation needs (much longer audio samples 
> for the goertzel filter, a larger number of frequencies to check) and a 
> standard test procedure with a lot of test cases which are not available 
> to mortal humans (audio tapes from Bellcore IIRC)

Take a look at this:

	http://www-s.ti.com/sc/psheets/spra096a/spra096a.pdf

It describes an algorithm, plus test results.  It was tested on a TI
DSP using those very Bellcore tapes, plus another set of tests, and
passes both tests very well.

Of course your ISDN hardware + phone handset may have much worse
analogue circuitry, but I would hope the Bellcore tapes represent that
to some degree.

Unfortunately, TI have removed the version of their application node
which includes DSP source code.  It can be found here instead:

	http://sulcata6.cs.ccu.edu.tw/~vlsi/data/c54x/spra096.pdf

I guess if that _exact_ DSP algorithm were recoded in C, you could be
reasonably confident that the C implementation would pass those
Bellcore and MITEL tests with reasonable analogue hardware.  That's
probably the best you can do on the digital side.

enjoy,
-- Jamie
