Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275683AbRIZXFM>; Wed, 26 Sep 2001 19:05:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275685AbRIZXFG>; Wed, 26 Sep 2001 19:05:06 -0400
Received: from helen.CS.Berkeley.EDU ([128.32.131.251]:16569 "EHLO
	helen.CS.Berkeley.EDU") by vger.kernel.org with ESMTP
	id <S275683AbRIZXE7>; Wed, 26 Sep 2001 19:04:59 -0400
Date: Wed, 26 Sep 2001 16:05:20 -0700
From: Josh MacDonald <jmacd@CS.Berkeley.EDU>
To: linux-kernel@vger.kernel.org
Subject: Is <linux/ghash.h> dead?
Message-ID: <20010926160520.C18363@helen.CS.Berkeley.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I cannot find any code in the main tree that depends on this header
file.  Furthermore, I am somewhat skeptical of the algorithms.  Maybe
the first comment has scared people away:

    "The algorithms implemented here seem to be a completely new
    invention, and I'll publish the fundamentals in a paper."

It defines two generic hash table classes using C preprocessor macros,
a "fuzzy" hash and an ordinary hash.

The "fuzzy" hash class is useless without a description.  What does
find_hash_fuzzy do?

The ordinary hash class maintains an ring-ordered doubly-linked list
of entries for each hash synonym, and it performs a move-to-front
heuristic on insertion (but not for the find operation).  

The second and final comment ("HASHSIZE _must_ be a power of two!!!")
does not apply to the ordinary hash class.

Would anyone care defend either of these hash classes?

-josh
