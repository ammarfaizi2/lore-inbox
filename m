Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264611AbSJRJ6G>; Fri, 18 Oct 2002 05:58:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264616AbSJRJ6G>; Fri, 18 Oct 2002 05:58:06 -0400
Received: from abraham.CS.Berkeley.EDU ([128.32.37.170]:22535 "EHLO
	mx2.cypherpunks.ca") by vger.kernel.org with ESMTP
	id <S264611AbSJRJ6F>; Fri, 18 Oct 2002 05:58:05 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@mozart.cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: [PATCH] remove sys_security
Date: 18 Oct 2002 02:09:28 -0700
Organization: University of California, Berkeley
Distribution: isaac
Message-ID: <aool9n$1fh$1@abraham.cs.berkeley.edu>
References: <3DAFB260.5000206@wirex.com> <Pine.GSO.4.21.0210180309540.18575-100000@weyl.math.psu.edu>
NNTP-Posting-Host: mozart.cs.berkeley.edu
X-Trace: abraham.cs.berkeley.edu 1034934391 1521 128.32.153.211 (18 Oct 2002 09:46:31 GMT)
X-Complaints-To: news@abraham.cs.berkeley.edu
NNTP-Posting-Date: 18 Oct 2002 09:46:31 GMT
X-Newsreader: trn 4.0-test74 (May 26, 2000)
Originator: daw@mozart.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[this is a re-post here of something I earlier sent to the LSM mailing list]

Alexander Viro  wrote:
>As for "highly secure"...  Could we please
>see some proof?  Clearly stated properties with code audit to verify them
>would be nice.

There has been some work done on automated analysis of the LSM hooks
to verify that hooks are placed everywhere they are needed, and LSM
benefitted from this.  See, e.g.,
http://www.usenix.org/publications/library/proceedings/sec02/zhang.html

>I'm yet to see a single shred of evidence that so-called security improvements
>actually do improve security (as opposed to feeling of security - quite
>a different animal).

Adding LSM support to the kernel does not itself improve security.
However, LSM support enables modules to add security.  And yes, there
are some substantial security wins available here.

Are you familiar with privilege separation in SSH?  One of the promises
of LSM is that it provides a way that we could systematically apply
privilege separation to many (or all) of our security-critical apps.
Existing mechanisms in the OS are too coarse-grained to be adequate for
privilege separation; LSM gives us a way to change all that.  This would
be a big improvement in security.

I've never been shy of criticizing feel-good solutions.  LSM is not a
feel-good solution; it's a real step forward.

This really is real stuff.  This is not snake oil.  Honest.
