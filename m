Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264726AbUIBA24@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264726AbUIBA24 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 20:28:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267831AbUIAU1j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 16:27:39 -0400
Received: from dp.samba.org ([66.70.73.150]:41123 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S267786AbUIAU0q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 16:26:46 -0400
Date: Wed, 1 Sep 2004 13:26:41 -0700
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
Message-ID: <20040901202641.GJ4455@legion.cup.hp.com>
Reply-To: Jeremy Allison <jra@samba.org>
References: <Pine.LNX.4.44.0408261011410.27909-100000@chimarrao.boston.redhat.com> <200408261819.59328.vda@port.imtp.ilyichevsk.odessa.ua> <1093789802.27932.41.camel@localhost.localdomain> <1093804864.8723.15.camel@lade.trondhjem.org> <20040829193851.GB21873@jeremy1> <20040901201945.GE31934@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040901201945.GE31934@mail.shareable.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 01, 2004 at 09:19:45PM +0100, Jamie Lokier wrote:
> Jeremy Allison wrote:
> > (most of the streams in a Word file for instance are quite small)
> 
> Streams in a Word file?

Yep.

> Are you saying that when I copy a .doc file onto my Linux box and off,
> I lose part of a Word document?

Right now no, because when Samba refuses the stream open, Word falls
back into a "tar"-like mode where it linearises the streams into the
data (it's a legacy mode for storing data on a FAT drive, not an NTFS
drive). However, the problem is that no currently supported Microsoft
OS doesn't have streams-capable NTFS support. 

This means that in a future MS-Office revision, this backwards support
may be broken by accident or by design (less likely, Microsoft really
don't do that kind of thing without very high level requests :-) and no
testers at Microsoft will notice (because they only test against MS servers).

Jeremy.
