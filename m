Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268288AbUH2Ti5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268288AbUH2Ti5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 15:38:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268285AbUH2Ti5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 15:38:57 -0400
Received: from dp.samba.org ([66.70.73.150]:11167 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S268283AbUH2Tiy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 15:38:54 -0400
Date: Sun, 29 Aug 2004 12:38:51 -0700
From: Jeremy Allison <jra@samba.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Rik van Riel <riel@redhat.com>,
       Christer Weinigel <christer@weinigel.se>, Spam <spam@tnonline.net>,
       Andrew Morton <akpm@osdl.org>, wichert@wiggy.net, jra@samba.org,
       Linus Torvalds <torvalds@osdl.org>, reiser@namesys.com, hch@lst.de,
       Linux Filesystem Development <linux-fsdevel@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       flx@namesys.com, reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040829193851.GB21873@jeremy1>
Reply-To: Jeremy Allison <jra@samba.org>
References: <Pine.LNX.4.44.0408261011410.27909-100000@chimarrao.boston.redhat.com> <200408261819.59328.vda@port.imtp.ilyichevsk.odessa.ua> <1093789802.27932.41.camel@localhost.localdomain> <1093804864.8723.15.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1093804864.8723.15.camel@lade.trondhjem.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 29, 2004 at 02:41:04PM -0400, Trond Myklebust wrote:
> 
> NFSv4 has an OPENATTR call which acts on files to return a filehandle
> that works fine with both READDIR and LOOKUP, so if a VFS interface for
> streams existed, we could code up full support tomorrow.
> As it is, we're having to shoehorn this into the xattr interface. 8-(

Yeah, that's what I'm really trying to avoid for Samba.
We're currently using the xattr interface for DOS attributes,
and soon for NT ACL support, but it doesn't really fit as
a streams interface (no lseek() support) although someone in
HP coded up a test interface to NT streams that map into xattrs
(most of the streams in a Word file for instance are quite
small) - but I really don't want to have to do this :-).

Jeremy.
