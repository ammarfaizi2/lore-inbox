Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318787AbSIISgy>; Mon, 9 Sep 2002 14:36:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318789AbSIISgy>; Mon, 9 Sep 2002 14:36:54 -0400
Received: from dsl-213-023-039-209.arcor-ip.net ([213.23.39.209]:30399 "EHLO
	starship") by vger.kernel.org with ESMTP id <S318787AbSIISgI>;
	Mon, 9 Sep 2002 14:36:08 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Andrew Morton <akpm@digeo.com>, imran.badr@cavium.com
Subject: Re: Calculating kernel logical address ..
Date: Mon, 9 Sep 2002 20:23:04 +0200
X-Mailer: KMail [version 1.3.2]
Cc: root@chaos.analogic.com, "'David S. Miller'" <davem@redhat.com>,
       linux-kernel@vger.kernel.org
References: <Pine.LNX.3.95.1020909132344.17307A-100000@chaos.analogic.com> <019f01c25826$c553f310$9e10a8c0@IMRANPC> <3D7CE3A1.6A17D428@digeo.com>
In-Reply-To: <3D7CE3A1.6A17D428@digeo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17oTBg-0006qd-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 09 September 2002 20:08, Andrew Morton wrote:
> Imran Badr wrote:
> > 
> > The virt_to_bus() macro would work only for kernel logical addresses. I am
> > trying to find a portable way to figure out the kernel logical address of a
> > user buffer so that I could use virt_to_bus() for DMA. The user address is
> > mmap'ed from kmalloc'ed buffer in the mmap() entry of my driver. Now when
> > the user wants to send this data to the PCI device, it makes an ioctl call
> > and give the user address to the driver. Now driver has to figure out the
> > kernel logical address for DMA.
> 
> You can obtain this info by walking the user's pagetables with
> get_user_pages().  That give `struct page' pointers, with which
> all things are possible.

As long as you can be sure they won't spontaneously vanish on you.

-- 
Daniel
