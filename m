Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268889AbUHaTvM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268889AbUHaTvM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 15:51:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269064AbUHaTur
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 15:50:47 -0400
Received: from octomonkey.vm.bytemark.co.uk ([212.13.209.124]:19984 "EHLO
	octomonkey.vm.bytemark.co.uk") by vger.kernel.org with ESMTP
	id S269075AbUHaTtl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 15:49:41 -0400
Subject: Re: silent semantic changes in reiser4 (brief attempt to document
	the idea of what reiser4 wants to do with metafiles and why
From: Chris Dawes <cmsd2@octomonkey.org.uk>
To: V13 <v13@priest.com>
Cc: Hans Reiser <reiser@namesys.com>, Andrew Morton <akpm@digeo.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, reiserfs-list@namesys.com
In-Reply-To: <200408312055.56335.v13@priest.com>
References: <41323AD8.7040103@namesys.com>
	 <200408312055.56335.v13@priest.com>
Content-Type: text/plain
Message-Id: <1093981768.18249.4.camel@dobbin.local.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 31 Aug 2004 20:49:28 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-08-31 at 18:55, V13 wrote:
...
>   AFAIK and AFAICS the metadata are not files or directories. You can look at 
> them as files/dirs but they are not, just like a tar is not a directory. I 
> believe that the correct thing to do (tm) is to add a new 'concept' named 
> 'metadata' (which already exists). This way you'll have files, directories 
> and metadata (or whatever you call them). So, each directory can have 
> metadatas and files and each file can have metadatas. Then you have to 
> provide some new methods of accessing them and not to use chdir() etc. (lets 
> say chdir_meta() to enter the meta dir which will work for files too). After 
> entering the 'metadir' you'll be able to use existing methods etc to access 
> its 'files'.

I think this is what Hans is trying to avoid -- it results in creating a
separate namespace for the metadata.

I would agree with the notion that metadata nodes are light-weight files
in that they themselves have no metadata associated with them, but I
don't see why they need separate system-calls (if we can help it).

Chris Dawes.


> 
>   This approach doesn't mess with existing things and can be extended for 
> other filesystems too.
> 
> (Just a thought)
> 
> <<V13>>

