Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288787AbSANSqF>; Mon, 14 Jan 2002 13:46:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288784AbSANSpj>; Mon, 14 Jan 2002 13:45:39 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:21766 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S288801AbSANSpG>; Mon, 14 Jan 2002 13:45:06 -0500
Subject: Re: [linux-lvm] Re: [RFLART] kdev_t in ioctls
To: hch@caldera.de (Christoph Hellwig)
Date: Mon, 14 Jan 2002 18:56:44 +0000 (GMT)
Cc: linux-lvm@sistina.com, viro@math.psu.edu (Alexander Viro),
        torvalds@transmeta.com (Linus Torvalds), linux-kernel@vger.kernel.org
In-Reply-To: <20020114191342.A3731@caldera.de> from "Christoph Hellwig" at Jan 14, 2002 07:13:42 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16QCHl-0002XJ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Glibc disagrees with you (bits/types.h):
> > 
> > typedef __u_quad_t __dev_t;             /* Type of device numbers.  */
> > 
> > We'd have to use __kernel_dev_t instead which again pulls kernel
> > headers in..
> 
> Argg.  That's also non-funny:

glibc is meant to disagree. glibc provides a virtualised dev_t to user space
so that the kernel one can be expanded in future without application
breakage.
