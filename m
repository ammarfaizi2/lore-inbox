Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268316AbUI2Lr0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268316AbUI2Lr0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 07:47:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268313AbUI2Lr0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 07:47:26 -0400
Received: from jive.SoftHome.net ([66.54.152.27]:51154 "HELO jive.SoftHome.net")
	by vger.kernel.org with SMTP id S268316AbUI2LrU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 07:47:20 -0400
Date: Wed, 29 Sep 2004 19:03:46 +0800
From: Joshua Ross <jrxr@softhome.net>
To: "=?ISO-8859-1?Q?Rog=E9rio?= Brito" <rbrito@ime.usp.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Data corruption on IDE disk via USB.
Message-Id: <20040929190346.1a5e7c31.jrxr@softhome.net>
In-Reply-To: <20040929104049.GA3816@ime.usp.br>
References: <20040929171744.0b3a0773.jrxr@softhome.net>
	<20040929104049.GA3816@ime.usp.br>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Sep 2004 07:40:49 -0300
Rogério Brito <rbrito@ime.usp.br> wrote:

> On Sep 29 2004, Joshua Ross wrote:
> > I have an external hard drive with an IDE interface.  This goes
> > through a USB2.0-IDE adapter.  I'm getting silent corruption of data
> > when copying big files to the drive, but not consistently.  The
> > partition was originally ext3, but I'm now mounting it ext2 and
> > sync.  Still getting the corruption.  
> 
> Which kind of corruption are you seeing? I was seeing some non-silent
> problems with an IDE drive connected in a Firewire/USB2 enclosure.
> 
	Well, I'm currently stuck in the middle of a long fsck loop.  I
successfully ran fsck once, correcting errors.  I thought I'd double
check and ran it again.  The following is a short section from it:

Restarting e2fsck from the beginning...                                 
      
Pass 1: Checking inodes, blocks, and sizes
Inode 8 has illegal block(s).  Clear<y>? yes                            
      

Illegal block #4254 (1043168817) in inode 8.  CLEARED.
Illegal block #4255 (1779650960) in inode 8.  CLEARED.
Illegal block #4256 (119610448) in inode 8.  CLEARED.
Illegal block #4257 (1023971144) in inode 8.  CLEARED.
Illegal block #4258 (2687440014) in inode 8.  CLEARED.
Illegal block #4259 (1952817553) in inode 8.  CLEARED.
Illegal block #4260 (4225006687) in inode 8.  CLEARED.
Illegal block #4261 (885351209) in inode 8.  CLEARED.
Illegal block #4262 (2972213350) in inode 8.  CLEARED.
Illegal block #4263 (367138787) in inode 8.  CLEARED.
Illegal block #4264 (1016997915) in inode 8.  CLEARED.
Too many illegal blocks in inode 8.
Clear inode<y>? yes

Restarting e2fsck from the beginning...                                 
      
Pass 1: Checking inodes, blocks, and sizes
Inode 8 has illegal block(s).  Clear<y>? yes                            
      

Illegal block #4265 (3534702556) in inode 8.  CLEARED.
Illegal block #4266 (1881325444) in inode 8.  CLEARED.
Illegal block #4267 (965385379) in inode 8.  CLEARED.
Illegal block #4268 (1938219089) in inode 8.  CLEARED.
Illegal block #4270 (2567249910) in inode 8.  CLEARED.
Illegal block #4271 (339569508) in inode 8.  CLEARED.
Illegal block #4272 (3827439844) in inode 8.  CLEARED.
Illegal block #4273 (3719372914) in inode 8.  CLEARED.
Illegal block #4274 (423250370) in inode 8.  CLEARED.
Illegal block #4275 (1503941510) in inode 8.  CLEARED.
Illegal block #4276 (3125961630) in inode 8.  CLEARED.
Too many illegal blocks in inode 8.
Clear inode<y>? yes

Restarting e2fsck from the beginning...                                 
      
Pass 1: Checking inodes, blocks, and sizes
Inode 8 has illegal block(s).  Clear<y>? yes                            
      

Illegal block #4277 (4003997203) in inode 8.  CLEARED.
Illegal block #4278 (1927319268) in inode 8.  CLEARED.
Illegal block #4279 (1988850371) in inode 8.  CLEARED.
Illegal block #4280 (1493009126) in inode 8.  CLEARED.
Illegal block #4281 (96127493) in inode 8.  CLEARED.
Illegal block #4282 (1023388584) in inode 8.  CLEARED.
Illegal block #4283 (407114002) in inode 8.  CLEARED.
Illegal block #4284 (3769922052) in inode 8.  CLEARED.
Illegal block #4285 (1805259680) in inode 8.  CLEARED.
Illegal block #4286 (189165963) in inode 8.  CLEARED.
Illegal block #4287 (700103729) in inode 8.  CLEARED.
Too many illegal blocks in inode 8.
Clear inode<y>? yes


> Using it with my iBook on MacOS X is perfectly ok, but trying to use
> the drive connected to a USB 1.1 desktop (my main computer) under
> Linux also presented problems when copying a large file (one of
> Dijkstra's talks).
> 
	I've got it on USB 2.0.  I have a 1.1 port that I'll see whether I can
reproduce it on, once the fsck has finished!

> This error, differently from yours, was consistent and produced a lot
> of messages regarding the media of the "USB drive" being removed (!)
> from the system (while it obviously wasn't) and it left me with
> corrupted filesystems (I tried ext2/3, vfat and hfsplus, which are
> things that both MacOS X and Linux can read).
> 
	I'm not getting anything logged.

> I usually tried to use rsync to copy the files, but, if I remember
> correctly, the problem would also manifest when using plain cp.
> 
	I was also trying rsync, but am now restricting myself to cp to see if
that helped.  It didn't seem to.
