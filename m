Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280484AbRJaUQu>; Wed, 31 Oct 2001 15:16:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280487AbRJaUQl>; Wed, 31 Oct 2001 15:16:41 -0500
Received: from boreas.isi.edu ([128.9.160.161]:42978 "EHLO boreas.isi.edu")
	by vger.kernel.org with ESMTP id <S280484AbRJaUQc>;
	Wed, 31 Oct 2001 15:16:32 -0500
To: Rik van Riel <riel@conectiva.com.br>
cc: Larry McVoy <lm@bitmover.com>, Timur Tabi <ttabi@interactivesi.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Module Licensing? 
In-Reply-To: Your message of "Wed, 31 Oct 2001 15:27:31 -0200."
             <Pine.LNX.4.33L.0110311525460.2963-100000@imladris.surriel.com> 
Date: Wed, 31 Oct 2001 12:08:16 -0800
Message-ID: <9669.1004558896@ISI.EDU>
From: Craig Milo Rogers <rogers@ISI.EDU>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> This is obviously incorrect, that would say that
>>
>> 	#include <sys/types.h>
>>
>> means my app is now GPLed.  Good luck enforcing that.
>
>You're right, just including <sys/types.h> won't do that,
>but either of:
>
>1) using inline functions from a .h file  or
>2) linking to the library/kernel later on
>
>might mean your stuff is GPLed.
>
>Be careful which definitions you get from the
>header file, inline functions are a very grey
>area ;)

	I think discussions of copyright issues need more precision
than "your stuff", please.

	The object module resulting from compiling the code fragment
above ("#include ...") might be a derived work of both the code
fragment and the (GPL'd) header file, thus subject to the restrictions
of the GPLv2.  The original source code itself would not be subject to
the GPLv2, because "<sys/types.h>" is not itself a copyrightable
string (although it could be trademarked, of course, which might lead
to the same effect).

	Using, in the non-GPLv2-compliant source file, any symbol name
included from the GPL'd header file, has been commonly assumed not to
taint the source file itself with the restrictions of the GPLv2.  This
is more of a grey area, because the use of these symbols over a block
of code could easily construct a derivation of a usage pattern that
was copyrighted in the interface definition document.

	Usual disclaimer:  I am not a lawyer.

					Craig Milo Rogers

