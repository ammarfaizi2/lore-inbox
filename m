Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265612AbSKAFH6>; Fri, 1 Nov 2002 00:07:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265624AbSKAFH6>; Fri, 1 Nov 2002 00:07:58 -0500
Received: from d196069.dynamic.cmich.edu ([141.209.196.69]:36758 "EHLO euclid")
	by vger.kernel.org with ESMTP id <S265612AbSKAFH5> convert rfc822-to-8bit;
	Fri, 1 Nov 2002 00:07:57 -0500
Content-Type: text/plain; charset=US-ASCII
From: "Matthew J. Fanto" <mattf@mattjf.com>
Reply-To: mattf@mattjf.com
Organization: mattjf.com
To: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: The Ext3sj Filesystem
Date: Fri, 1 Nov 2002 00:14:10 -0500
User-Agent: KMail/1.4.3
References: <200210301434.17901.mattf@mattjf.com> <20021101044153.GB12031@think.thunk.org>
In-Reply-To: <20021101044153.GB12031@think.thunk.org>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200211010014.10232.mattf@mattjf.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 31 October 2002 11:41 pm, Theodore Ts'o wrote:

> First of all, have you considered trying to do this as a stacking
> filesystem?  

Yes, I spoke to Christoph Hellwig the other day and he suggested the same 
thing. I will be taking a look at a stacking filesystem tonight/tomorrow. 

> Secondly, the really critical question is key management.  What
> happens if the user gets the key wrong?  Will he/she know?  Or will
> they just get garbage if the read from the file, and be able to trash
> the file if they write to the file with the incorrect key?  Using some
> kind of key-ID and some way of validating that the key is correct
> before the user does start accessing files would probably be a really
> good idea.

It wouldn't be very hard to alert the user of an incorrect key using a message 
digest (SHA1). So far, I haven't implemented this feature, but I will if 
enough people want it.

> Finally, if you do want to allocate some additional fields in the ext2
> inode, superblock, etc., please coordinate with me, so we can avoid
> conflicts as much as possible.  Thanks!!

Yes, there will be a need for additional fields specifying things such as the 
algorithm to use.





