Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261700AbRFAWUa>; Fri, 1 Jun 2001 18:20:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261763AbRFAWUU>; Fri, 1 Jun 2001 18:20:20 -0400
Received: from pat.uio.no ([129.240.130.16]:24253 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S261700AbRFAWUK>;
	Fri, 1 Jun 2001 18:20:10 -0400
To: Chris Mason <mason@suse.com>
Cc: linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
Subject: Re: [NFS] Re: [RFC] yet another knfsd-reiserfs patch
In-Reply-To: <134680000.991430407@tiny>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 02 Jun 2001 00:19:59 +0200
In-Reply-To: Chris Mason's message of "Fri, 01 Jun 2001 17:20:07 -0400"
Message-ID: <shssnhj267k.fsf@charged.uio.no>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Chris,

Do you really need the parent inode in the filehandle?

That screws rename up pretty badly, since the filehandle changes when
you rename into a different directory. It means for instance that when
I do

open(foo)
mv foo bar/
write (foo)
close(foo)

then I have a pretty good chance of getting an ESTALE on the write()
statement.

Cheers,
  Trond
