Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129657AbRCFXCr>; Tue, 6 Mar 2001 18:02:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129660AbRCFXCh>; Tue, 6 Mar 2001 18:02:37 -0500
Received: from waste.org ([209.173.204.2]:36440 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S129657AbRCFXCX>;
	Tue, 6 Mar 2001 18:02:23 -0500
Date: Tue, 6 Mar 2001 17:01:52 -0600 (CST)
From: Oliver Xymoron <oxymoron@waste.org>
To: "David S. Miller" <davem@redhat.com>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        <linuxppc-dev@lists.linuxppc.org>, <linux-kernel@vger.kernel.org>
Subject: Re: The IO problem on multiple PCI busses
In-Reply-To: <15008.17278.154154.210086@pizda.ninka.net>
Message-ID: <Pine.LNX.4.30.0103061657570.19700-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Mar 2001, David S. Miller wrote:

>  > On PPC, we don't have an "IO" space neither, all we have is a range of
>  > memory addresses that will cause IO cycles to happen on the PCI bus.
>
> This is precisely what the "next MMAP is XXX space" ioctl I've
> suggested is for.  I think I've addressed this concern in my
> proposal already.  Look:
>
> 	fd = open("/proc/bus/pci/${BUS}/${DEV}", ...);
> 	if (fd < 0)
> 		return -errno;
> 	err = ioctl(fd, PCI_MMAP_IO, 0);

I know I'm coming in on this late, but wouldn't it be cleaner to have
separate files for memory and io cycles, eg ${BUS}/${DEV}.(io|mem)?
They're logically different so they might as well be embodied separately.

--
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

