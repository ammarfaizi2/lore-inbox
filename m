Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129619AbRBWA6w>; Thu, 22 Feb 2001 19:58:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129727AbRBWA6m>; Thu, 22 Feb 2001 19:58:42 -0500
Received: from felix.convergence.de ([212.84.236.131]:59783 "EHLO
	convergence.de") by vger.kernel.org with ESMTP id <S129619AbRBWA62>;
	Thu, 22 Feb 2001 19:58:28 -0500
Date: Fri, 23 Feb 2001 01:59:18 +0100
From: Felix von Leitner <leitner@convergence.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [rfc] Near-constant time directory index for Ext2
Message-ID: <20010223015918.A28372@convergence.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <3A948F7B.E40C81D5@transmeta.com> <E14Vt61-0003sC-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <E14Vt61-0003sC-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Thu, Feb 22, 2001 at 10:35:34AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thus spake Alan Cox (alan@lxorguk.ukuu.org.uk):
> > > There will be a lot fewer metadata index
> > > blocks in your directory file, for one thing.
> > Oh yes, another thing: a B-tree directory structure does not need
> > metadata index blocks.
> Before people get excited about complex tree directory indexes, remember to 
> solve the other 95% before implementation - recovering from lost blocks,
> corruption and the like

And don't forget the trouble with NFS handles after the tree was rebalanced.

Trees are nice only theoretically.  In practice, the benefits are
outweighed by the nastiness in form of fsck and NFS and bigger code
(normally: more complex -> less reliable).

Felix
