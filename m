Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267422AbUHSV0g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267422AbUHSV0g (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 17:26:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267423AbUHSV0g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 17:26:36 -0400
Received: from dh138.citi.umich.edu ([141.211.133.138]:60608 "EHLO
	lade.trondhjem.org") by vger.kernel.org with ESMTP id S267422AbUHSV0d convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 17:26:33 -0400
Subject: Re: umount -f /nfsmount hangs
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <261360000.1092948919@flay>
References: <261360000.1092948919@flay>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <1092950791.3810.85.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 19 Aug 2004 17:26:31 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På to , 19/08/2004 klokka 16:55, skreiv Martin J. Bligh:
> NFS server has gone away, was mounted soft, intr:
> 
> bvrgsa.ibm.com:/gsa/bvrgsa on /bvrgsa type nfs (rw,soft,intr,nfsvers=2,tcp,rsize=8192,wsize=8192,timeo=30,addr=9.47.56.70)
> 
> but umount -f just hangs ... surely that's not the intended behaviour?
> from Alt+SysRq+t:

Works fine for me with 2.6.8.1 and the Fedora Core2 2.6.7-based kernel.
If you physically turn off the server as opposed to just killing the
nfsd processes, then it takes a bit longer than for the networking layer
to time out the sock_release etc (isn't that under the control of the
tcp_fin_timeout sysctl?), but AFAICS it does eventually get there.

Are there any other details you're omitting?

Cheers,
  Trond
