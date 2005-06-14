Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261170AbVFNFsa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261170AbVFNFsa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 01:48:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261231AbVFNFsa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 01:48:30 -0400
Received: from web33314.mail.mud.yahoo.com ([68.142.206.129]:7549 "HELO
	web33314.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S261170AbVFNFsV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 01:48:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=FEyDpTicvnTAdHox78m8WF8KICQmBXI8yYgHQvJ96QmyXM1HBYH1NZDyx2kMKUeaM6epLlHO5Zh60lMByAO+Mxc+2n24+vWbqeMcW51Dtq70jravLCvYY2asZkWMepvHlNLK4SsTtg6TF9VOzj2mQGGDVXqjw53LbBJefkPjqwM=  ;
Message-ID: <20050614054813.63362.qmail@web33314.mail.mud.yahoo.com>
Date: Mon, 13 Jun 2005 22:48:13 -0700 (PDT)
From: li nux <lnxluv@yahoo.com>
Subject: Re: rmap.c: try_to_unmap_file(): VM_LOCKED not respected
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux <linux-kernel@vger.kernel.org>
In-Reply-To: <20050614052219.GH3879@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I first use mmap(MAP_LOCKED) and then
remap_file_pages.
This should set VM_LOCKED in the vma.

-li

--- William Lee Irwin III <wli@holomorphy.com> wrote:

> On Mon, Jun 13, 2005 at 10:14:05PM -0700, li nux
> wrote:
> > My application is using remap_file_pages and
> mlocks
> > those pages.
> > So in the code of  try_to_unmap_file (see below),
> > I should never reach the call to
> try_to_unmap_cluster,
> > because for those pages VM_LOCKED is always set.
> > But, under heavy load I am seeing
> try_to_unmap_cluster
> > is getting called. Stack:
> 
> Does your app use remap_file_pages() before mlock()?
> 
> If so, the VM may be trying to reclaim pages between
> the call to
> remap_file_pages() and the call to mlock().
> 
> 
> -- wli
> -
> To unsubscribe from this list: send the line
> "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at 
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 



		
__________________________________ 
Discover Yahoo! 
Have fun online with music videos, cool games, IM and more. Check it out! 
http://discover.yahoo.com/online.html
