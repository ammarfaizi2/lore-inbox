Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288736AbSANScW>; Mon, 14 Jan 2002 13:32:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288776AbSANScM>; Mon, 14 Jan 2002 13:32:12 -0500
Received: from pat.uio.no ([129.240.130.16]:6299 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S288736AbSANScF>;
	Mon, 14 Jan 2002 13:32:05 -0500
To: Stephan Eisvogel <eisvogel-lkml@hawo.stw.uni-erlangen.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.18pre3+patches stalls machine under heavy NFS load
In-Reply-To: <2144085514.20020114164200@hawo.stw.uni-erlangen.de>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 14 Jan 2002 19:28:10 +0100
In-Reply-To: <2144085514.20020114164200@hawo.stw.uni-erlangen.de>
Message-ID: <shsr8osiy85.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Stephan Eisvogel <eisvogel-lkml@hawo.stw.uni-erlangen.de> writes:

     > Hello, first post.

     > Summary: Experiencing machine stalls with 2.4.18pre3 with huge
     > cache when bonnie is working on mounted NFS over Fast Ethernet.

Yes.  I didn't realize that sync_page() gets called with
TASK_UNINTERRUPTIBLE set. When I added in a preemption point in
__rpc_execute() it was causing the hang.

Fixed now...

Cheers,
   Trond
