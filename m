Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268003AbUIAU7u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268003AbUIAU7u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 16:59:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267594AbUIAUyo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 16:54:44 -0400
Received: from dp.samba.org ([66.70.73.150]:15800 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S267519AbUIAUvm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 16:51:42 -0400
Date: Wed, 1 Sep 2004 13:51:40 -0700
From: Jeremy Allison <jra@samba.org>
To: Jamie Lokier <jamie@shareable.org>
Cc: Jeremy Allison <jra@samba.org>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Rik van Riel <riel@redhat.com>,
       Christer Weinigel <christer@weinigel.se>, Spam <spam@tnonline.net>,
       Andrew Morton <akpm@osdl.org>, wichert@wiggy.net,
       Linus Torvalds <torvalds@osdl.org>, reiser@namesys.com, hch@lst.de,
       Linux Filesystem Development <linux-fsdevel@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       flx@namesys.com, reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040901205140.GL4455@legion.cup.hp.com>
Reply-To: Jeremy Allison <jra@samba.org>
References: <Pine.LNX.4.44.0408261011410.27909-100000@chimarrao.boston.redhat.com> <200408261819.59328.vda@port.imtp.ilyichevsk.odessa.ua> <1093789802.27932.41.camel@localhost.localdomain> <1093804864.8723.15.camel@lade.trondhjem.org> <20040829193851.GB21873@jeremy1> <20040901201945.GE31934@mail.shareable.org> <20040901202641.GJ4455@legion.cup.hp.com> <20040901203101.GG31934@mail.shareable.org> <20040901203543.GK4455@legion.cup.hp.com> <20040901204746.GI31934@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040901204746.GI31934@mail.shareable.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 01, 2004 at 09:47:46PM +0100, Jamie Lokier wrote:
> Jeremy Allison wrote:
> > > I meant when I copy not using Samba.  For example, I copy the .doc
> > > file in Windows NT to an FTP server.
> > > 
> > > Does the FTP operation magically linearise the .doc streams on demand?
> > > Or does FTP lose part of the Word document?
> > 
> > Good question. It depends if the Microsoft ftp client is streams-aware,
> > and understands the Microsoft OLE structured storage format and will do
> > the linearisation on demand or not. I must confess I haven't tested this,
> > as I don't ever run Windows other than on vmware sessions for Samba testing
> > these days :-).
> > 
> > Probably a non-Microsoft ftp client would lose part of the word doc.
> 
> So you're saying SCP, CVS, Subversion, Bitkeeper, Apache and rsyncd
> will _all_ lose part of a Word document when they handle it on a
> Window box?
> 
> Ouch!

Yep. It's the meta data that Word stores in streams that will get lost.

Jeremy.
