Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267458AbRGTWwx>; Fri, 20 Jul 2001 18:52:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267466AbRGTWwc>; Fri, 20 Jul 2001 18:52:32 -0400
Received: from suntan.tandem.com ([192.216.221.8]:39594 "EHLO
	suntan.tandem.com") by vger.kernel.org with ESMTP
	id <S267458AbRGTWwZ>; Fri, 20 Jul 2001 18:52:25 -0400
Message-ID: <3B58B186.4D23D1A3@compaq.com>
Date: Fri, 20 Jul 2001 15:32:38 -0700
From: "Brian J. Watson" <Brian.J.Watson@compaq.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Common hash table implementation
In-Reply-To: <oupitgqjxoi.fsf@pigdrop.muc.suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Andi Kleen wrote:
> It's a "fuzzy hash", which is a bit different from the normal hash and
> probably not always appropiate.
> 
> It was at one point used in the dcache but then later ripped out again
> when the data structures changed.
> 

Ahh. I'm not familiar with fuzzy hashes, but I suspected they might
not be what I was interested in.


> I would like to see a generic hash abstraction in the spirit of list.h
> Especially if it would NOT use normal list_heads as open hash table
> heads but instead single pointers for the head [currently some important
> 
> hash tables like the inode hash are twice as big as needed because
> each bucket is two pointers instead of one]
> 

I agree. Hash tables such as inode_hashtable and dentry_hashtable are
half as efficient under stress as they would otherwise be, because
they use an array of list_heads.

OTOH, I have no objections to using list_heads in other applications
where a singly-linked list is all that's needed. Common code is a Good
Thing. I'm just commenting specifically on hash table implementations,
which tend to be used for really _big_ data structures.


-- 
Brian Watson                 | "The common people of England... so 
Linux Kernel Developer       |  jealous of their liberty, but like the 
Open SSI Clustering Project  |  common people of most other countries 
Compaq Computer Corp         |  never rightly considering wherein it 
Los Angeles, CA              |  consists..."
                             |      -Adam Smith, Wealth of Nations,
1776

mailto:Brian.J.Watson@compaq.com
http://opensource.compaq.com/
