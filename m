Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262423AbUCLUSL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 15:18:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262368AbUCLUQo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 15:16:44 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:29834 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262423AbUCLUKt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 15:10:49 -0500
Date: Fri, 12 Mar 2004 15:49:55 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Kevin Buhr <buhr@telus.net>
Cc: Jesse Pollard <jesse@cats-chateau.net>, linux-kernel@vger.kernel.org,
       =?iso-8859-2?Q?S=F8renHansen?= <sh@warma.dk>
Subject: Re: UID/GID mapping system
Message-ID: <20040312144955.GB1236@openzaurus.ucw.cz>
References: <04031108083100.05054@tabby> <1078775149.23059.25.camel@luke> <04031015412900.03270@tabby> <20040310234640.GO1144@schnapps.adilger.int> <873c8f18au.fsf@saurus.asaurus.invalid>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <873c8f18au.fsf@saurus.asaurus.invalid>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Here's a simple, typical problem:
> 
> I want to connect a Linux laptop to a network with existing NFS/NIS
> infrastructure in place and mount and use, say, an NFS home directory.
> Unfortunately, the UID mappings differ between the existing
> infrastructure and my laptop.  For example, all the files in my NFS
> directory are all owned by uid=45067 gid=102, but my user and default
> group on the laptop are 1000 and 1000 respectively.
> 
> I don't adminsiter the NFS server; I can't ask the administrator to
> set up a server-side mapping system just for my benefit.  But, I *can*
> convince the administrator to add:
> 
> /home/b/u/buhr mymachine(squash_uids=0-45066,45068-65535,squash_gids=0-100)
> 
> to his exports file.

Well... teach nfsd to accept

...squash_uids=...,map_uid=10000:45067,...

				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

