Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289363AbSBFQ1j>; Wed, 6 Feb 2002 11:27:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290643AbSBFQ1a>; Wed, 6 Feb 2002 11:27:30 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:35723 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S289363AbSBFQ1T>; Wed, 6 Feb 2002 11:27:19 -0500
Date: Wed, 6 Feb 2002 18:26:57 +0200
From: Ville Herva <vherva@niksula.hut.fi>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Christoph Rohland <cr@sap.com>, Andries.Brouwer@cwi.nl, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Subject: Re: How to check the kernel compile options ?
Message-ID: <20020206162657.GD534915@niksula.cs.hut.fi>
Mail-Followup-To: Ville Herva <vherva@niksula.cs.hut.fi>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Christoph Rohland <cr@sap.com>,
	Andries.Brouwer@cwi.nl, hpa@zytor.com, linux-kernel@vger.kernel.org
In-Reply-To: <m3ofj2galz.fsf@linux.local> <E16YSs7-0005GY-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16YSs7-0005GY-00@the-village.bc.nu>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2002 at 02:16:27PM +0000, you [Alan Cox] wrote:
> > > If you are going to cat it onto the end of the kernel image just
> > > mark it __initdata and shove a known symbol name on it. It'll get
> > > dumped out of memory and you can find it trivially by using tools on
> > > the binary
> > 
> > What about putting such info into a (swappable) tmpfs file with
> > shmem_file_setup?
> 
> That is indeed an extremely cunning plan. Paticularly as /proc/config can
> be a symlink to it

What is even harder to find out given a binary kernel is which patches (if
any) have been applied to it. What if there was one file (say,
/usr/src/linux/patches) to which each (well-behaved) patch would append a
line or two (patch name, version, author, url), and then you could later
extract that information the same way you extract .config?

Figuring out what patches have been applied can be hard even given a source
tree, so this could be useful even without the data-in-bzImage thing.


-- v --

v@iki.fi
