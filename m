Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288135AbSAHPlC>; Tue, 8 Jan 2002 10:41:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288130AbSAHPky>; Tue, 8 Jan 2002 10:40:54 -0500
Received: from mons.uio.no ([129.240.130.14]:24766 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S288141AbSAHPkq>;
	Tue, 8 Jan 2002 10:40:46 -0500
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org, Shirish Kalele <kalele@veritas.com>,
        NFS maillist <nfs@lists.sourceforge.net>
Subject: Re: knfsd over TCP (was RE: 2.4.18pre2aa1)
In-Reply-To: <20020108155553.A1894@inspiron.school.suse.de>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 08 Jan 2002 16:40:33 +0100
In-Reply-To: <20020108155553.A1894@inspiron.school.suse.de>
Message-ID: <shs7kqsu9zi.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Andrea Arcangeli <andrea@suse.de> writes:


     > 	NFS updates from Trond Myklebust. BTW, the svc tcp patches are
     > 	broken, they oopsed on me with a simple mount of nfs via udp,
     > 	so I left them out. this is the oops for the record:

Duh...

sunrpc still hasn't been updated to use module_init(), so
initialization of the new buffer slab was only working when you used
the thing as a module. Sorry for not having spotted that one.

I've put out a fixed copy of the knfsd over TCP patch (and the NFS_ALL
patch).

Cheers,
  Trond
