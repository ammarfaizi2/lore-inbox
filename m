Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030195AbWIAQfI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030195AbWIAQfI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 12:35:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030197AbWIAQfI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 12:35:08 -0400
Received: from mx1.redhat.com ([66.187.233.31]:56540 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030196AbWIAQfG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 12:35:06 -0400
Message-ID: <44F8612C.10101@redhat.com>
Date: Fri, 01 Sep 2006 12:34:52 -0400
From: Peter Staubach <staubach@redhat.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060801)
MIME-Version: 1.0
To: Chuck Lever <chucklever@gmail.com>
CC: Olaf Kirch <okir@suse.de>, NeilBrown <neilb@suse.de>,
       Andrew Morton <akpm@osdl.org>, nfs@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [NFS] [PATCH 019 of 19] knfsd: Register all RPC programs with
 portmapper by default
References: <20060901141639.27206.patches@notabene>	<1060901043948.27677@suse.de>	<76bd70e30609010831m9e80cfav514d60718d35e7d5@mail.gmail.com>	<20060901155407.GC29574@suse.de> <76bd70e30609010908n47eb356ob121109961f8221c@mail.gmail.com>
In-Reply-To: <76bd70e30609010908n47eb356ob121109961f8221c@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck Lever wrote:
> On 9/1/06, Olaf Kirch <okir@suse.de> wrote:
>   
>> On Fri, Sep 01, 2006 at 11:31:25AM -0400, Chuck Lever wrote:
>>     
>>> I don't like this.  The idea that multiple RPC services are listening
>>> on the same port is a total hack.  What other service might use this
>>> besides NFSACL?
>>>       
>> Why do you consider this a hack? I have always felt that librpc requiring
>> you to open separate ports for every program you register was a poor
>> design. The RPC header contains the program number, and the RPC code
>> is fully capable of demuxing incoming requests. So I do not think it is
>> a hack at all.
>>
>> And yes, Solaris NFSACL resides on 2049 too.
>>     
>
> I meant "Does Solaris advertise NFSACL on 2049 via the portmapper?"

Yes, the Solaris server registers the NFS_ACL service with the rpcbind
daemon.  And, the NFS_ACL protocol is defined to use port 2049.  Please
see nfs_acl.x (/usr/include/rpcsvc/nfs_acl.x) for details.

       ps
