Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267653AbUIGGoZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267653AbUIGGoZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 02:44:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267648AbUIGGoY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 02:44:24 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:51420 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S267634AbUIGGoV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 02:44:21 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: mjt@nysv.org (Markus  =?ISO-8859-1?Q?=20T=F6rnqvist?=)
Date: Tue, 7 Sep 2004 16:43:11 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16701.22655.230704.534640@cse.unsw.edu.au>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Pavel Machek <pavel@ucw.cz>,
       David Masover <ninja@slaphack.com>, Jamie Lokier <jamie@shareable.org>,
       Chris Wedgwood <cw@f00f.org>, viro@parcelfarce.linux.theplanet.co.uk,
       Christoph Hellwig <hch@lst.de>, Hans Reiser <reiser@namesys.com>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
In-Reply-To: message from Markus    =?ISO-8859-1?Q?=20T=F6rnqvist?= on Wednesday September 1
References: <200408311931.i7VJV8kt028102@laptop11.inf.utfsm.cl>
	<Pine.LNX.4.58.0408311252150.2295@ppc970.osdl.org>
	<20040901194445.GM26192@nysv.org>
X-Mailer: VM 7.18 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday September 1, mjt@nysv.org wrote:
> On Tue, Aug 31, 2004 at 01:05:40PM -0700, Linus Torvalds wrote:
> >
> >There's no point to having the kernel export information that is already 
> >inherent in the main stream.

Having read this quote a few times in this thread I finally figured
out what was wrong with it.

It seems to imply that "iso9660" shouldn't be in the kernel.  After
all, it just exports information that is already in the underlying
device. 
It doesn't provide any "mediate multiple access" benefit as a
read-only filesystem doesn't require any mediation between users.
It might provide some caching benefit, but I somehow don't think that
is the reason that it is in the kernel.

Now I'm happy to agree that there is a case for "iso9660" but not for
"tarfs", but I don't think it is that "there's no point to having the
kernel export information that is already [there]"

NeilBrown
