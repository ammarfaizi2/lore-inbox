Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265936AbSLIVy5>; Mon, 9 Dec 2002 16:54:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266173AbSLIVy5>; Mon, 9 Dec 2002 16:54:57 -0500
Received: from c16410.randw1.nsw.optusnet.com.au ([210.49.25.29]:18173 "EHLO
	mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id <S265936AbSLIVy4>; Mon, 9 Dec 2002 16:54:56 -0500
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15861.4842.846748.181660@wombat.chubb.wattle.id.au>
Date: Tue, 10 Dec 2002 09:02:18 +1100
To: Mark Haverkamp <markh@osdl.org>
Cc: Christoph Hellwig <hch@infradead.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] aacraid 2.5
In-Reply-To: <158487460@toto.iv>
X-Mailer: VM 7.07 under 21.4 (patch 10) "Military Intelligence" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Mark" == Mark Haverkamp <markh@osdl.org> writes:

Mark> On Fri, 2002-12-06 at 16:30, Christoph Hellwig wrote:
>> On Fri, Dec 06, 2002 at 07:45:42AM -0800, Mark Haverkamp wrote: >
>> +/** > + * Convert capacity to cylinders > + * accounting for the
>> fact capacity could be a 64 bit value > + * > + */ > +static inline
>> u32 cap_to_cyls(sector_t capacity, u32 divisor) > +{ > +#ifdef
>> CONFIG_LBD > + do_div(capacity, divisor); > +#else > + capacity /=
>> divisor; > +#endif > + return (u32) capacity; > +}
>> 
>> Please use sector_div() instead.  It exists for a reason.


Mark> Thanks for finding this.  I have enclosed a change using your
Mark> suggestion.


sector_div(a, b) is just like do_div(a, b) -- it returns the
remainder, and sets a to a/b which is not reflected in your patch...

--
Dr Peter Chubb				    peterc@gelato.unsw.edu.au
You are lost in a maze of BitKeeper repositories, all almost the same.
