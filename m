Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266130AbRGSXDP>; Thu, 19 Jul 2001 19:03:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266150AbRGSXDF>; Thu, 19 Jul 2001 19:03:05 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:17427 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S266130AbRGSXCo>; Thu, 19 Jul 2001 19:02:44 -0400
Message-ID: <3B576716.10BACD20@transmeta.com>
Date: Thu, 19 Jul 2001 16:02:46 -0700
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5-pre1-zisofs i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Julian Anastasov <ja@ssi.bg>
CC: "H. Peter Anvin" <hpa@zytor.com>, Linus Torvalds <torvalds@transmeta.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: cpuid_eax damages registers (2.4.7pre7)
In-Reply-To: <Pine.LNX.4.33.0107200158200.1820-100000@u.domain.uli>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Julian Anastasov wrote:
> 
>         Hello,
> 
> On Thu, 19 Jul 2001, H. Peter Anvin wrote:
> 
> > Julian Anastasov wrote:
> > >
> > > What I want to say (I could be wrong and that can't surprise me) is
> > > that the original cpuid_eax is in fact incorrect. All cpuid_XXX funcs
> > > use only dummy output operands...
> > >
> >
> > Bullsh*t.  One of the output operands is always a non-dummy (in
> > cpuid_edx() edx is not a dummy, for example.)
> 
>         Right, and it is may be not damaged. In my first posting I
> claim that cpuid_eax damages ebx (and may be ecx and edx).
> 

Doesn't matter.  gcc can't pick and choose what *effects* of an asm()
statement it wants to happen -- this should be utterly obvious to
anyone.  As the old saying goes, you can't be half pregnant.

	-hpa
