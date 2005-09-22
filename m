Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750705AbVIVTDe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750705AbVIVTDe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 15:03:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750751AbVIVTDe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 15:03:34 -0400
Received: from zctfs063.nortelnetworks.com ([47.164.128.120]:59621 "EHLO
	zctfs063.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S1750705AbVIVTDe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 15:03:34 -0400
Message-ID: <4332FFF5.5060207@nortel.com>
Date: Thu, 22 Sep 2005 13:03:17 -0600
From: "Christopher Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: dipankar@in.ibm.com
CC: Al Viro <viro@ftp.linux.org.uk>, Roland Dreier <rolandd@cisco.com>,
       Sonny Rao <sonny@burdell.org>, linux-kernel@vger.kernel.org,
       "Theodore Ts'o" <tytso@mit.edu>, bharata@in.ibm.com,
       trond.myklebust@fys.uio.no
Subject: Re: dentry_cache using up all my zone normal memory -- also seen
 on 2.6.14-rc2
References: <4331B89B.3080107@nortel.com> <20050921200758.GA25362@kevlar.burdell.org> <4331C9B2.5070801@nortel.com> <20050921210019.GF4569@in.ibm.com> <4331CFAD.6020805@nortel.com> <52ll1qkrii.fsf@cisco.com> <20050922031136.GE7992@ftp.linux.org.uk> <43322AE6.1080408@nortel.com> <20050922041733.GF7992@ftp.linux.org.uk> <4332CAEA.1010509@nortel.com> <20050922182719.GA4729@in.ibm.com>
In-Reply-To: <20050922182719.GA4729@in.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Sep 2005 19:03:26.0180 (UTC) FILETIME=[4FA8CA40:01C5BFA8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dipankar Sarma wrote:

> This can happen if a task runs for too long inside the kernel
> holding up context switches or usermode code running on that
> cpu. The fact that RCU grace period eventually happens
> and the dentries are freed means that something intermittently
> holds up RCU. Is this 2.6.10 vanilla or does it have other
> patches in there ?

The 2.6.10 was modified.  All the results with the dcache debugging 
patch applied were from vanilla 2.6.14-rc2.

It's perfectly repeatable as well...every single time I run "rename14" 
the OOM killer kicks in.

Chris
