Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266295AbUH1CJE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266295AbUH1CJE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 22:09:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268102AbUH1CI4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 22:08:56 -0400
Received: from fw.osdl.org ([65.172.181.6]:45450 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266295AbUH1CIr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 22:08:47 -0400
Date: Fri, 27 Aug 2004 19:05:35 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Rik van Riel <riel@redhat.com>
cc: Spam <spam@tnonline.net>, Jamie Lokier <jamie@shareable.org>,
       Hans Reiser <reiser@namesys.com>, David Masover <ninja@slaphack.com>,
       Diego Calleja <diegocg@teleline.es>, christophe@saout.de,
       vda@port.imtp.ilyichevsk.odessa.ua, christer@weinigel.se,
       Andrew Morton <akpm@osdl.org>, wichert@wiggy.net, jra@samba.org,
       hch@lst.de, linux-fsdevel@vger.kernel.org,
       Kernel Mailing List <linux-kernel@vger.kernel.org>, flx@namesys.com,
       reiserfs-list@namesys.com,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: Re: silent semantic changes with reiser4
In-Reply-To: <Pine.LNX.4.44.0408272158560.10272-100000@chimarrao.boston.redhat.com>
Message-ID: <Pine.LNX.4.58.0408271902410.14196@ppc970.osdl.org>
References: <Pine.LNX.4.44.0408272158560.10272-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 27 Aug 2004, Rik van Riel wrote:
> 
> Thing is, there is no way to distinguish between what are
> virtual files and what are actual streams hidden inside a
> file.  You don't know what should and shouldn't be backed
> up...

I think that lack of distinguishing poiwer is more serious for 
directories. The more I think I think about it, the more I wonder whether 
Solaris did things right - having a special operation to "cross the 
boundary".

I suspect Solaris did it that way because it's a hell of a lot easier to 
do it like that, but regardless, it would solve the issue of real 
directories having both real children _and_ the "extra streams".

		Linus
