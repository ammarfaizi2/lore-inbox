Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261745AbVCGKfs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261745AbVCGKfs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 05:35:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261740AbVCGKfr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 05:35:47 -0500
Received: from mail.fh-wedel.de ([213.39.232.198]:16322 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S261744AbVCGKcw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 05:32:52 -0500
Date: Mon, 7 Mar 2005 11:32:50 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: "Edgar, Bob" <Bob.Edgar@commerzbankib.com>,
       "'Jesper Juhl'" <juhl-lkml@dif.dk>, Steve French <sfrench@us.ibm.com>,
       Luca Tettamanti <kronos@kronoz.cjb.net>,
       samba-technical <samba-technical@lists.samba.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Domen Puncer <domen@coderock.org>
Subject: Re: [PATCH] whitespace cleanups for fs/cifs/file.c
Message-ID: <20050307103250.GC2198@wohnheim.fh-wedel.de>
References: <9D248E1E43ABD411A9B600508BAF6E9B0C737269@xmx7fraib.fra.ib.commerzbank.com> <20050307102846.GF27352@schnapps.adilger.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050307102846.GF27352@schnapps.adilger.int>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 March 2005 03:28:46 -0700, Andreas Dilger wrote:
> 
> Ironically, the whitespace patch gets the small things right, but misses
> on the big readability issues, such as cifs_open() being 220 lines long
> and having a _really_ hard time staying inside 80 columns because of so
> many levels of nested conditionals.
> 
> Judicious use of gotos and some helper functions would help a lot
> here (e.g.  after CIFSSMBOpen() "if (rc) { ... goto out; }" and
> "if (!file->private_data) goto out;", would avoid indenting the rest
> of the function 16 columns.  Adding a couple helper functions like
> "cifs_convert_flags()" to return desiredAccess and disposition, and
> "cifs_init_private_data()" to allocate ->private_data and initialize
> the masses of fields would be good.
> 
> Is it possible that pCifsInode can ever be NULL???  Similarly, "if (buf)"
> on line 196 is needless, as it has already been checked on line 153
> (and we abort in that case).  Also, kfree() can handle NULL pointers.

Jesper knows those problems already (at least some of them).  Right
now, his biggest problem appears to be patch submission.  As soon as
Steve accepts his patches and the backlog is shrinking, he might get
to those issues, one at a time.

Unless my glass ball needs cleaning again.  Jesper? ;)

Jörn

-- 
The competent programmer is fully aware of the strictly limited size of
his own skull; therefore he approaches the programming task in full
humility, and among other things he avoids clever tricks like the plague. 
-- Edsger W. Dijkstra
