Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266200AbUHaB51@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266200AbUHaB51 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 21:57:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266201AbUHaB51
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 21:57:27 -0400
Received: from smtp01.mrf.mail.rcn.net ([207.172.4.60]:11658 "EHLO
	smtp01.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
	id S266200AbUHaB5W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 21:57:22 -0400
Message-ID: <4133DAFD.9060704@pobox.com>
Date: Mon, 30 Aug 2004 21:57:17 -0400
From: Will Dyson <will_dyson@pobox.com>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040819)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Alexander G. M. Smith" <agmsmith@rogers.com>
Cc: akpm@osdl.org, hch@lst.de, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, flx@namesys.com, torvalds@osdl.org,
       reiserfs-list@namesys.com, reiser@namesys.com
Subject: Re: Separating Indexing and Searching (was silent semantic changes
 with reiser4)
References: <584702172685-BeMail@cr593174-a>
In-Reply-To: <584702172685-BeMail@cr593174-a>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander G. M. Smith wrote:

> Not only bloat, but time wasted reinventing the wheel.  For my 
> experimental file system 
> (http://members.rogers.com/agmsbeos/AGMSRAMFileSystem.readme - see 
> the Nifty Features chapter), I had to figure out the BFS query

I had a look. Cool stuff!

> I like that.  Put the indexing and a related attribute change update 
> notification mechanism into the kernel.  User land libraries can 
> build on that to implement whatever query language you want, thus 
> saving work and having a common language for all file system 
> varieties that support indices.

Yeah, thats basicly what I was thinking. Right now I'm trying to think
of any kind of filesystem that could support the general concept of 
"Fast Searching", but be somehow unable to export this capability as a 
set of indices on file attributes....

Ok. I give up. It seems like the right abstraction to me.

> However, one of my (unfinished) experiments was to have magic 
> directories that show query results as their contents.  One attribute
>  of the directory (or even its name) would be the query string.  That
>  way even old software (like "ls") could use queries!  Implementing 
> queries-as-directories might require moving some things back into the
>  kernel, or at least into some plug-in level.

That is a pretty awesome idea. It should be done in its own specialized
filesystem though. QueryFS. If the change-notification mechanism in the
kernel was robust enough (a big if), the rest could be done with a
userspace filesystem (via FUSE). Mount a query, cd into it, run grep,
write a little bash script... Very unixy.

-- 
Will Dyson
"Back off man, I'm a scientist!" -Dr. Peter Venkman
