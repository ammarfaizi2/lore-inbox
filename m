Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277946AbRJRSgV>; Thu, 18 Oct 2001 14:36:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277951AbRJRSgL>; Thu, 18 Oct 2001 14:36:11 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:55048 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S277949AbRJRSf4>; Thu, 18 Oct 2001 14:35:56 -0400
Message-ID: <3BCF207F.DF01BBB8@zip.com.au>
Date: Thu, 18 Oct 2001 11:33:36 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.12-ac3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "DICKENS,CARY (HP-Loveland,ex2)" <cary_dickens2@hp.com>
CC: "Kernel Mailing List (E-mail)" <linux-kernel@vger.kernel.org>,
        "HABBINGA,ERIK (HP-Loveland,ex1)" <erik_habbinga@hp.com>
Subject: Re: Kernel performance in reference to 2.4.5pre1
In-Reply-To: <C5C45572D968D411A1B500D0B74FF4A80418D57B@xfc01.fc.hp.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"DICKENS,CARY (HP-Loveland,ex2)" wrote:
> 
> 2.4.5pre1 is the base for comparison,
> 
> [ figures showing that more recent kernels suck ]
> 

SFS is a rather specialised workload, and synchronous NFS exports
are not a thing which gets a lot of attention.  It could be one
small, hitherto unnoticed change which caused this performance
regression.  And it appears that the change occurred between 2.4.5
and 2.4.7.

We don't know whether this slowdown is caused by changes in the VM,
the filesystem, the block device layer, nfsd or networking. For example,
ksoftirqd was introduced between 2.4.5 and 2.4.7.  Could it be that?

For all these reasons it would be really helpful if you could
go back and test the 2.4.6-preX and 2.4.7-preX kernels (binary search)
and tell us if there was a particular release which caused this decrease in
throughput.

If it can be pinned down to a particular patch then there's a good
chance that it can be fixed.
