Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267810AbUIAXQm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267810AbUIAXQm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 19:16:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267594AbUIAXOa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 19:14:30 -0400
Received: from mail.shareable.org ([81.29.64.88]:11722 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S267545AbUIAUtQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 16:49:16 -0400
Date: Wed, 1 Sep 2004 21:47:46 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Jeremy Allison <jra@samba.org>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
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
Message-ID: <20040901204746.GI31934@mail.shareable.org>
References: <Pine.LNX.4.44.0408261011410.27909-100000@chimarrao.boston.redhat.com> <200408261819.59328.vda@port.imtp.ilyichevsk.odessa.ua> <1093789802.27932.41.camel@localhost.localdomain> <1093804864.8723.15.camel@lade.trondhjem.org> <20040829193851.GB21873@jeremy1> <20040901201945.GE31934@mail.shareable.org> <20040901202641.GJ4455@legion.cup.hp.com> <20040901203101.GG31934@mail.shareable.org> <20040901203543.GK4455@legion.cup.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040901203543.GK4455@legion.cup.hp.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeremy Allison wrote:
> > I meant when I copy not using Samba.  For example, I copy the .doc
> > file in Windows NT to an FTP server.
> > 
> > Does the FTP operation magically linearise the .doc streams on demand?
> > Or does FTP lose part of the Word document?
> 
> Good question. It depends if the Microsoft ftp client is streams-aware,
> and understands the Microsoft OLE structured storage format and will do
> the linearisation on demand or not. I must confess I haven't tested this,
> as I don't ever run Windows other than on vmware sessions for Samba testing
> these days :-).
> 
> Probably a non-Microsoft ftp client would lose part of the word doc.

So you're saying SCP, CVS, Subversion, Bitkeeper, Apache and rsyncd
will _all_ lose part of a Word document when they handle it on a
Window box?

Ouch!

The only sensible implementation I can imagine would be if the OS
linearised multi-stream Word documents into the non-stream format
automatically for all programs which don't know about streams.

Which is of course what I would like to implement for Linux...

- Jamie
