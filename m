Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136687AbREASoY>; Tue, 1 May 2001 14:44:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136689AbREASoO>; Tue, 1 May 2001 14:44:14 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:3342 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S136687AbREASoH>; Tue, 1 May 2001 14:44:07 -0400
From: "H. Peter Anvin" <hpa@transmeta.com>
Message-ID: <3AEF03C5.A8531DAB@transmeta.com>
Date: Tue, 01 May 2001 11:43:17 -0700
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        kernel list <linux-kernel@vger.kernel.org>, torvalds@transmeta.com,
        Andries.Brouwer@cwi.nl
Subject: Re: iso9660 endianness cleanup patch
In-Reply-To: <200105011440.QAA12760@green.mif.pg.gda.pl> <3AEEFD7F.3E7C6B3@transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hpa@transmeta.com wrote:
> 
> Oh bother, you're right of course.  We need some kind of standardized
> macro for indirecting through a potentially unaligned pointer.  It can
> just do the dereference (e.g. x86), use left/right accesses (e.g. MIPS),
> or do it by byte (others).
> 
> Ports people, what do you think?
> 

My, my, my... I'm really 100% alert this morning.  Before anyone clues me
in, I did find <asm/unaligned.h> when I actually bothered looking.  New
patch in the making.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
