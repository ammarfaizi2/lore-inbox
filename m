Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265887AbSKBG7t>; Sat, 2 Nov 2002 01:59:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265888AbSKBG7t>; Sat, 2 Nov 2002 01:59:49 -0500
Received: from thunk.org ([140.239.227.29]:24475 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id <S265887AbSKBG7s>;
	Sat, 2 Nov 2002 01:59:48 -0500
Date: Sat, 2 Nov 2002 02:06:07 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Dax Kelson <dax@gurulabs.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com, davej@suse.de
Subject: Re: Filesystem Capabilities in 2.6?
Message-ID: <20021102070607.GB16100@think.thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Dax Kelson <dax@gurulabs.com>,
	Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
	torvalds@transmeta.com, davej@suse.de
References: <20021101085148.E105A2C06A@lists.samba.org> <1036175565.2260.20.camel@mentor>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1036175565.2260.20.camel@mentor>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 01, 2002 at 11:32:43AM -0700, Dax Kelson wrote:
> 
> On Fri, 2002-11-01 at 01:49, Rusty Russell wrote:
> > I'm down to 8 undecided features: 6 removed and one I missed earlier.
> 
> How about Olaf Dietsche's filesystem capabilities support? It has been
> posted a couple times to LK, yesterday even.

Ugh.  Personally, as I've said, I'm not convinced filesystem
capabilities is worth it, providing the illusion of security --- and
probably will make most systems more insecure because most system
administrators won't be able to deal with fs capabilties competently.

HOWEVER, if we're going to do it, Olaf's patches is really not the way
to do it.  If we're going to do it at all, the right way to do it is
via extended attributes.  Using a sparse file to store capabilities
indexed by inode numbers is a bad idea; it will break if the user uses
resize2fs on an ext2/3 filesystem, for example.

						- Ted
