Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261431AbREVBN7>; Mon, 21 May 2001 21:13:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261427AbREVBNt>; Mon, 21 May 2001 21:13:49 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:12049 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261309AbREVBNm>; Mon, 21 May 2001 21:13:42 -0400
Date: Mon, 21 May 2001 18:13:18 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Matthew Wilcox <matthew@wil.cx>
cc: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        Alexander Viro <viro@math.psu.edu>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Pavel Machek <pavel@suse.cz>,
        Richard Gooch <rgooch@ras.ucalgary.ca>,
        Andrew Clausen <clausen@gnu.org>, Ben LaHaise <bcrl@redhat.com>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFD w/info-PATCH] device arguments from lookup, partion code
In-Reply-To: <20010522015714.K23718@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.31.0105211812510.17857-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 22 May 2001, Matthew Wilcox wrote:
>
> > command + rw-transaction: "dear device please mangle this data"
> >    (crypto processors come to mind...)
>
> I can't think of a reasonable tool-based approach to this, but I can
> definitely see that a program could use this well.  It simply requires
> that you use the filp to store your state.

Nope. You can (and people do, quite often) share filps. So you can't
associate state with it.

		Linus

