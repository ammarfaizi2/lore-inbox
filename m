Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262082AbREMRg4>; Sun, 13 May 2001 13:36:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262062AbREMRgr>; Sun, 13 May 2001 13:36:47 -0400
Received: from t2.redhat.com ([199.183.24.243]:24314 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S262061AbREMRgj>; Sun, 13 May 2001 13:36:39 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <15100.37367.477922.66043@pizda.ninka.net> 
In-Reply-To: <15100.37367.477922.66043@pizda.ninka.net>  <20010511162745.B18341@sistina.com> <E14yDyI-0000yE-00@the-village.bc.nu> <20010511171124.M30355@athlon.random> <15100.18375.367656.3591@pizda.ninka.net> <20010512032453.A8259@athlon.random> 
To: "David S. Miller" <davem@redhat.com>
Cc: Andrea Arcangeli <andrea@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Mauelshagen@sistina.com, linux-kernel@vger.kernel.org, mge@sistina.com,
        hch@caldera.de
Subject: Re: LVM 1.0 release decision 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 13 May 2001 18:36:11 +0100
Message-ID: <23605.989775371@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


davem@redhat.com said:
> Andrea Arcangeli writes:
>  > Related side note: for the x86-64 kernel we won't support the emulation
>  > of the lvm ioctl from the 32bit executables to avoid the pointer
>  > conversion an mainteinance pain enterely, at least in the early stage
>  > the x86-64 lvmtools will have to be compiled elf64.

> I think that's a bad decision, but it is your's.

> To me, either you support fully the 32-bit execution environment or
> you do not.  After all the work that myself and others have done for
> other platforms, there really is no need to cut corners in this area.

IMHO, no 64-bit architecture code should provide translation functions for
ioctls from 32-bit binaries.

This is now a sufficiently common requirement that it shouldn't be repeated 
by all architectures that require it - it should be somewhere common.
Like linux/abi/ioctl32/



--
dwmw2


