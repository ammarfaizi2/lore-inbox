Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262418AbUIZTkY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262418AbUIZTkY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Sep 2004 15:40:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262406AbUIZTkY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Sep 2004 15:40:24 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:42914 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S262418AbUIZTkT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Sep 2004 15:40:19 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Sun, 26 Sep 2004 21:26:19 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Peter Osterlund <petero2@telia.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.9-rc2
Message-ID: <20040926192618.GA13188@bytesex>
References: <Pine.LNX.4.58.0409130937050.4094@ppc970.osdl.org> <m3ekl5de7b.fsf@telia.com> <m3pt49ik7y.fsf@telia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3pt49ik7y.fsf@telia.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > makes my computer lock up or instantly reboot when I try to do a tv
> > recording with mplayer.
> 
> I think the patch below should be applied before 2.6.9. It fixes the
> bug that made the card DMA lots of data to random memory locations,
> causing lockups and instant reboots.

> +	int topfield = (0 == yoffset);
> -			if (!yoffset)
> +			if (topfield)

Fix is ok.  I've submitted another bttv update with that one included
to andrew already (is in current -mm) through.

  Gerd

-- 
return -ENOSIG;
