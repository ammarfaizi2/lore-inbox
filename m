Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262648AbRE3ILD>; Wed, 30 May 2001 04:11:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262649AbRE3IKx>; Wed, 30 May 2001 04:10:53 -0400
Received: from mons.uio.no ([129.240.130.14]:30105 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S262648AbRE3IKo>;
	Wed, 30 May 2001 04:10:44 -0400
MIME-Version: 1.0
Message-ID: <15124.43767.470515.182286@charged.uio.no>
Date: Wed, 30 May 2001 10:10:31 +0200
To: Alexander Viro <viro@math.psu.edu>
Cc: Gergely Tamas <dice@mfa.kfki.hu>, linux-kernel@vger.kernel.org
Subject: Re: OOPS with 2.4.5 [kernel BUG at inode.c:486]
In-Reply-To: <Pine.GSO.4.21.0105300328230.12645-100000@weyl.math.psu.edu>
In-Reply-To: <shssnhn47tl.fsf@charged.uio.no>
	<Pine.GSO.4.21.0105300328230.12645-100000@weyl.math.psu.edu>
X-Mailer: VM 6.89 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
User-Agent: SEMI/1.13.7 (Awazu) CLIME/1.13.6 (=?ISO-2022-JP?B?GyRCQ2YbKEI=?=
 =?ISO-2022-JP?B?GyRCJU4+MRsoQg==?=) MULE XEmacs/21.1 (patch 14) (Cuyahoga
 Valley) (i386-redhat-linux)
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Alexander Viro <viro@math.psu.edu> writes:

     > On 30 May 2001, Trond Myklebust wrote:

    >> Al: Is there any reason why the cases
    >>
    >> if (!inode->i_nlink)
    >>
    >> and the 'magic nfs path' should be treated differently? 
    >> Personally, I'd rather prefer to merge the 2.

     > I don't think that it's a good idea. Why not fry the cache
     > explicitly when you invalidate the inode?

Won't there be a race there? Imagine if some other process is busy
writing to that inode, and happens to add a new page after we've
truncated...

Cheers,
   Trond
