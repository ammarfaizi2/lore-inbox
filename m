Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287571AbSAHUNy>; Tue, 8 Jan 2002 15:13:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287790AbSAHUNf>; Tue, 8 Jan 2002 15:13:35 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:19004 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S287571AbSAHUN0>; Tue, 8 Jan 2002 15:13:26 -0500
Date: Tue, 8 Jan 2002 22:13:15 +0200
From: Ville Herva <vherva@niksula.hut.fi>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2.21pre2 oops
Message-ID: <20020108221315.U1200@niksula.cs.hut.fi>
In-Reply-To: <20020108215818.J1331@niksula.cs.hut.fi> <E16O2fD-0007Vn-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E16O2fD-0007Vn-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Tue, Jan 08, 2002 at 08:16:03PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2002 at 08:16:03PM +0000, you [Alan Cox] claimed:
> > essentially cat /dev/md0 > /dev/null kind of test to stress the Via KT133
> > pci transfers.
> > 
> > Rootfs is on ide cdrom, the harddrives had no fs on them.
> > 
> > ksymoops 0.7c on i686 2.2.21pre2-ide+e2compr+raid.  Options
> > used
> 
> Can you repeat the test to make sure its replicable, then repeat it again
> after disabling the new VIA fixups in pci/quirks.c

The test has been repeated several times even with 2.2.21pre2 (although
we've run a lot more 2.2.20 tests). This was the first time we saw an oops.
The difference between this and the former 2.2.21pre2 runs is certain bios
settings. (We are still trying to isolate the one setting that triggers the
Via pci transfer corruption on HPT reads.) We'll repeat the test with these
settings and try to see if it is via bios settings / pci/quirks.c related.

There seems to be _something_ fishy in the pre2 quirks, since there is at
least one bios setting combination with which 2.2.20 does not show the pci
corruption, but 2.2.21pre2 does. It just that it is really tedious to
isolate. But we are working on it.

 
-- v --

v@iki.fi
