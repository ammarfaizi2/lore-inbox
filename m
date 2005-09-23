Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751214AbVIWAIV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751214AbVIWAIV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 20:08:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751220AbVIWAIV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 20:08:21 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:21731 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751214AbVIWAIV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 20:08:21 -0400
Date: Thu, 22 Sep 2005 17:08:15 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: tty update speed regression (was: 2.6.14-rc2-mm1)
Message-ID: <20050923000815.GB2973@us.ibm.com>
References: <20050921222839.76c53ba1.akpm@osdl.org> <20050922195029.GA6426@mipter.zuzino.mipt.ru> <20050922214926.GA6524@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050922214926.GA6524@mipter.zuzino.mipt.ru>
X-Operating-System: Linux 2.6.13 (i686)
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.09.2005 [01:49:26 +0400], Alexey Dobriyan wrote:
> On Thu, Sep 22, 2005 at 11:50:29PM +0400, Alexey Dobriyan wrote:
> > I see regression in tty update speed with ADOM (ncurses based
> > roguelike) [1].
> > 
> > Messages at the top ("goblin hits you") are printed slowly. An eye can
> > notice letter after letter printing.
> > 
> > 2.6.14-rc2 is OK.
> > 
> > I'll try to revert tty-layer-buffering-revamp*.patch pieces and see if
> > it'll change something.
> > 
> > [1] http://adom.de/adom/download/linux/adom-111-elf.tar.gz (binary only)
> 
> Scratch TTY revamp, the sucker is
> fix-sys_poll-large-timeout-handling.patch
> 
> HZ=250 here.

Alexey,

Thanks for the report. I will take a look on my Thinkpad with HZ=250
under -mm2. I have some ideas for debugging it if I see the same
problem.

Thanks,
Nish
