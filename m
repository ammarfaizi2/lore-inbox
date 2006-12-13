Return-Path: <linux-kernel-owner+w=401wt.eu-S964867AbWLMMJT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964867AbWLMMJT (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 07:09:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964885AbWLMMJT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 07:09:19 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:57451 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964867AbWLMMJS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 07:09:18 -0500
X-Greylist: delayed 1200 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Dec 2006 07:09:18 EST
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Neil Brown <neilb@suse.de>
Subject: Re: 2.6.19-mm1 (md/raid1 randomly drops partitions - possible sata_uli problem)
Date: Wed, 13 Dec 2006 12:51:19 +0100
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20061211005807.f220b81c.akpm@osdl.org> <200612122155.42213.rjw@sisk.pl> <17791.20220.200213.305946@cse.unsw.edu.au>
In-Reply-To: <17791.20220.200213.305946@cse.unsw.edu.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612131251.20256.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, 13 December 2006 01:53, Neil Brown wrote:
> On Tuesday December 12, rjw@sisk.pl wrote:
> > > 
> > > So when md writes to write out the superblock, to gets EIO... Odd that
> > > you aren't getting errors for normal writes.
> > > 
> > > What devices are the md/raid1 built on?
> > 
> > Sata drives, on sata_uli.
> > 
> > > > 
> > > > I'll try to reproduce it tomorrow and collect some more information.
> > > 
> > > Thanks.  More information is definitely better than less, so send over
> > > anything you can find.
> > 
> > Okay, seems to be readily reproducible, dmesg output from the failing kernel
> > attached.
> 
> Weird.  You are getting silent write errors...
> 
> Can you write to these drives are all? e.g.
> 
>   dd if=/dev/sdb3 of=/tmp/tmp count=1
>   dd if=/tmp/tmp of=/dev/sdb3 oflag=direct
> 
> (hopefully 'direct' will cause write errors to be passed up).

Unfortunately I have no access to the machine right now.

> I really think this looks like a sata problem, not an md problem.

That's possible, but everything except for the md RAID seems to work.  Strange.

I think I'll wait until the next -mm is out and check if the problem goes away. ;-)

Greetings,
Rafael


-- 
If you don't have the time to read,
you don't have the time or the tools to write.
		- Stephen King
