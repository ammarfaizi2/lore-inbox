Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267478AbUH1RTI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267478AbUH1RTI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 13:19:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267476AbUH1RTI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 13:19:08 -0400
Received: from fw.osdl.org ([65.172.181.6]:62085 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266674AbUH1RTD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 13:19:03 -0400
Date: Sat, 28 Aug 2004 10:18:44 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Alexander Lyamin <flx@msu.ru>
cc: Christoph Hellwig <hch@lst.de>, Christophe Saout <christophe@saout.de>,
       Andrew Morton <akpm@osdl.org>, Hans Reiser <reiser@namesys.com>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, reiserfs-list@namesys.com
Subject: Re:  reiser4 plugins (was: silent semantic changes with reiser4)
In-Reply-To: <20040828105929.GB6746@alias>
Message-ID: <Pine.LNX.4.58.0408281011280.2295@ppc970.osdl.org>
References: <412CEE38.1080707@namesys.com> <20040825152805.45a1ce64.akpm@osdl.org>
 <412D9FE6.9050307@namesys.com> <20040826014542.4bfe7cc3.akpm@osdl.org>
 <1093522729.9004.40.camel@leto.cs.pocnet.net> <20040826124929.GA542@lst.de>
 <1093525234.9004.55.camel@leto.cs.pocnet.net> <20040826130718.GB820@lst.de>
 <1093526273.11694.8.camel@leto.cs.pocnet.net> <20040826132439.GA1188@lst.de>
 <20040828105929.GB6746@alias>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 28 Aug 2004, Alexander Lyamin wrote:
> 
> VFS never was "an integral part" of ANY filesystem. my dog knows it.

That's not really true.

Name handling (dentry layer, mounting) is very much an integral part of
the filesystem. Almost everything else in the VFS is "helper functions",
ie a filesystem can choose to ignore buffer heads, page cache etc, but a 
filesystem really cannot ignore or override the VFS naming stuff.

(Arguably the page cache isn't part of the VFS layer at all, it's really a 
memory management thing, although it's so intertwined with the VFS helper 
functions that you can't really draw the line).

> its just unified INTERFACE TO any filesystem (including reiser4).

True, but that's not the whole truth. It's way more than just an
interface. It's a set of rules, and it's in many way the controlling
party.

		Linus
