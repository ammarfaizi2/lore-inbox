Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263338AbTDGIr2 (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 04:47:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263341AbTDGIr2 (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 04:47:28 -0400
Received: from 205-158-62-136.outblaze.com ([205.158.62.136]:11476 "HELO
	fs5-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id S263338AbTDGIr1 (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 04:47:27 -0400
Subject: Re: 2.5: NFS troubles
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Andrew Morton <akpm@digeo.com>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20030406171855.6bd3552d.akpm@digeo.com>
References: <1049630768.592.24.camel@teapot.felipe-alfaro.com>
	 <shsbrzjn5of.fsf@charged.uio.no>  <20030406171855.6bd3552d.akpm@digeo.com>
Content-Type: text/plain
Organization: 
Message-Id: <1049705933.592.2.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 (1.2.3-1) 
Date: 07 Apr 2003 10:58:53 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-04-07 at 02:18, Andrew Morton wrote:
> Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
> > The 2.5.66 ext3 code still has some issues with respect to NFS readdir
> > cookies.
> 
> It might do.  I have Ted's htree/NFS fixes in there though.
> 
> Felipe, please do 
> 
> 	dumpe2fs /dev/hdXX | grep features
> 
> if it shows dir_index then it might be an ext3 problem.  If not then it is
> probably an NFS problem.
> 
> If it does have dir_index set then please run
> 
> 	tune2fs -O ^dir_index /dev/hdXX
> 
> and reboot and retest.

Wonderful, Andrew... You were right. Disabling H/Tree indexes solved the
problem! Anything else?

PS: I previously solved the problem by mounting the filesystem as ext2
instead, but now it seems to be working pretty well with ext3 (at least,
I can't reproduce the hang I described in my previous message).

Thanks!

________________________________________________________________________
Linux Registered User #287198

