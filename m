Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267537AbRGSLg5>; Thu, 19 Jul 2001 07:36:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267539AbRGSLgr>; Thu, 19 Jul 2001 07:36:47 -0400
Received: from mons.uio.no ([129.240.130.14]:10985 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S267537AbRGSLgf>;
	Thu, 19 Jul 2001 07:36:35 -0400
To: Chris Mason <mason@suse.com>
Cc: Hans Reiser <reiser@namesys.com>, Andi Kleen <ak@suse.de>,
        Craig Soules <soules@happyplace.pdl.cmu.edu>,
        linux-kernel@vger.kernel.org
Subject: Re: NFS Client patch
In-Reply-To: <177360000.995464676@tiny>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 19 Jul 2001 13:35:51 +0200
In-Reply-To: Chris Mason's message of "Wed, 18 Jul 2001 09:57:56 -0400"
Message-ID: <shsg0btnobs.fsf@charged.uio.no>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

>>>>> " " == Chris Mason <mason@suse.com> writes:

     > Well, returning the last filename won't do much for filesystems
     > that don't have any directory indexes, but that's besides the
     > point.  Could nfsv4 be better than it is?  probably.  Can we
     > change older NFS protocols to have a linux specific hack that
     > makes them more filesystem (or at least reiserfs) friendly?
     > probably.

NFSv2 and v3 have a fixed format for readdir calls. There's bugger all
you can do to change this without making the resulting protocol
incompatible with NFS.

If you don't want Reiserfs to be NFS compatible, then fine, but I
personally don't want to see hacks to the NFS v2/v3 code that rely on
'hidden knowledge' of the filesystem on the server.

Cheers,
  Trond
