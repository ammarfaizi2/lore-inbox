Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262023AbUKVKDI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262023AbUKVKDI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 05:03:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262011AbUKVKDI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 05:03:08 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:63127 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S262023AbUKVKB1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 05:01:27 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Mon, 22 Nov 2004 10:53:57 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Cc: Michael Hunold <hunold@linuxtv.org>, Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Michael Hunold <hunold@convergence.de>
Subject: Re: Fw: Re: Linux 2.6.10-rc2 [dvb-bt8xx unload oops]
Message-ID: <20041122095357.GE29305@bytesex>
References: <20041116014350.54500549.akpm@osdl.org> <20041118130312.GE19568@bytesex> <419CD8BC.1080401@linuxtv.org> <419EA1DD.2000004@eyal.emu.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <419EA1DD.2000004@eyal.emu.id.au>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Also, does anyone know how to switch to text console when X locks up (as
> it does for me)?  sysrq works but does not allow me to switch to another
> console. Since the hard lock does not log the oops, and I cannot see the
> text from sysrq, I cannot report the details.

Setting up a serial console works best for that ...

> Nov 19 23:37:44 eyal kernel: EIP is at buffer_queue+0x33/0x6f [bttv]

That most likely a bug in bttv, I've pinned it down and queued a patch
to fix that end of last week.  I've also seen mails from Andrew
forwarding stuff to Linus on a quick scan of my inbox, so the latest
-bk snapshots might already have that fix.

  Gerd

-- 
#define printk(args...) fprintf(stderr, ## args)
