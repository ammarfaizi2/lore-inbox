Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268654AbRGZUrU>; Thu, 26 Jul 2001 16:47:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268653AbRGZUrK>; Thu, 26 Jul 2001 16:47:10 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:50097 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S267787AbRGZUrD>; Thu, 26 Jul 2001 16:47:03 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: "Roeland Th. Jansen" <roel@grobbebol.xs4all.nl>
Date: Fri, 27 Jul 2001 06:46:52 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15200.33212.620647.474271@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
Subject: Re: nfs weirdness
In-Reply-To: message from Roeland Th. Jansen on Thursday July 26
In-Reply-To: <20010723154217.F19492@grobbebol.xs4all.nl>
	<15197.21462.625678.700365@notabene.cse.unsw.edu.au>
	<20010726193741.J19492@grobbebol.xs4all.nl>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Thursday July 26, roel@grobbebol.xs4all.nl wrote:
> On Tue, Jul 24, 2001 at 08:54:14PM +1000, Neil Brown wrote:
> > If you ask to export "/windows" and nothing is mounted on "/windows",
> > then you are asking to export part of the root filesystem starting at
> > "/windows".  If you subsequently mount something on /windows, then you
> > haven't asked for that to be exported so it won't be, and mountd will
> > get confused.
> > You should always mount filesystems before trying to export them.
> 
> 
> well, I tested it for trouble shooting. if I mount the /windows vfat and
> export with knfsd it fails. if I do not moiut the vfat, it does. ergo,
> the config files are okay, knfsd refuses. 
> 
> 
> somebody else pointed out in private mail that knfsd isn't supposed to
> be able to export vfat filesystems and unfsd could. if he is correct, I
> will have to onstall the other utils again and install unfsd
> instead.

Yep, current kernels do not support exporting of FAT based filesystems.
There is a patch at:

http://www.cse.unsw.edu.au/~neilb/patches/linux/2.4.7/patch-E-fatnfs

that should fix this.  I have done minimal testing, but I am waiting
for someone who actually needs to use this functionality to try it out
and confirm that it works for real-life situations before I recommend
it to Linus.

NeilBrown
