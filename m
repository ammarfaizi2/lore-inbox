Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267442AbUHSVwH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267442AbUHSVwH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 17:52:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267445AbUHSVwG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 17:52:06 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:4026 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S267442AbUHSVvl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 17:51:41 -0400
Date: Thu, 19 Aug 2004 14:51:10 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: umount -f /nfsmount hangs
Message-ID: <268300000.1092952270@flay>
In-Reply-To: <1092950791.3810.85.camel@lade.trondhjem.org>
References: <261360000.1092948919@flay> <1092950791.3810.85.camel@lade.trondhjem.org>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Thursday, August 19, 2004 17:26:31 -0400 Trond Myklebust <trond.myklebust@fys.uio.no> wrote:

> På to , 19/08/2004 klokka 16:55, skreiv Martin J. Bligh:
>> NFS server has gone away, was mounted soft, intr:
>> 
>> bvrgsa.ibm.com:/gsa/bvrgsa on /bvrgsa type nfs (rw,soft,intr,nfsvers=2,tcp,rsize=8192,wsize=8192,timeo=30,addr=9.47.56.70)
>> 
>> but umount -f just hangs ... surely that's not the intended behaviour?
>> from Alt+SysRq+t:
> 
> Works fine for me with 2.6.8.1 and the Fedora Core2 2.6.7-based kernel.
> If you physically turn off the server as opposed to just killing the
> nfsd processes, then it takes a bit longer than for the networking layer
> to time out the sock_release etc (isn't that under the control of the
> tcp_fin_timeout sysctl?), but AFAICS it does eventually get there.
> 
> Are there any other details you're omitting?

Yeah, it did time out eventually and yes, the network got disconnected
rather than killing nfsd. I guess I was expecting -f to mean "Do it. Now" ...
However, the damned thing is still mounted as listed by "mount".

Viro pointed me to -l as well ... -f -l seems to work OK.

M.

