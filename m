Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261825AbUCKXKu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 18:10:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261809AbUCKXKu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 18:10:50 -0500
Received: from mail.shareable.org ([81.29.64.88]:36490 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S261825AbUCKXKl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 18:10:41 -0500
Date: Thu, 11 Mar 2004 23:10:13 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Kevin Buhr <buhr@telus.net>
Cc: Jesse Pollard <jesse@cats-chateau.net>, linux-kernel@vger.kernel.org,
       =?iso-8859-1?Q?S=F8renHansen?= <sh@warma.dk>
Subject: Re: UID/GID mapping system
Message-ID: <20040311231013.GA14310@mail.shareable.org>
References: <04031108083100.05054@tabby> <1078775149.23059.25.camel@luke> <04031015412900.03270@tabby> <20040310234640.GO1144@schnapps.adilger.int> <873c8f18au.fsf@saurus.asaurus.invalid>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <873c8f18au.fsf@saurus.asaurus.invalid>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kevin Buhr wrote:
> Now, I can mount this filesystem on my machine.  Trouble is, I can't
> read or write any of my files.
> 
> Now, I could edit my local "passwd" and "group" files, change the
> ownership of the files in my local home directory, and everything
> would work smashingly.

Been there, done that.  Changed entire home network each time job
changed, so that laptop could play well with work and home machines

It doesn't work as soon as you connect your laptop to different
locations that have different uid mappings - either at different
times, or simultaneously.

I've had desktop machines that had to be simultaneously connected to
servers in different administrative domains to do their daily work.
Naturally group had their own set of users and ids - I just happened
to have an account on each.  It was a pain.

> Bottom line: Søren's patch would be very useful in a number of
> real-world situations.

I agree.  If there's a universal way to hook the mapping to an LDAP or
NIS, so that each mounted server could be accessed using the uid/gid
mappings based on the LDAP/NIS service for that server's
administrative domain, that'd be nice.

Using the NFSv4 upcalls seems like a good way to go about it, and give
uniform results over all the different filesystems including NFS.  Not
that I've looked at any of that code.

-- JAmie
