Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278042AbRKVMdL>; Thu, 22 Nov 2001 07:33:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278428AbRKVMdB>; Thu, 22 Nov 2001 07:33:01 -0500
Received: from pat.uio.no ([129.240.130.16]:44474 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S278042AbRKVMcv>;
	Thu, 22 Nov 2001 07:32:51 -0500
To: Samuel Maftoul <maftoul@esrf.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NFS problem
In-Reply-To: <20011122095251.A18254@pcmaftoul.esrf.fr>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 22 Nov 2001 13:32:45 +0100
In-Reply-To: <20011122095251.A18254@pcmaftoul.esrf.fr>
Message-ID: <shsd72bgf4i.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Samuel Maftoul <maftoul@esrf.fr> writes:

     > I thought that NFS's underlying FS do not have any effect on
     > NFS performances, and that the client is not aware of the
     > ("local") remote FS. Am I wrong ? Does anybody have an idea to
     > fix the problem ?
 
Why do you think that something on the client is 'aware' of the remote
fs?

My guess is that you need to redo your test using a TCP mount for the
Linux machine (that's what your Solaris client is doing). My guess is
that you are hitting a UDP transport reliability problem in the
DirectIO case...

     > Is it a bug in NFS's implementation of linux kernel ?

No.

Cheers,
   Trond
