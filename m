Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262924AbSKTW7c>; Wed, 20 Nov 2002 17:59:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263188AbSKTW7c>; Wed, 20 Nov 2002 17:59:32 -0500
Received: from mons.uio.no ([129.240.130.14]:48789 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S262924AbSKTW7b>;
	Wed, 20 Nov 2002 17:59:31 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15836.5498.109808.440533@charged.uio.no>
Date: Thu, 21 Nov 2002 00:06:34 +0100
To: Juan Gomez <juang@us.ibm.com>
Cc: Mike Kupfer <kupfer@athyra.eng.sun.com>, linux-kernel@vger.kernel.org,
       nfs@lists.sourceforge.net
Subject: Re: [NFS] Re: Non-blocking lock requests during the grace period ===> unlock
 during grace period?
In-Reply-To: <OF20A29A8A.9BDEB891-ON87256C77.006712BE@us.ibm.com>
References: <OF20A29A8A.9BDEB891-ON87256C77.006712BE@us.ibm.com>
X-Mailer: VM 7.00 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Juan Gomez <juang@us.ibm.com> writes:

     > OK, fair enough. I think I will withdraw my request to 'fix'
     > this. If Solaris and other falvors of Unix (i.e. Aix) behave
     > this way I think it would not be good to change just Linux.
     > The other minor change I proposed earlier was that we allow
     > unlock operations during the grace period, and this will be
     > useful in clustered NAS heads.  What do you guys think about
     > such a change?

Until the server knows that the client has finished re-establishing
all state information, it should not accept any requests to modify
that state. Unfortunately, the only way it has of knowing that the
client is done is the grace period expiration...

Cheers,
  Trond
