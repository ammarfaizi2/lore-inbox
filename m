Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136726AbREAVID>; Tue, 1 May 2001 17:08:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136719AbREAVHy>; Tue, 1 May 2001 17:07:54 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:33043 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S136726AbREAVHt>; Tue, 1 May 2001 17:07:49 -0400
Message-ID: <3AEF2561.943849DF@transmeta.com>
Date: Tue, 01 May 2001 14:06:41 -0700
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        kernel list <linux-kernel@vger.kernel.org>, Andries.Brouwer@cwi.nl
Subject: Re: iso9660 endianness cleanup patch
In-Reply-To: <Pine.LNX.4.31.0105011358220.2667-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Tue, 1 May 2001, H. Peter Anvin wrote:
> >
> > Oh bother, you're right of course.  We need some kind of standardized
> > macro for indirecting through a potentially unaligned pointer.
> 
> No we don't - because it already exists.
> 
> It's called "get_unaligned()".
> 

Well, we presumably do need it since it's there.  I *did* correct this
brain fault of mine a few hours ago.

Note that it might still be an idea to have get_unaligned_le32() & co...
on some machines le32_to_cpu(get_unaligned()) could potentially be a lot
more painful than it needs to be.

	-hpa


-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
