Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261518AbTIOQWq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 12:22:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261543AbTIOQWq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 12:22:46 -0400
Received: from sat.sws.net.au ([202.5.161.49]:51852 "EHLO sat.sws.net.au")
	by vger.kernel.org with ESMTP id S261518AbTIOQVz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 12:21:55 -0400
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: Oops on 2.4.22 when mounting from broken NFS server
Date: Tue, 16 Sep 2003 02:21:34 +1000
User-Agent: KMail/1.5.3
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
References: <200309131938.40177.russell@coker.com.au> <200309152247.20462.russell@coker.com.au> <shs3ceyjc4k.fsf@charged.uio.no>
In-Reply-To: <shs3ceyjc4k.fsf@charged.uio.no>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309160221.34621.russell@coker.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Sep 2003 01:38, Trond Myklebust wrote:
> Without a tcpdump, there's no way to know why this dumped. In what way
> was the NFS server broken, and exactly how do you expect the Linux NFS
> client to protect you against it?

The NFS server was unable to read the directories it was exporting, so it 
would allow the mount command but then fail to do anything.

I expect the NFS client to behave sensibly in the face of all possible server 
errors, including the possibility of a hostile NFS server.

> BTW: that Oops you posted looked very much like a memory corruption
> problem. Were you running vanilla 2.4.22 on the client, or was it too
> patched?

It was also patched.  I will try and reproduce the error with an unpatched 
kernel and a tcpdump running.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

