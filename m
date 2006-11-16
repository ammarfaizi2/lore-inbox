Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424437AbWKPUjq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424437AbWKPUjq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 15:39:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424454AbWKPUjq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 15:39:46 -0500
Received: from aa013msr.fastwebnet.it ([85.18.95.73]:24228 "EHLO
	aa013msr.fastwebnet.it") by vger.kernel.org with ESMTP
	id S1424437AbWKPUjp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 15:39:45 -0500
Date: Thu, 16 Nov 2006 21:39:27 +0100
From: Mattia Dongili <malattia@linux.it>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux1394-devel@lists.sourceforge.net, bcollins@debian.org
Subject: Re: 2.6.19-rc5-mm2
Message-ID: <20061116203926.GA3314@inferi.kami.home>
Mail-Followup-To: Stefan Richter <stefanr@s5r6.in-berlin.de>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	linux1394-devel@lists.sourceforge.net, bcollins@debian.org
References: <20061114014125.dd315fff.akpm@osdl.org> <20061116171715.GA3645@inferi.kami.home> <455CAE0F.1080502@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <455CAE0F.1080502@s5r6.in-berlin.de>
X-Message-Flag: Cranky? Try Free Software instead!
X-Operating-System: Linux 2.6.19-rc5-mm2-1 i686
X-Editor: Vim http://www.vim.org/
X-Disclaimer: Buh!
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16, 2006 at 07:29:35PM +0100, Stefan Richter wrote:
> Mattia Dongili wrote:
> > got the following when removing ohci1394 (also happens in -mm1),
> ...
> > ieee1394: Node removed: ID:BUS[0-00:1023]  GUID[080046030227e7bb]
> > ieee1394: Node removed: ID:BUS[20754571-38:0391]  GUID[00000000f8eb5067]
> 
> Hm, there is garbage in this node data. Moreover, your full logs show
> that there was never another node added besides the host node. IOW the
> second "Node removed" line shouldn't be there. Very strange.
> 
> > BUG: unable to handle kernel NULL pointer dereference at virtual address 000000a4
> ...
> > EIP is at class_device_remove_attrs+0xd/0x34
> ...
> 
> Could you also test one or even better both of:
>  - 2.6.19-rc5 plus
> http://me.in-berlin.de/~s5r6/linux1394/updates/2.6.19-rc5/2.6.19-rc5_ieee1394_v204_experimental.patch.bz2
> (these are the same FireWire drivers as in -rc5-mm2)

the oops disappear

> and/ or
>  - 2.6.19-rc5-mm2 minus
> http://www.it.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc5/2.6.19-rc5-mm2/broken-out/git-ieee1394.patch

the oops is there again.
I suppose git-ieee1394 is the one then...

dmesg:
http://oioio.altervista.org/linux/2.6.19-rc5-test1-ok
http://oioio.altervista.org/linux/2.6.19-rc5-mm2-1-ko

next step (smells like bisection) if for tomorrow :)
-- 
mattia
:wq!
