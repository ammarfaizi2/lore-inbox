Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268204AbUHYS3M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268204AbUHYS3M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 14:29:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268200AbUHYS3M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 14:29:12 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:687 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S268197AbUHYS3B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 14:29:01 -0400
Message-ID: <412CDA68.7050702@namesys.com>
Date: Wed, 25 Aug 2004 11:28:56 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: viro@parcelfarce.linux.theplanet.co.uk
CC: Linus Torvalds <torvalds@osdl.org>, Christoph Hellwig <hch@lst.de>,
       akpm@osdl.org, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>,
       Reiserfs developers mail-list <Reiserfs-Dev@namesys.com>
Subject: Re: silent semantic changes with reiser4
References: <20040824202521.GA26705@lst.de> <412BA741.4060006@pobox.com> <20040824205343.GE21964@parcelfarce.linux.theplanet.co.uk> <20040824212232.GF21964@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20040824212232.GF21964@parcelfarce.linux.theplanet.co.uk>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I allowed myself to get talked out of a final top to bottom code audit, 
and obviously that was a mistake.

It will probably take about 6 weeks.  Apologies for wasting your time 
before that was done.

Hans


viro@parcelfarce.linux.theplanet.co.uk wrote:

>On Tue, Aug 24, 2004 at 09:53:44PM +0100, viro@parcelfarce.linux.theplanet.co.uk wrote:
> 
>  
>
>>Feh.  That's far from the worst parts of the mess introduced by "hybrid"
>>crap - trivial sys_link(2) deadlocks triggerable by any user rate a bit
>>higher on the suckitude scale, IMO.
>>    
>>
>
>While we are at it - consider these hybrids vetoed until
>	a) sys_link()/sys_link() deadlock is fixed
>	b) sys_link()/sys_rename() deadlock is fixed
>	c) correctness proof of the locking scheme (in
>Documentation/filesystems/directory-locking) is updated to match the
>presense of the file/directory hybrids.
>
>Rationale: (a) and (b) - immediately exploitable by any user, (c) - "convince
>us that there's no more crap of that kind".  IMO a reasonable request, seeing
>that the first look at the patches in -mm4 had turned up two exploits in
>that area, despite the *YEARS* of warnings about potential trouble and need
>to be careful there (actually, I've given Hans too much credit and assumed
>that link/link never happens since nobody would be dumb enough to provide
>->link() method for non-directory inodes; turns out that somebody is dumb
>enough and link/link is as exploitable as link/rename).
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
>  
>

