Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131056AbRABMal>; Tue, 2 Jan 2001 07:30:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131093AbRABMab>; Tue, 2 Jan 2001 07:30:31 -0500
Received: from Cantor.suse.de ([194.112.123.193]:26378 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S131056AbRABMaU>;
	Tue, 2 Jan 2001 07:30:20 -0500
Date: Tue, 2 Jan 2001 12:59:24 +0100
From: Andi Kleen <ak@suse.de>
To: Matthew Wilcox <matthew@wil.cx>
Cc: "David S. Miller" <davem@redhat.com>, grundler@cup.hp.com,
        linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
        parisc-linux@thepuffingroup.com
Subject: Re: [PATCH] move xchg/cmpxchg to atomic.h
Message-ID: <20010102125924.A9538@gruyere.muc.suse.de>
In-Reply-To: <200101020811.AAA26525@milano.cup.hp.com> <200101020903.BAA14334@pizda.ninka.net> <20010102112242.A7040@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010102112242.A7040@parcelfarce.linux.theplanet.co.uk>; from matthew@wil.cx on Tue, Jan 02, 2001 at 11:22:42AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 02, 2001 at 11:22:42AM +0000, Matthew Wilcox wrote:
> On Tue, Jan 02, 2001 at 01:03:48AM -0800, David S. Miller wrote:
> > If you require an external agent (f.e. your spinlock) because you
> > cannot implement xchg with a real atomic sequence, this breaks the
> > above assumptions.
> 
> We really can't.  We _only_ have load-and-zero.  And it has to be 16-byte
> aligned.  xchg() is just not something the CPU implements.

The network code relies on the reader-xchg semantics David described in 
several places.

-Andi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
