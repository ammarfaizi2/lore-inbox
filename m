Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261759AbUBYSsr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 13:48:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261535AbUBYSqq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 13:46:46 -0500
Received: from soul.math.tau.ac.il ([132.67.192.131]:18381 "EHLO tau.ac.il")
	by vger.kernel.org with ESMTP id S261537AbUBYSqA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 13:46:00 -0500
Date: Wed, 25 Feb 2004 20:45:29 +0200 (IST)
From: Hayim Shaul <hayim@post.tau.ac.il>
X-X-Sender: hayim@soul.math.tau.ac.il
To: Suparna Bhattacharya <suparna@in.ibm.com>
cc: akpm@osdl.org, <linux-aio@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: Latest AIO patchset
In-Reply-To: <20040224160341.GA11739@in.ibm.com>
Message-ID: <Pine.LNX.4.44.0402252026460.12841-100000@soul.math.tau.ac.il>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Some basic results are up comparing streaming non-cached random 
> AIO read/write throughputs for a single ext3 file using aio-stress 
> for various io sizes with and without these patches, and also 
> comparsions with O_DIRECT AIO throughputs. The short summary has
> been a doubling of throughput using the fsaio patches, which is
> also close to the results seen with O_DIRECT AIO.
> 
> As usual feedback, bug fixes, test results etc are welcome.
> 

What exactly is the O_DIRECT flag? When I add this flag to the open func
it fails.

More specificaly, this function fails
  open("filename", O_RDWR | O_DIRECT | O_LARGEFILE | O_CREAT, S_IRWXU);   

but this one succeeds
  open("filename", O_RDWR | O_LARGEFILE | O_CREAT, S_IRWXU);   

I'm running linux 2.6.0 with libaio 0.3.92.

   Hayim.

