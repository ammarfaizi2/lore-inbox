Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267302AbUHDHGb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267302AbUHDHGb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 03:06:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267320AbUHDHGb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 03:06:31 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:1408 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S267302AbUHDHFy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 03:05:54 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: linux-kernel@vger.kernel.org
Date: Wed, 4 Aug 2004 17:05:46 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16656.35530.819884.579436@cse.unsw.edu.au>
Cc: Frank Steiner <fsteiner-mail@bio.ifi.lmu.de>,
       Miquel van Smoorenburg <miquels@cistron.nl>
Subject: Re: NFS-mounted, read-only /dev unusable in 2.6
In-Reply-To: message from Miquel van Smoorenburg on Wednesday August 4
References: <410F481C.9090408@bio.ifi.lmu.de>
	<64bf.410f9d6f.62af@altium.nl>
	<ceouv0$7s8$2@news.cistron.nl>
	<41108380.6080809@bio.ifi.lmu.de>
	<20040804064716.GA31600@traveler.cistron.net>
X-Mailer: VM 7.18 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday August 4, miquels@cistron.nl wrote:
> 
> On 2004.08.04 08:34, Frank Steiner wrote:
> > Miquel van Smoorenburg wrote:
> > 
> > > If having /dev mounted read-only means you cannot open devices
> > > like /dev/console read/write then that is a bug in the NFS client
> > > in the kernel.
> > 
> > Which matches the fact the it works with server running 2.6 and
> > client running 2.4.
> > 
> > > 
> > > On all other filesystems (ext2, ext3, xfs etc) there's no problem
> > > opening devices r/w on a read-only filesystem.
> > 
> > Should I report that as bug to someone special?
> 
> Assuming you have a way to reproduce this, to the NFS client
> maintainer - see the file MAINTAINERS in the kernel source.
> 
> But I just tried to reproduce this on 2.6.7-rc2 (it's what my
> workstation happens to be running) and I can't. I can mount an
> nfs-exported /dev from both 2.4 and 2.6 servers read-only and
> I can open devices on that read-only mount just fine.

Yes, it was a bug in the NFS server in 2.6 that was fixed fairly
recently.

NeilBrown
