Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271747AbRIGLtz>; Fri, 7 Sep 2001 07:49:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271744AbRIGLtp>; Fri, 7 Sep 2001 07:49:45 -0400
Received: from mons.uio.no ([129.240.130.14]:58074 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S271745AbRIGLti>;
	Fri, 7 Sep 2001 07:49:38 -0400
To: "Mike Black" <mblack@csihq.com>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.8 NFS Problems
In-Reply-To: <024f01c13601$c763d3c0$e1de11cc@csihq.com>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 07 Sep 2001 13:49:50 +0200
In-Reply-To: "Mike Black"'s message of "Wed, 5 Sep 2001 07:56:20 -0400"
Message-ID: <shsae07md9d.fsf@charged.uio.no>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Mike Black <mblack@csihq.com> writes:

     > I've been getting random NFS EIO errors for a few months but
     > now it's repeatable.  Trying to copy a large file from one
     > 2.4.8 SMP box to another is consistently failing (at different
     > offsets each time).  This doesn't appear to be a network
     > problem as the last comm between the machines looks OK.  By the
     > timestamps it appears that a read() is taking too long and
     > causing a timeout?

Morale: Don't use soft mounts: they are prone to these things. If you
insist on using them, then try playing around with the `timeo' and
`retrans' mount variables.

Soft mount timeouts are not only due to network problems, but can
equally well be due to internal congestion. The rate at which the
network can transmit requests is usually (unless you are using
Gigabit) way below the rate at which your machine can generate them.

Cheers,
   Trond
