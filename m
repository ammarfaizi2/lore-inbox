Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266717AbUFYMIP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266717AbUFYMIP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 08:08:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266720AbUFYMIP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 08:08:15 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:53913 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S266717AbUFYMIJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 08:08:09 -0400
Subject: Re: Elastic Quota File System (EQFS)
From: Josh Boyer <jdub@us.ibm.com>
To: Pavel Machek <pavel@suse.cz>
Cc: alan <alan@clueserver.org>, "Fao, Sean" <Sean.Fao@dynextechnologies.com>,
       linux-kernel@vger.kernel.org, Amit Gud <gud@eth.net>
In-Reply-To: <20040625001545.GI20649@elf.ucw.cz>
References: <20040624220318.GE20649@elf.ucw.cz>
	 <Pine.LNX.4.44.0406241544010.19187-100000@www.fnordora.org>
	 <20040625001545.GI20649@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1088165267.8241.7.camel@weaponx.rchland.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 25 Jun 2004 07:07:48 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-06-24 at 19:15, Pavel Machek wrote:

> > A better option in this case is to reduce the default size of Mozilla's 
> > cache or expand the size of the quota for each user to deal with the added 
> > space requirements.
> > 
> > If you are concerned about disk usage from caches, you can always create 
> > a script that removes the cache(s) when the user logs out.
> 
> That's not the right thing.. that way you loose caching effects around
> logins even when there's plenty of space.
> 
> There's quite a lot of data -- at least on my systems -- that can be
> removed with "only" loss of performance...
> 
> 1) browser caches
> 
> 2) package lists, downloaded packages
> 
> 3) object files
> 
> heck, if you know you have reliable network connection 4), you could
> even mark stuff like /usr/bin/mozilla elastic, and re-install it from
> the network when it is needed... Doing anything more complex than 1)
> requires extensive changes all around the kernel and userland, and
> you'd probably not call that system unix any more.
> 
> I'm not saying that "elastic" feature should go into 2.6 or 2.8 or
> whatever, but it still seems interesting to me.

Couldn't most of this be done in userspace with xattrs and a "elastic
quota" daemon?  Mark such files as elastic with an xattr, and when space
is needed for user N, the daemon comes along and deletes the marked
files.  You could even make the deamon semi-smart and take things such
as filesize, least recently used files, etc into account.

Or maybe I am missing something... wouldn't be the first time.

josh

