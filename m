Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314272AbSDRIx6>; Thu, 18 Apr 2002 04:53:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314273AbSDRIx5>; Thu, 18 Apr 2002 04:53:57 -0400
Received: from pat.uio.no ([129.240.130.16]:12737 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S314272AbSDRIx4>;
	Thu, 18 Apr 2002 04:53:56 -0400
To: Hirokazu Takahashi <taka@valinux.co.jp>
Cc: jakob@unthought.net, davem@redhat.com, ak@suse.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] zerocopy NFS updated
In-Reply-To: <20020414.212308.33849971.davem@redhat.com>
	<20020416.100302.129343787.taka@valinux.co.jp>
	<20020416034120.R18116@unthought.net>
	<20020418.140155.85418444.taka@valinux.co.jp>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 18 Apr 2002 10:53:31 +0200
Message-ID: <shspu0x2xro.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Hirokazu Takahashi <taka@valinux.co.jp> writes:

     > Hi, I've been thinking about your comment, and I realized it
     > was a good suggestion.  There are no problem with the zerocopy
     > NFS, but If you want to use UDP sendfile for streaming or
     > something like that, you wouldn't get good performance.

Surely one can work around this in userland without inventing a load
of ad-hoc schemes in the kernel socket layer?

If one doesn't want to create a pool of sockets in order to service
the different threads, one can use generic methods such as
sys_readahead() in order to ensure that the relevant data gets paged
in prior to hogging the socket.

There is no difference between UDP and TCP sendfile() in this respect.

Cheers,
  Trond
