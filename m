Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268642AbRGZS3L>; Thu, 26 Jul 2001 14:29:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268641AbRGZS3B>; Thu, 26 Jul 2001 14:29:01 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:14354 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S268634AbRGZS2s>;
	Thu, 26 Jul 2001 14:28:48 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Thu, 26 Jul 2001 20:28:32 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: [PATCH] gcc-3.0.1 and 2.4.7-ac1
CC: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.40
Message-ID: <9C117960438@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On 26 Jul 01 at 18:52, Alan Cox wrote:
> >   following is patch which was needed for compiling 2.4.7-ac1
> > on box equipped with 'gcc version 3.0.1 20010721 (Debian prerelease)'.
> > As I did not see such complaint yet - here it is.
> >   If you think that gcc is too lazy on inlining (I think so...),
> > tell me and I'll complain to gcc team instead of here.
> 
> Fix gcc. We use extern inline to say 'must be inlined' and that was the
> semantic it used to have. Some of our inlines will not work if the compiler
> uninlines them.

Just adding '-finline-limit=150' fixes all of them (critical limit
is somewhere between 120 and 150 on my kernel). As '-finline-limit'
is documented as being 10000 by default, it looks like that someone
changed default value to some really unreasonable value (probably 100).
                                        Best regards,
                                                Petr Vandrovec
                                                vandrove@vc.cvut.cz
                                                
