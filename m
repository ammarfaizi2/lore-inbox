Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271638AbRICSOx>; Mon, 3 Sep 2001 14:14:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271764AbRICSOm>; Mon, 3 Sep 2001 14:14:42 -0400
Received: from u-150-20.karlsruhe.ipdial.viaginterkom.de ([62.180.20.150]:9601
	"EHLO dea.linux-mips.net") by vger.kernel.org with ESMTP
	id <S271638AbRICSOc>; Mon, 3 Sep 2001 14:14:32 -0400
Date: Mon, 3 Sep 2001 15:14:21 +0200
From: Ralf Baechle <ralf@uni-koblenz.de>
To: Ulrich Weigand <Ulrich.Weigand@de.ibm.com>
Cc: "David S. Miller" <davem@redhat.com>,
        Richard.Zidlicky@stud.informatik.uni-erlangen.de, thunder7@xs4all.nl,
        parisc-linux@lists.parisc-linux.org, linux-kernel@vger.kernel.org
Subject: Re: [SOLVED + PATCH]: documented Oops running big-endian reiserfs on parisc architecture
Message-ID: <20010903151421.A3078@dea.linux-mips.net>
In-Reply-To: <OF9A995335.07A81CF5-ONC1256ABC.00422A7B@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <OF9A995335.07A81CF5-ONC1256ABC.00422A7B@de.ibm.com>; from Ulrich.Weigand@de.ibm.com on Mon, Sep 03, 2001 at 02:08:43PM +0200
X-Accept-Language: de,en,fr
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 03, 2001 at 02:08:43PM +0200, Ulrich Weigand wrote:

> >From what I recall when we were looking into reiserfs on S/390,
> the core problem was that reiserfs tried to do *atomic* operations
> on non-aligned words.  This isn't supported by the hardware on
> S/390 (normal non-aligned accesses just work).
> 
> I don't really see how this can be fixed in a trap handler; how
> would the handler guarantee atomicity?

Spinlocks.  Now that'd so infinitly ugly that I'd rather fix Reiserfs.
It's another proof that reiserfs design was done without too much
consideration of portability so I speculate we'll continue to see such
bugs.

  Ralf
