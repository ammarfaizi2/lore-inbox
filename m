Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264305AbUEDKVl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264305AbUEDKVl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 06:21:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264302AbUEDKVk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 06:21:40 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:54425 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S264305AbUEDKVG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 06:21:06 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Tue, 4 May 2004 19:13:06 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andreas Schwab <schwab@suse.de>, Adrian Bunk <bunk@fs.tum.de>,
       Eyal Lebedinsky <eyal@eyal.emu.id.au>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.6-rc3: gcc 2.95: cx88 __ucmpdi2 error
Message-ID: <20040504171306.GD18008@bytesex.org>
References: <Pine.LNX.4.58.0404271858290.10799@ppc970.osdl.org> <408F9BD8.8000203@eyal.emu.id.au> <20040501112432.GE2541@fs.tum.de> <Pine.LNX.4.58.0405011025410.18014@ppc970.osdl.org> <jey8oc6lig.fsf@sykes.suse.de> <Pine.LNX.4.58.0405011145570.18014@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0405011145570.18014@ppc970.osdl.org>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > dev->tvnorm->id is __u64.
> > linux/videodev2.h:typedef __u64 v4l2_std_id;
> 
> Ahh. And maybe this only happens for the "switch()" statement, which would 
> explain why gcc-2.95 doesn't have problem with a lot of other 64-bit uses 
> in the kernel.

Yup, seems to be the switch() statement.  gcc-3.3.3 does that as well on
some architectures btw (seen on ppc).  I'll fix it.

  Gerd

