Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262578AbSI0TGC>; Fri, 27 Sep 2002 15:06:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262581AbSI0TGC>; Fri, 27 Sep 2002 15:06:02 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:54030 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S262578AbSI0TGB>;
	Fri, 27 Sep 2002 15:06:01 -0400
Message-ID: <3D94AD35.4050505@pobox.com>
Date: Fri, 27 Sep 2002 15:10:45 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@sgi.com>
CC: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][5th RESENT] backport 2.5 inode allocation changes
References: <20020927212707.B4733@sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> It allows to break worst-offenders like NFS out of the big inode union
> and make VM balancing better by wasting less ram for inodes.  It also
> speedups filesystems that don't want to touch that union in struct
> inode, like JFS, XFS or FreeVxFS (once switched over).  It is a straight
> backport from Al's code in 2.5 and has proven stable in Red Hat's
> recent beta releases (limbo, null).  Al has ACKed my patch submission.
> 
> Credits go to Daniel Phillips for the initial design.
> 
> NOTE: you want my b_inode removal patch applied before this one.


IMO this patch (and b_inode before it) look ok...

but I have a feeling we will have a public disagreement over actually 
shrinking the size of the inode struct...  [but this patch does not do 
that, so IMO it's fine]

