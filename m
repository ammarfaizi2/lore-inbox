Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272882AbRIMGhx>; Thu, 13 Sep 2001 02:37:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272885AbRIMGhn>; Thu, 13 Sep 2001 02:37:43 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:29936 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S272882AbRIMGhc>; Thu, 13 Sep 2001 02:37:32 -0400
From: Andreas Dilger <adilger@turbolabs.com>
Date: Thu, 13 Sep 2001 00:37:38 -0600
To: Borsenkow Andrej <Andrej.Borsenkow@mow.siemens.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: FW: [Cooker] rotflags and initrd
Message-ID: <20010913003738.F1541@turbolinux.com>
Mail-Followup-To: Borsenkow Andrej <Andrej.Borsenkow@mow.siemens.ru>,
	linux-kernel@vger.kernel.org
In-Reply-To: <000201c13c17$62c86860$21c9ca95@mow.siemens.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000201c13c17$62c86860$21c9ca95@mow.siemens.ru>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 13, 2001  09:46 +0400, Borsenkow Andrej wrote:
> > Borsenkow Andrej <Andrej.Borsenkow@mow.siemens.ru> writes:
> > > If kernel mounts rootfs directly, you can pass mount options via
> > > rootflags boot parameter, like
> > >
> > > linux rootflags=data=journal
> > 
> > the "rootflags" kernel parameter is not documented in
> > linux/Documentation/kernel-parameters.txt and I can find it in the
> > whole source only at one place. I'm not sure we should honour this.
> 
> Just how "official" the parameter really is? The problem is, you want
> root on reiser to be in notail mode (if you boot off root - in any case,
> to avoid problems with bootloaders) and remounting reiser later AFAIK
> does not change tail conversion mode.

The rootflags parameter is only a part of the ext3 patch, AFAIK.  It
is therefore probably in -ac kernels, but not stock Linus kernels.
Since it is useful by itself, it may be good to submit it as a patch
to Linus (this was done once along with the rootfstype= patch) but
I don't think it made it in.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

