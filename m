Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130018AbRABMTv>; Tue, 2 Jan 2001 07:19:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130643AbRABMTm>; Tue, 2 Jan 2001 07:19:42 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:57607 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S130018AbRABMTa>;
	Tue, 2 Jan 2001 07:19:30 -0500
Date: Tue, 2 Jan 2001 11:22:42 +0000
From: Matthew Wilcox <matthew@wil.cx>
To: "David S. Miller" <davem@redhat.com>
Cc: grundler@cup.hp.com, linux-kernel@vger.kernel.org,
        alan@lxorguk.ukuu.org.uk, parisc-linux@thepuffingroup.com
Subject: Re: [PATCH] move xchg/cmpxchg to atomic.h
Message-ID: <20010102112242.A7040@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <200101020811.AAA26525@milano.cup.hp.com> <200101020903.BAA14334@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <200101020903.BAA14334@pizda.ninka.net>; from davem@redhat.com on Tue, Jan 02, 2001 at 01:03:48AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 02, 2001 at 01:03:48AM -0800, David S. Miller wrote:
> If you require an external agent (f.e. your spinlock) because you
> cannot implement xchg with a real atomic sequence, this breaks the
> above assumptions.

We really can't.  We _only_ have load-and-zero.  And it has to be 16-byte
aligned.  xchg() is just not something the CPU implements.

-- 
Revolutions do not require corporate support.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
