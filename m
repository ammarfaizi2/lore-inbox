Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317470AbSGEOND>; Fri, 5 Jul 2002 10:13:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317471AbSGEONC>; Fri, 5 Jul 2002 10:13:02 -0400
Received: from moutvdomng1.kundenserver.de ([195.20.224.131]:57071 "EHLO
	moutvdomng1.kundenserver.de") by vger.kernel.org with ESMTP
	id <S317470AbSGEONA>; Fri, 5 Jul 2002 10:13:00 -0400
Date: Fri, 5 Jul 2002 08:15:24 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Shaya Potter <spotter@cs.columbia.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: prevent breaking a chroot() jail?
In-Reply-To: <1025877004.11004.59.camel@zaphod>
Message-ID: <Pine.LNX.4.44.0207050804250.10105-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5 Jul 2002, Shaya Potter wrote:
> What should I be aware of?  I figure devices (no need to run mknod in
> this jail) and chroot (as per man page), is there any other way of
> breaking the chroot jail (at a syscall level or otherwise)?
> 
> or is this 100% impossible?

Well, since we're talking about root:

 - If you had saved the old root before chroot()ing, use that one.
 - If you have your whole disk exported via NFS, the prisoner process 
   could use nfs to read files outside the jail
 - If you have access to a /dev directory, use /dev/sd?? to do the disc
   access
 - If not, use mknod("dideldei", 600, {68,1}); open("dideldei", O_SYNC);
   and do as you like.

However, if you aren't running anything you find as root, it's relatively 
secure.

							Regards,
							Thunder
-- 
(Use http://www.ebb.org/ungeek if you can't decode)
------BEGIN GEEK CODE BLOCK------
Version: 3.12
GCS/E/G/S/AT d- s++:-- a? C++$ ULAVHI++++$ P++$ L++++(+++++)$ E W-$
N--- o?  K? w-- O- M V$ PS+ PE- Y- PGP+ t+ 5+ X+ R- !tv b++ DI? !D G
e++++ h* r--- y- 
------END GEEK CODE BLOCK------

