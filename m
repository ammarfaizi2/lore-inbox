Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130417AbQLBV57>; Sat, 2 Dec 2000 16:57:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130498AbQLBV5t>; Sat, 2 Dec 2000 16:57:49 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:773 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130417AbQLBV5l>; Sat, 2 Dec 2000 16:57:41 -0500
Message-ID: <3A296903.F958513C@transmeta.com>
Date: Sat, 02 Dec 2000 13:26:27 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [patch-2.4.0-test12-pre3] microcode update for P4 (fwd)
In-Reply-To: <Pine.LNX.4.21.0012022111350.933-100000@penguin.homenet>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tigran Aivazian wrote:
> 
> On Sat, 2 Dec 2000, Tigran Aivazian wrote:
> 
> > On Sat, 2 Dec 2000, H. Peter Anvin wrote:
> > >
> > > OK, fair enough.  Let me make a new statement then: I suggest we preface
> > > these with MSR_ anyway so we can tell what they really are.
> > >
> >
> > That is much better. Actually, I accept your suggestion.
> 
> on the other hand -- that makes them much longer and it is always obvious
> from the context what they are, i.e.:
> 
> a) if they appear in the code then it is unlikely they are outside of
> rdmsr()/wrmsr() which makes their meaning obvious.
> 
> b) if they are in the header, the name of the header asm/msr.h and the
> comment above their definition explains what they are.
> 
> I don't know -- if people really think MSR_ is needed then it can be
> done.
> 
> I think my intuitive IA32_ naming was adequate but if you really believe
> we should prefix it with MSR_ then so be it.
> 

I really think so... after all, it might be obvious when you use them in
the correct context, but it definitely isn't obvious when you're using
them in the wrong context.  I am also worried about namespace collisions
doing back things.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
