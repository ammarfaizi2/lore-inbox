Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288953AbSBMV1N>; Wed, 13 Feb 2002 16:27:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288955AbSBMV0y>; Wed, 13 Feb 2002 16:26:54 -0500
Received: from pat.uio.no ([129.240.130.16]:16292 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S288953AbSBMV0r>;
	Wed, 13 Feb 2002 16:26:47 -0500
To: Craig Christophel <merlin@transgeek.com>
Cc: linux-kernel@vger.kernel.org, Keith Owens <kaos@ocs.com.au>
Subject: Re: [PATCH] -- filesystems.c::sys_nfsservctl
In-Reply-To: <20020213205144Z282414-24962+32@thor.valueweb.net>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 13 Feb 2002 22:26:35 +0100
In-Reply-To: <20020213205144Z282414-24962+32@thor.valueweb.net>
Message-ID: <shsd6z9dqes.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Craig Christophel <merlin@transgeek.com> writes:

     > Ok guys get ready to flame me....
     > 	The attached patch removes the lock/unlock in this function.
     > 	Now I am 80%
     > sure of this one, but would like a word from the kmod
     > maintainer about whether request_module needs the BKL or not.
     > do_nfsservctl already takes the BKL inside the function so as
     > long as request_module is safe this pair can be removed --
     > effectively making do_nfsservctl responsible for it's own
     > locking scheme.

What would remain to protect 'nfsd_linkage' if you removed the BKL?

Cheers,
  Trond
