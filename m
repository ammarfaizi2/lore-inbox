Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316621AbSGGXFO>; Sun, 7 Jul 2002 19:05:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316623AbSGGXFO>; Sun, 7 Jul 2002 19:05:14 -0400
Received: from pD952ABA4.dip.t-dialin.net ([217.82.171.164]:49360 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S316621AbSGGXFN>; Sun, 7 Jul 2002 19:05:13 -0400
Date: Sun, 7 Jul 2002 17:07:40 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Dave Hansen <haveblue@us.ibm.com>
cc: Thunder from the hill <thunder@ngforever.de>, Greg KH <greg@kroah.com>,
       kernel-janitor-discuss 
	<kernel-janitor-discuss@lists.sourceforge.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: BKL removal
In-Reply-To: <3D28C3F0.7010506@us.ibm.com>
Message-ID: <Pine.LNX.4.44.0207071702120.10105-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 7 Jul 2002, Dave Hansen wrote:
> Old Blue?  23 isn't _that_ old!

Obviously, you never read that book about the IBM s/370 named
"Old Blue"...

> BKL use isn't right or wrong -- it isn't a case of creating a deadlock 
> or a race.  I'm picking a relatively random function from "grep -r 
> lock_kernel * | grep /usb/".  I'll show what I think isn't optimal 
> about it.
> 
> "up" is a local variable.  There is no point in protecting its 
> allocation.  If the goal is to protect data inside "up", there should 
> probably be a subsystem-level lock for all "struct uhci_hcd"s or a 
> lock contained inside of the structure itself.  Is this the kind of 
> example you're looking for?

So the BKL isn't wrong here, but incorrectly used?

Is it really okay to "lock the whole kernel" because of one struct file? 
This brings us back to spinlocks...

You're possibly right about this one. What did Greg K-H say?

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

