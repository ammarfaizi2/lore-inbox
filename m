Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317668AbSGZJor>; Fri, 26 Jul 2002 05:44:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317670AbSGZJor>; Fri, 26 Jul 2002 05:44:47 -0400
Received: from angband.namesys.com ([212.16.7.85]:45188 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S317668AbSGZJom>; Fri, 26 Jul 2002 05:44:42 -0400
Date: Fri, 26 Jul 2002 13:47:53 +0400
From: Oleg Drokin <green@namesys.com>
To: David Luyer <david@luyer.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux-2.4.18-rc3-ac3: bug with using whole disks as filesystems
Message-ID: <20020726134753.A18943@namesys.com>
References: <004a01c233ba$1a764f50$638317d2@pacific.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <004a01c233ba$1a764f50$638317d2@pacific.net.au>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Thu, Jul 25, 2002 at 07:03:11PM +1000, David Luyer wrote:

> > Original commands to cause failure:
> >   mkfs -b 8192 /dev/sdb -f
> >   mount /dev/sdb /cache
> Actually looks like the -b 8192 was the problem, the same happened
> on /dev/sdb1.  Had to reboot again after that as mount was hanging
> in the same way as cfdisk had previously.  Similar 'kernel BUG'
> message resulted.

Linux kernel 2.4 reiserfs implementation lacks support for blocksizes
different from 4096 bytes, we plan to merge it in after 2.4.19 is out.
It have all the checks needed not to allow you to mount such volumes with
too big blocksizes.

Bye,
    Oleg
