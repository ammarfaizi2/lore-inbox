Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274746AbRIUDYT>; Thu, 20 Sep 2001 23:24:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274750AbRIUDYJ>; Thu, 20 Sep 2001 23:24:09 -0400
Received: from zok.sgi.com ([204.94.215.101]:21383 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S274746AbRIUDYA>;
	Thu, 20 Sep 2001 23:24:00 -0400
Message-Id: <200109210325.f8L3PKi20270@jen.americas.sgi.com>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: Steve Lord <lord@sgi.com>, hch@ns.caldera.de,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "Gonyou, Austin" <austin@coremetrics.com>,
        narancs@narancs.tii.matav.hu, linux-xfs@oss.sgi.com,
        linux-kernel@vger.kernel.org
Subject: Re: XFS to main kernel source 
In-Reply-To: Message from Andreas Dilger <adilger@turbolabs.com> 
   of "Thu, 20 Sep 2001 21:12:21 MDT." <20010920211221.G14526@turbolinux.com> 
Date: Thu, 20 Sep 2001 22:25:20 -0500
From: Steve Lord <lord@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sep 20, 2001  16:31 -0500, Steve Lord wrote:
> > XFS quotas are transactional, when space is added to a file the quota is
> > adjusted in the same transaction. It is fairly hard to do this without your
> > own quota code.
> 
> Actually not.  The quotas in ext3 are transactional as well.  It's just
> that the "ext3" journal layer allows nested transactions, so it is possible
> to start a write transaction, call into the journal code which calls back
> into the ext3 write code to start a nested transaction on the journal file
> (i.e. it is in the same transaction as the initial write), and then the
> initial write completes.

OK, good point, but doing a major rewrite of XFS to use a different
transaction mechanism is not really on the cards, plus we have on disk
compatibility with the Irix version to consider.

Steve



