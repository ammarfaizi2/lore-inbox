Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264000AbUDNJGC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 05:06:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263999AbUDNJGC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 05:06:02 -0400
Received: from smtp2.libero.it ([193.70.192.52]:22923 "EHLO smtp2.libero.it")
	by vger.kernel.org with ESMTP id S263987AbUDNJFy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 05:05:54 -0400
Date: Wed, 14 Apr 2004 11:05:47 +0200
From: Domenico Andreoli <cavok@libero.it>
To: Paul Wagland <paul@wagland.net>
Cc: Linux mailing list SCSI <linux-scsi@vger.kernel.org>,
       Linux mailing list kernel <linux-kernel@vger.kernel.org>,
       Hans Reiser <reiser@namesys.com>, Atul Mukker <atulm@lsil.com>,
       reiserfs-list@namesys.com
Subject: Re: reiser4 and megaraid problems with debian 2.6.5
Message-ID: <20040414090547.GB13578@raptus.homelinux.org>
Mail-Followup-To: Paul Wagland <paul@wagland.net>,
	Linux mailing list SCSI <linux-scsi@vger.kernel.org>,
	Linux mailing list kernel <linux-kernel@vger.kernel.org>,
	Hans Reiser <reiser@namesys.com>, Atul Mukker <atulm@lsil.com>,
	reiserfs-list@namesys.com
References: <36927C82-8DE0-11D8-A41D-000A95CD704C@wagland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36927C82-8DE0-11D8-A41D-000A95CD704C@wagland.net>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ bringing this also on reiserfs ml, a great place for this kind
  of posts.  this is also the reason of the full quoting. sorry ]

On Wed, Apr 14, 2004 at 08:51:53AM +0200, Paul Wagland wrote:
> Hi all,
 
hi Paul,

> I would like to report on a problem that I am having. I am just testing 
> out the new megaraid unified driver, and have been doing some baseline 
> testing with bonnie++.
> 
> My problem is that, although reiserfs, ext2, jfs and xfs all work, 
> reiser4 fails with the following error:
> ---
> Can't write block.
> Bonnie: drastic I/O error (write(2)): No such file or directory
> ---
> 
> I am using the debian prepared kernel with the debian reiser4 patch. I 
> made a cursory examination of the patch, and it appears to correlate 
> fairly closely with the patch from the namesys site.
 
of course it is correlated to that of namesys! i have no skills at all
to invent reiser4 :))

you forgot to specify version of the patch you are talking about,
currently debian provides two versions. anyway i suppose you are talking
about version 20040326-2, aren't you?

> Given that this works with reiserfs, ext2, jfs and xfs it would appear 
> to be a reiser4 problem, however ext3 also fails, though with a 
> different error, it claims that the disk is full, but it is trying to 
> write a 2 1GB files onto a 2.5GB filesystem, so it should have enough 
> room, and indeed it did even work two or three times out of about 10 
> runs (lots of timing :-). This implies that it might be a megaraid 
> problem. As you can tell, I really have no idea ;-)
> 
> I will try playing around tonight with an official kernel and the 
> official reiser4 patch to see if that makes any difference, but would 
> just like to raise this potential problem sooner rather than later.
 
latest reiser4 snapshot provided a patch which applied cleanly on
2.6.5-rc2 but not to 2.6.5. i had to modify it as suggested on the
reiserfs ml. if you look at the debian package's changelog you can find
the reference to that thread.

> If I can help debug this situation (I am probably the only person 
> trying this combination :-) please let me know how I should go about 
> it.

i'm sorry but i can't help further.

cheers
domenico

-----[ Domenico Andreoli, aka cavok
 --[ http://filibusta.crema.unimi.it/~cavok/gpgkey.asc
   ---[ 3A0F 2F80 F79C 678A 8936  4FEE 0677 9033 A20E BC50
