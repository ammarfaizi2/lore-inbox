Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264674AbRFTITT>; Wed, 20 Jun 2001 04:19:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264853AbRFTITJ>; Wed, 20 Jun 2001 04:19:09 -0400
Received: from gateway.sequent.com ([192.148.1.10]:4164 "EHLO
	gateway.sequent.com") by vger.kernel.org with ESMTP
	id <S264674AbRFTITG>; Wed, 20 Jun 2001 04:19:06 -0400
Message-Id: <200106200818.BAA27120@eng4.sequent.com>
To: linux-kernel@vger.kernel.org
Subject: Locking document available for general review
Date: Wed, 20 Jun 2001 01:18:54 -0700
From: Rick Lindsley <nevdull@sequent.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So long as what locks are used for, and when to use them remains a
black art, tuning for large system scalability will be limited to
people with the time to puzzle out if a lock is truly being used
correctly or they are, in fact, staring at a bug.

In an effort to assist both scalability and kernel-janitor efforts, I
have produced a reference document which describes (I believe) all of
the current global spin locks in use in the 2.4.5 kernel.

I am not so vain as to believe that after a couple of months of study
that I am now suddenly experts on all varieties and usages of locks.  I
have refrained from saying, in most cases, that a lock is "used
wrongly" or "completely unnecessary".  Instead, I encourage you, the
community to inspect the document, and correct or enhance it where
appropriate. It has already been reviewed by some people in the
community and on the lse-tech sourceforge list (thank you for your
feedback!) but I know there are more knowledgable people out there.

This is not a paper on "how" to do locking.  There is a document in the
Documentation directory that already gives a brief tutorial on that,
and I intend to inspect it next and update it if appropriate. This is
more of a reference document; hopefully useful but no doubt, dry
reading.

I'll take comments and feedback until July 8, after which I'll propose
the updated document be made part of usr/src/linux/Documentation.

The document does not cover static spin locks, nor spin locks declared
within structures.  While these can be key understandings, they are
typically less obfuscated in their usage simply by their declaration:
barring unusual constructs, statics are limited to the file in which
they are declared, and spin locks in a structure usually guard the
structure or some element in it.

The document can be found through the LSE project:

	    http://sourceforge.net/projects/lse

or directly through

	    http://lse.sourceforge.net/lockhier/global-spin-lock

Comments to me, or the list if they are of a general nature.

thanks,
Rick
