Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288784AbSANSse>; Mon, 14 Jan 2002 13:48:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288814AbSANSr5>; Mon, 14 Jan 2002 13:47:57 -0500
Received: from ns.caldera.de ([212.34.180.1]:26256 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S288809AbSANSrW>;
	Mon, 14 Jan 2002 13:47:22 -0500
Date: Mon, 14 Jan 2002 19:45:54 +0100
From: Christoph Hellwig <hch@caldera.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-lvm@sistina.com, Alexander Viro <viro@math.psu.edu>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [linux-lvm] Re: [RFLART] kdev_t in ioctls
Message-ID: <20020114194554.A5885@caldera.de>
Mail-Followup-To: Christoph Hellwig <hch@caldera.de>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-lvm@sistina.com,
	Alexander Viro <viro@math.psu.edu>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020114191342.A3731@caldera.de> <E16QCHl-0002XJ-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E16QCHl-0002XJ-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Mon, Jan 14, 2002 at 06:56:44PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2002 at 06:56:44PM +0000, Alan Cox wrote:
> > > Glibc disagrees with you (bits/types.h):
> > > 
> > > typedef __u_quad_t __dev_t;             /* Type of device numbers.  */
> > > 
> > > We'd have to use __kernel_dev_t instead which again pulls kernel
> > > headers in..
> > 
> > Argg.  That's also non-funny:
> 
> glibc is meant to disagree. glibc provides a virtualised dev_t to user space
> so that the kernel one can be expanded in future without application
> breakage.

I know - still it makes Linus' suggestion not work on ~90% of the
systems.
