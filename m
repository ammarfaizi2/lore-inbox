Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263071AbVDLX3G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263071AbVDLX3G (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 19:29:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263072AbVDLX0v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 19:26:51 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:46984 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S263030AbVDLXKb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 19:10:31 -0400
Subject: Re: NFS2 question, help, pls!
From: Lee Revell <rlrevell@joe-job.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Xin Zhao <uszhaoxin@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1113344795.10420.125.camel@lade.trondhjem.org>
References: <4ae3c1405041212223ee0609e@mail.gmail.com>
	 <1113344795.10420.125.camel@lade.trondhjem.org>
Content-Type: text/plain
Date: Tue, 12 Apr 2005 19:10:21 -0400
Message-Id: <1113347421.13102.6.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-04-12 at 15:26 -0700, Trond Myklebust wrote:
> ty den 12.04.2005 Klokka 15:22 (-0400) skreiv Xin Zhao:
> > I have very very fast network and is testing NFS2 over this kind of
> > network. I noticed that for standard work like read/write a large
> > file,  compile kernels, the performance of NFS2 is good. But if I try
> > to decompress kernel tar file. The standard ext2 takes 28s while NFS2
> > takes 81s. Also, if I remove the kernel source code tree, ext2 takes
> > 19s but NFS2 takes 44s.
> > 
> > Why?  (You can assume that network is very fast. )  Is there any
> > improvements in NFS3/4 on this issue? If so, how?
> 
> NFSv2 requires the server to immediately write all data to disk before
> it can reply to the RPC write request (synchronous writes).

This behavior can be disabled with the "async" export option for NFSv2.

Lee

