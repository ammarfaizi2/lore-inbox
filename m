Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264771AbSK0UfG>; Wed, 27 Nov 2002 15:35:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264779AbSK0UfG>; Wed, 27 Nov 2002 15:35:06 -0500
Received: from pat.uio.no ([129.240.130.16]:38034 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S264771AbSK0UfF>;
	Wed, 27 Nov 2002 15:35:05 -0500
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>,
       Ext2 devel <ext2-devel@lists.sourceforge.net>,
       NFS maillist <nfs@lists.sourceforge.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: htree+NFS (NFS client bug?)
References: <1038354285.1302.144.camel@sherkaner.pao.digeo.com>
	<20021127133318.GA8117@think.thunk.org>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 27 Nov 2002 21:42:14 +0100
In-Reply-To: <20021127133318.GA8117@think.thunk.org>
Message-ID: <shsfztmeod5.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Theodore Ts'o <tytso@mit.edu> writes:

     > Well, even if the NFS server is generating bad cookies (and
     > that may be possible), the NFS client should be more robust and
     > not spin in a loop forever.

No. In this case, the problem appears to be that the cookie issued by
the server for the end of directory case is not unique.

If userland calls an extra 'readdir()' after EOF is reached, then as
far as the client is concerned, this sort of thing cannot be
distinguished from readdir()+seekdir()+readdir()..

Cheers,
  Trond
