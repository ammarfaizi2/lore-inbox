Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263663AbUEGQ2e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263663AbUEGQ2e (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 12:28:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263686AbUEGQ2d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 12:28:33 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:9183 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S263663AbUEGQ2c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 12:28:32 -0400
Date: Fri, 7 May 2004 18:28:01 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Steve Lord <lord@xfs.org>
Cc: Arjan van de Ven <arjanv@redhat.com>, Dave Jones <davej@redhat.com>,
       Paul Jakma <paul@clubi.ie>, Valdis.Kletnieks@vt.edu,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.6-rc3-mm2 (4KSTACK)
Message-ID: <20040507162801.GA23131@wohnheim.fh-wedel.de>
References: <200405051822.i45IM2uT018573@turing-police.cc.vt.edu> <20040505215136.GA8070@wohnheim.fh-wedel.de> <200405061518.i46FIAY2016476@turing-police.cc.vt.edu> <1083858033.3844.6.camel@laptop.fenrus.com> <Pine.LNX.4.58.0405070136010.1979@fogarty.jakma.org> <20040507065105.GA10600@devserv.devel.redhat.com> <20040507151317.GA15823@redhat.com> <409BAFAC.70601@xfs.org> <20040507155941.GA17850@devserv.devel.redhat.com> <409BB532.50904@xfs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <409BB532.50904@xfs.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 May 2004 11:11:30 -0500, Steve Lord wrote:
> 
> That was not really my point, consider any memory allocation on the
> stack which is being replaced with an allocate to save space. Then replace
> the saved stack space with the potential stack space used to
> free memory by writing it out via a filesystem. You cannot make all
> the allocations in the kernel GFP_NOFS.
> 
> Now at least if the memory is allocated high enough up in the
> call chain it fixes the problems of a function with a large
> stack frame with a deep stack underneath it. It does not fix
> anything if the function is already deep in the stack.
> 
> All this is doing is papering over the cracks.

No, it turns two problems into one.  We have the problem you describe
anyway, there is no point avoiding it here.  It remains unsolved, but
that's just one problem left, not two.

Would it make sense to switch stacks if memory allocation has to free
other memory first?  Sounds a bit insane, but that problem needs a
solution as well.

Jörn

-- 
...one more straw can't possibly matter...
-- Kirby Bakken
