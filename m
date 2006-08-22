Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932139AbWHVIts@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932139AbWHVIts (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 04:49:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932141AbWHVItr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 04:49:47 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:28328 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S932139AbWHVItr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 04:49:47 -0400
Message-ID: <44EAC5CA.8020605@sw.ru>
Date: Tue, 22 Aug 2006 12:52:26 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Paul Jackson <pj@sgi.com>
CC: riel@redhat.com, Linux@sc8-sf-spam2-b.sourceforge.net,
       ckrm-tech@lists.sourceforge.net, haveblue@us.ibm.com,
       linux-kernel@vger.kernel.org, ak@suse.de, hch@infradead.org, saw@sw.ru,
       alan@lxorguk.ukuu.org.uk, rohitseth@google.com, hugh@veritas.com,
       Christoph@sc8-sf-spam2-b.sourceforge.net, mingo@elte.hu,
       devel@openvz.org, xemul@openvz.org
Subject: Re: [ckrm-tech] [PATCH 4/7] UBC: syscalls (user interface)
References: <44E33893.6020700@sw.ru> <44E33C3F.3010509@sw.ru>	<1155752277.22595.70.camel@galaxy.corp.google.com>	<1155755069.24077.392.camel@localhost.localdomain>	<1155756170.22595.109.camel@galaxy.corp.google.com>	<44E45D6A.8000003@sw.ru> <20060817084033.f199d4c7.akpm@osdl.org>	<20060818120809.B11407@castle.nmd.msu.ru>	<1155912348.9274.83.camel@localhost.localdomain>	<20060818094248.cdca152d.akpm@osdl.org> <44E9B69D.9060109@sw.ru> <20060821105106.6688c92c.pj@sgi.com>
In-Reply-To: <20060821105106.6688c92c.pj@sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson wrote:
>>this doesn't allow memory overcommitment, does it?
> 
> 
> Uh - no - I don't think so.  You can over commit
> the memory of a task in a small cpuset just as well
> as you can a task in a big cpuset or even one in the
> top cpuset covering the entire system.
> 
> Perhaps I didn't understand your point.
My point was that when you have lots of containers
their summary memory limit can be much higher then available RAM.
This allows bursts of memory usage for containers, since
it is very unlikely for all of them to consume the memory
simulatenously. E.g. hosters usually oversell memory
say 2 times on the node.

So the question was whether it is possbile to overcommit memory
with NUMA emulation?

Thanks,
Kirill

