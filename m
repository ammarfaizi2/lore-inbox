Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314083AbSGGXcI>; Sun, 7 Jul 2002 19:32:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314085AbSGGXcH>; Sun, 7 Jul 2002 19:32:07 -0400
Received: from pD952ABA4.dip.t-dialin.net ([217.82.171.164]:209 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S314083AbSGGXcF>; Sun, 7 Jul 2002 19:32:05 -0400
Date: Sun, 7 Jul 2002 17:34:34 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Dave Hansen <haveblue@us.ibm.com>
cc: Thunder from the hill <thunder@ngforever.de>, Greg KH <greg@kroah.com>,
       kernel-janitor-discuss 
	<kernel-janitor-discuss@lists.sourceforge.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: BKL removal
In-Reply-To: <3D28CD73.9000601@us.ibm.com>
Message-ID: <Pine.LNX.4.44.0207071730390.10105-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 7 Jul 2002, Dave Hansen wrote:
> Nope.  I missed that one.  Something like "The Little Mainfraime that 
> could?"

It was "The Y2K bug - the last day" by some Marc.

> > So the BKL isn't wrong here, but incorrectly used?
> 
> Not even incorrect, but badly used.  But, this was probably another 
> VFS push.

The most correct would be to lock the struct file in any way so it can't 
be used while I eat it. But I guess that's efficient locking vs. space, 
isn't it? What would happen if we had a locking field on every struct?!

> > Is it really okay to "lock the whole kernel" because of one struct file? 
> > This brings us back to spinlocks...
> 
> Don't think of it as locking the kernel, that isn't really what it 
> does anymore.  You really need to think of it as a special spinlock.

We should rename it to something that actually tells you what it does. 
BTW, when was lock_kernel()? It must be really old if it still locked the 
whole kernel.

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

