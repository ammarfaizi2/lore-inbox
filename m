Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265607AbUBBErB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 23:47:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265611AbUBBErB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 23:47:01 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:16086 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S265607AbUBBEq7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 23:46:59 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Daniel Jacobowitz <dan@debian.org>
Date: Mon, 2 Feb 2004 15:46:49 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16413.54841.104599.928032@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RAID arrays not reconstructing in 2.6
In-Reply-To: message from Daniel Jacobowitz on Sunday February 1
References: <20040201171525.GA2092@nevyn.them.org>
X-Mailer: VM 7.18 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday February 1, dan@debian.org wrote:
> I saw this a couple of weeks ago in a 2.6.0-test kernel, and today in
> 2.6.2-rc3.  When I have to hit the hard reset button on my desktop, whose
> root filesystem is RAID5 on /dev/md0, it comes back up cleanly - no
> reconstruction.

Cool, isn't it!

> 
> Have we gotten a whole lot more enthusiastic about marking superblocks clean
> lately, or should I be worried?  Obviously this always used to trigger
> reconstruction, until recently.

Yes.  Lots more enthusiastic.
If there is no write activity for 20msec, we mark the superblock clean
and write it out, and are careful to write out a dirty superblock
before allowing another write to complete.

NeilBrown

> 
> -- 
> Daniel Jacobowitz
> MontaVista Software                         Debian GNU/Linux Developer
