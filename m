Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270014AbRHGJKO>; Tue, 7 Aug 2001 05:10:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270146AbRHGJKF>; Tue, 7 Aug 2001 05:10:05 -0400
Received: from mail.loewe-komp.de ([62.156.155.230]:12557 "EHLO
	mail.loewe-komp.de") by vger.kernel.org with ESMTP
	id <S270014AbRHGJJu>; Tue, 7 Aug 2001 05:09:50 -0400
Message-ID: <3B6FAE7F.B93157BC@loewe-komp.de>
Date: Tue, 07 Aug 2001 11:01:51 +0200
From: Peter =?iso-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
Organization: LOEWE. Kompetenzzentrum Hannover
X-Mailer: Mozilla 4.76 [de] (X11; U; Linux 2.4.4-64GB-SMP i686)
X-Accept-Language: de, en
MIME-Version: 1.0
To: johnpol@2ka.mipt.ru
CC: linux-kernel@vger.kernel.org
Subject: Re: Encrypted Swap
In-Reply-To: <200108070624.f776Ofl21096@www.2ka.mipt.ru>
		<Pine.LNX.4.33.0108062338130.5491-100000@mackman.net> <200108070705.f7775xl27094@www.2ka.mipt.ru>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evgeny Polyakov wrote:
> 
> Hello.
> 
> On Mon, 6 Aug 2001 23:45:33 -0700 (PDT)
> Ryan Mack <rmack@mackman.net> wrote:
> 
> >> Hmmm, let us suppose, that i copy your crypted partition per bit to my
> >> disk.
> >> After it I will disassemble your decrypt programm and will find a key....
> >>
> >> In any case, if anyone have crypted data, he MUST decrypt them.
> >> And for it he MUST have some key.
> >> If this is a software key, it MUST NOT be encrypted( it's obviously,
> >> becouse in other case, what will decrypt this key?) and anyone, who have
> >> PHYSICAL access to the machine, can get this key.
> >> Am I wrong?
> 
> RM> I think the point you are missing is that encrypted swap only needs to be
> RM> accessible for one power cycle.  Thus the computer can generate a key at
> No, computer can not do this.
> This will do some program,and this program is not crypted.
> Yes?
> We disassemle this program, get algorithm and regenerate a key in evil machine?
> Am i wrong?
> 
> P.S. off-topic What algorithm do you want to use to regenerate a key for once crypted data?
> I don't know anyone, or i can't understand your point of view.
> 

The key genaration relies on good random numbers from a strong random
generator.
You won't be able to produce the same key twice.

Of course you can argue, that you can still manipulate the machine -
perhaps
even disabling the encryption completely or turn the random numbers into
predictable ones. But then you have to "attack" the machine at least two
times: 
a) to manipulate the machine and later 
b) to try to retrieve the data that's not "encrypted" anymore (at least
you are 
able to "decrypt" it).

So your effort grows significantly. You steal a notebook, shit: don't
have a key.
You have to manipulate it first, wait and then steal it. This is not so
simple -
but of course not completely impossible.
