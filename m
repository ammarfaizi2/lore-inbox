Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263580AbUECDWd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263580AbUECDWd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 May 2004 23:22:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263584AbUECDWd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 May 2004 23:22:33 -0400
Received: from smtpq3.home.nl ([213.51.128.198]:8173 "EHLO smtpq3.home.nl")
	by vger.kernel.org with ESMTP id S263580AbUECDWa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 May 2004 23:22:30 -0400
Message-ID: <4095BAA3.3050000@keyaccess.nl>
Date: Mon, 03 May 2004 05:21:07 +0200
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040117
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: viro@parcelfarce.linux.theplanet.co.uk
CC: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] removal of legacy cdrom drivers (Re: [PATCH] mcdx.c insanity
 removal)
References: <20040502024637.GV17014@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0405011953140.18014@ppc970.osdl.org> <20040503011629.GY17014@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20040503011629.GY17014@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

viro@parcelfarce.linux.theplanet.co.uk wrote:

> Aiiee...
> 
> You know, mcdx.c is like a roadkill - just can't stop looking at the thing.

You should try sbpcd.c. I very enthousiastically opened that up one day, 
thinking it might be a nice little newbie project, then after 30 seconds 
gently closed it again and logged out and in of X to make very sure all 
traces of the terminal that showed it were gone.

But...

> How about removing all that stuff instead of keeping the known broken shit
> in the tree?

I do actually still use two of these drives. An actual soundblaster 
connected "sbpcd" drive (which sits in a 386, and given the fact that 
the new init-module-tools didn't compile against libc5 I haven't tested 
it modular there yet -- builtin it doesn't work) and a "Pro Audio 
Spectrum" connected "cdu31a" which does work. Most of the time. When the 
timing is just right, it even allows me to mount cd-roms:

root@5vd5:~# uname -r
2.6.5
root@5vd5:~# lsmod | grep cdu31a
cdu31a                 24944  1
cdrom                  34112  1 cdu31a
root@5vd5:~# mount | grep cdrom
/dev/sonycd on /mnt/cdrom type iso9660 (ro,noexec,nosuid,nodev,check=r)
root@5vd5:~# ls /mnt/cdrom/
cd.id  install.exe  lecdemos  readme.doc  resource  support

> If you are OK with that (and nobody on l-k stands up and claims that they want
> it alive and *claims* *that* *right* *fucking* *NOW*) I'll send you a patch
> putting these buggers out of their misery.

Hope this qualifies a bit. Must say that one of the things I appreciate 
about Linux is that all this old gunk I have lying about (in fact, still 
drag in from time to time) is actually supported. Or "supported".

Would it be good to have a CONFIG_LEGACY alongside CONFIG_EXPERIMENTAL 
and friends and dump all this crap into drivers/legacy/cdrom, where it 
wouldn't distract serious people?

Rene.
