Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261999AbVEDDuF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261999AbVEDDuF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 23:50:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262002AbVEDDuE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 23:50:04 -0400
Received: from rproxy.gmail.com ([64.233.170.192]:53493 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261997AbVEDDt5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 23:49:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OPBsKHdItuSJKRMzi1JzMPrP+TAXMhpvjURgkiOTrAYSv0nDXnsyCuoRpujSbtbpA1vRmVIHXX6zLdZE+lC7fGyvqgfZH3vs8CVC8HtR0zbPYRgjfP8MDpuZPIyC8SAS49myD7YEUWaredF5g2MtsgEdH9Rk//JmPl+LeL974QM=
Message-ID: <d4757e600505032049716c811b@mail.gmail.com>
Date: Tue, 3 May 2005 23:49:55 -0400
From: Joe <joecool1029@gmail.com>
Reply-To: Joe <joecool1029@gmail.com>
To: 7eggert@gmx.de
Subject: Re: Empty partition nodes not created (was device node issues with recent mm's and udev)
Cc: linux-scsi@vger.kernel.org, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
In-Reply-To: <E1DTAgo-0002uD-F0@be1.7eggert.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <3ZVNP-5cq-7@gated-at.bofh.it>
	 <E1DTAgo-0002uD-F0@be1.7eggert.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/3/05, Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org>
<7eggert@gmx.de> wrote:
> Joe <joecool1029@gmail.com> wrote:
> 
> > Here is the partition table from fdisk, fdisk does run fine.. its just
> > the fact this node is not created that threw me off before.
> >
> >    Device Boot      Start         End      Blocks   Id  System
> > /dev/sdb1   *           1           2       16033+   0  Empty
> > /dev/sdb2   *           6        2431    19486845    b  W95 FAT32
> > /dev/sdb3               3           5       24097+  83  Linux
> >
> > Notice, /dev/sdb1 is a Empty partition... in /dev I only have sdb,
> > sdb2, and sdb3.  No sdb1.  Any help would be appreciated.
> 
> Some vendors depend on empty partitions not showing up. That's why this
> patch was introduced.

It would be interesting to see just how important it is to hide this. 
 
> BTW: Is there a special reason you why choose "empty"?
> Is this partition showing up in other systems at all?

Actually, yes there is.. its a firmware partition that would normally
not be mounted, but in order to dd new firmware versions to it, I
depended on the node... which has ceased to exist.

I would like to see an easier workaround then just ignoring it like
that, but if its really needed....

Anyways, thanks everyone for the info, its much appreciated.

Joe
