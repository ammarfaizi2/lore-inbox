Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269179AbUHaUmh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269179AbUHaUmh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 16:42:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269178AbUHaUlT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 16:41:19 -0400
Received: from fw.osdl.org ([65.172.181.6]:26074 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269179AbUHaUjM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 16:39:12 -0400
Date: Tue, 31 Aug 2004 13:38:42 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Pavel Machek <pavel@ucw.cz>
cc: Horst von Brand <vonbrand@inf.utfsm.cl>,
       David Masover <ninja@slaphack.com>, Jamie Lokier <jamie@shareable.org>,
       Chris Wedgwood <cw@f00f.org>, viro@parcelfarce.linux.theplanet.co.uk,
       Christoph Hellwig <hch@lst.de>, Hans Reiser <reiser@namesys.com>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
In-Reply-To: <20040831203226.GB16110@elf.ucw.cz>
Message-ID: <Pine.LNX.4.58.0408311336580.2295@ppc970.osdl.org>
References: <200408311931.i7VJV8kt028102@laptop11.inf.utfsm.cl>
 <Pine.LNX.4.58.0408311252150.2295@ppc970.osdl.org> <20040831203226.GB16110@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 31 Aug 2004, Pavel Machek wrote:
> 
> It buys me caching.

I'll actually buy into that. If only because I consider caching to be one 
of the more important things that the kernel does (caches are a _classic_ 
case of "shared data that needs synchronization").

However, that said, user space can trivially cache things in the 
filesystem, so while this may be a convenient feature, I think you should 
look at perhaps doing it in the _shell_ instead..

		Linus
