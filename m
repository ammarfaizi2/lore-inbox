Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264536AbTIDClq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 22:41:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264512AbTIDClp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 22:41:45 -0400
Received: from mail3-126.ewetel.de ([212.6.122.126]:20182 "EHLO
	mail3.ewetel.de") by vger.kernel.org with ESMTP id S264536AbTIDCkZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 22:40:25 -0400
Date: Thu, 4 Sep 2003 04:40:22 +0200 (CEST)
From: Pascal Schmidt <der.eremit@email.de>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
cc: linux-kernel@vger.kernel.org
Subject: Re: [NFS] attempt to use V1 mount protocol on V3 server
In-Reply-To: <16214.41175.580602.671154@charged.uio.no>
Message-ID: <Pine.LNX.4.44.0309040433540.8732-100000@neptune.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Sep 2003, Trond Myklebust wrote:

> It's being handed a bogus filehandle by the userland mount command
> (which gets it from mountd). When it sends the initial NFSv3 GETATTR
> call to the nfsd, and gets rejected, it just retries the same GETATTR
> call as an NFSv2 call.

Out of interest, how does this work? Not obvious to me since an NFSv3
filehandle is too big for an NFSv2 server.

> I'll check what's happening. AFAICS, the NFS layer should not really
> care, but it will pass some funny values back to the VFS, and this
> might be screwing something up...

Sounds likely, since basically the whole machine locked up and no
futher fs operations seemed to be happening. I haven't checked whether
2.4 also shows the problem - I just fixed it in my code and then it
obviously did not happen anymore.

I can test patches or also send you my code if you want to test
things yourself. It's also available online, UNFS3 project at
SourceForge, but that's of course a version with working FSSTAT.

-- 
Ciao,
Pascal

