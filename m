Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268273AbUIBK4n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268273AbUIBK4n (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 06:56:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268232AbUIBKye
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 06:54:34 -0400
Received: from the-village.bc.nu ([81.2.110.252]:54925 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268223AbUIBKwl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 06:52:41 -0400
Subject: Re: silent semantic changes with reiser4
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jeremy Allison <jra@samba.org>
Cc: Jamie Lokier <jamie@shareable.org>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Rik van Riel <riel@redhat.com>,
       Christer Weinigel <christer@weinigel.se>, Spam <spam@tnonline.net>,
       Andrew Morton <akpm@osdl.org>, wichert@wiggy.net,
       Linus Torvalds <torvalds@osdl.org>, reiser@namesys.com, hch@lst.de,
       Linux Filesystem Development <linux-fsdevel@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       flx@namesys.com, reiserfs-list@namesys.com
In-Reply-To: <20040901202641.GJ4455@legion.cup.hp.com>
References: <Pine.LNX.4.44.0408261011410.27909-100000@chimarrao.boston.redhat.com>
	 <200408261819.59328.vda@port.imtp.ilyichevsk.odessa.ua>
	 <1093789802.27932.41.camel@localhost.localdomain>
	 <1093804864.8723.15.camel@lade.trondhjem.org>
	 <20040829193851.GB21873@jeremy1>
	 <20040901201945.GE31934@mail.shareable.org>
	 <20040901202641.GJ4455@legion.cup.hp.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094118524.4842.27.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 02 Sep 2004 10:48:46 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2004-09-01 at 21:26, Jeremy Allison wrote:
> Right now no, because when Samba refuses the stream open, Word falls
> back into a "tar"-like mode where it linearises the streams into the
> data (it's a legacy mode for storing data on a FAT drive, not an NTFS
> drive). However, the problem is that no currently supported Microsoft
> OS doesn't have streams-capable NTFS support. 

That implies that samba can do the same transform set without kernel
help and you'd even get the advantages of being able to transfer the
stuff around sanely afterwards.

What I don't understand is the tie between Linux having such streams and
Windows doing it for Samba to work. Netatalk has always handle this for
Macintosh and portably. Presumably any Samba support would need to
handle OS's without wacky files for portability too ?

