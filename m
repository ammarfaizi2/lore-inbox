Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964872AbWAFWlr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964872AbWAFWlr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 17:41:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964873AbWAFWlr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 17:41:47 -0500
Received: from iabervon.org ([66.92.72.58]:56842 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S964872AbWAFWlq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 17:41:46 -0500
Date: Fri, 6 Jan 2006 17:43:21 -0500 (EST)
From: Daniel Barkalow <barkalow@iabervon.org>
To: Al Viro <viro@ftp.linux.org.uk>
cc: Luiz Fernando Capitulino <lcapitulino@mandriva.com.br>,
       akpm <akpm@osdl.org>, axboe@suse.de,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] bio: gcc warning fix.
In-Reply-To: <20060106153950.GV27946@ftp.linux.org.uk>
Message-ID: <Pine.LNX.4.64.0601061732210.25300@iabervon.org>
References: <20060106130729.31561730.lcapitulino@mandriva.com.br>
 <20060106153950.GV27946@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Jan 2006, Al Viro wrote:

> On Fri, Jan 06, 2006 at 01:07:29PM -0200, Luiz Fernando Capitulino wrote:
> > 
> >  Fixes the following gcc 4.0.2 warning:
> > 
> > fs/bio.c: In function 'bio_alloc_bioset':
> > fs/bio.c:167: warning: 'idx' may be used uninitialized in this function
> 
> NAK.  There is nothing to fix except for broken logics in gcc.
> Please, do not obfuscate correct code just to make gcc to shut up.
> Especially for this call of warnings; gcc4 *blows* in that area.

Wouldn't it be worthwhile to add -Wno-uninitialized for gcc4, since those 
warnings mostly have to be ignored (and are therefore not useful for 
finding actual uninitialized variables) and make it harder to see other 
types of warnings which might be informative?

This would also reduce the number of patches submitted for correct code, 
since people wouldn't keep having to be told to ignore those warnings.

	-Daniel
*This .sig left intentionally blank*
