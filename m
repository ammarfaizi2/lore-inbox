Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265805AbUFISep@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265805AbUFISep (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 14:34:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265815AbUFISep
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 14:34:45 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:29623 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S265805AbUFISen (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 14:34:43 -0400
Date: Wed, 9 Jun 2004 20:34:42 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Hans Reiser <reiser@namesys.com>
Cc: Chris Mason <mason@suse.com>, reiserfs-dev@namesys.com,
       linux-kernel@vger.kernel.org
Subject: Re: [STACK] >3k call path in reiserfs
Message-ID: <20040609183442.GD2950@wohnheim.fh-wedel.de>
References: <20040609122226.GE21168@wohnheim.fh-wedel.de> <1086784264.10973.236.camel@watt.suse.com> <1086800028.10973.258.camel@watt.suse.com> <40C74388.20301@namesys.com> <20040609172843.GB2950@wohnheim.fh-wedel.de> <40C75273.7020508@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <40C75273.7020508@namesys.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 June 2004 11:09:55 -0700, Hans Reiser wrote:
> Jörn Engel wrote:
> >
> >...but note that my signature ai has proven it's merits once again...
> >
> what is your signature ai?

fortune.  It is clearly artificial and it's results prove high
intelligence sometimes. ;)

> Unless it is really necessary, or a small code change, I would prefer to 
> spend our cycles worrying about this in reiser4, because code changes in 
> V3 are to be avoided if possible.

Fair enough.

> I am open to arguments that it is really necessary.

The main argument is that you are already "this close" to the limit
and future code changes (in reiserfs or in unrelated functions called
before or after reiserfs) will blow said limit.

Since reiser3 won't get many changes anymore and other code should
generally get enhanced, rather than degraded, you should be pretty
safe.

Is there a simple way to tell reiser3 functions from reiser4, btw?
Something similar to ext2/ext3 would be nice.

Jörn

-- 
Beware of bugs in the above code; I have only proved it correct, but
not tried it.
-- Donald Knuth
