Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315429AbSFDLLI>; Tue, 4 Jun 2002 07:11:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315461AbSFDLLH>; Tue, 4 Jun 2002 07:11:07 -0400
Received: from [213.237.118.153] ([213.237.118.153]:45696 "EHLO Princess")
	by vger.kernel.org with ESMTP id <S315429AbSFDLLG>;
	Tue, 4 Jun 2002 07:11:06 -0400
From: Allan Sandfeld <linux@sneulv.dk>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: RAID-6 support in kernel?
Date: Tue, 4 Jun 2002 13:11:03 +0200
User-Agent: KMail/1.4.5
In-Reply-To: <Pine.LNX.4.33.0206031025400.30424-100000@mail.pronto.tv> <3CFB2F92.34D174C3@daimi.au.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200206041311.03631.linux@sneulv.dk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 03 June 2002 10:57, Kasper Dupont wrote:
> Roy Sigurd Karlsbakk wrote:
> > > > RAID-6 layout: http://www.acnc.com/04_01_06.html
> > >
> > > If it is supposed to survive two arbitrary disk failures something is
> > > wrong with that figure. They store 12 logical sectors in 20 physical
> > > sectors across 4 drives. With two lost disks there are 10 physical
> > > sectors left from which we want to reconstruct 12 logical sectors.
> > > That is impossible.
> >
> > Might be the diagram is wrong.
>
> Could be the case, so until I find another description I will
> still not know how RAID-6 works.
>
It's not just the diagram, the theory is wrong. You need to use at least log2 
n+1 disks for partition if you want to handle any two lost/borked disks. (16 
disks would give 11x diskspace). 
