Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267502AbUG2Wg7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267502AbUG2Wg7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 18:36:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267513AbUG2Wgs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 18:36:48 -0400
Received: from omx3-ext.SGI.COM ([192.48.171.20]:61921 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S267494AbUG2Wbq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 18:31:46 -0400
Date: Fri, 30 Jul 2004 08:30:40 +1000
From: Nathan Scott <nathans@sgi.com>
To: Arjan van de Ven <arjanv@redhat.com>, Adrian Bunk <bunk@fs.tum.de>
Cc: "Jeffrey E. Hundstad" <jeffrey.hundstad@mnsu.edu>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Steve Lord <lord@xfs.org>, linux-xfs@oss.sgi.com,
       Cahya Wirawan <cwirawan@email.archlab.tuwien.ac.at>,
       linux-kernel@vger.kernel.org
Subject: Re: [xfs-masters] Re: [2.6 patch] let 4KSTACKS depend on EXPERIMENTAL and XFS on 4KSTACKS=n
Message-ID: <20040730083040.A2703153@wobbly.melbourne.sgi.com>
References: <20040720114418.GH21918@email.archlab.tuwien.ac.at> <40FD0A61.1040503@xfs.org> <40FD2E99.20707@mnsu.edu> <20040720195012.GN14733@fs.tum.de> <20040729060900.GA1946@frodo> <20040729114219.GN2349@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040729114219.GN2349@fs.tum.de>; from bunk@fs.tum.de on Thu, Jul 29, 2004 at 01:42:19PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan wrote:
> can you then also mark XFS broken in 2.4 entirely?
> 2.4 has a nett stack of also 4Kb... 

The assumptions there are incorrect - 2.4 is now quite a
different kernel - we haven't seen problems like this on
2.4 at all, and I routinely test that failing code path
in our regression tests every other night on 2.4.  There
have certainly been stack consumers in the 2.6 VFS that
weren't there in 2.4 (like AIO and struct kiocb, etc) so
thats not an apples-to-apples comparison anymore.

Adrian wrote:
> 2.6 is a stable kernel series used in production environments.
> 
> Regarding Linus' tree, it's IMHO the best solution to work around it 
> this way until all issues are sorted out.

I'm not really convinced - the EXPERIMENTAL marking should
be plenty of a deterent to folks in production environments.
There are reports of stack overruns on other filesystems as
well with 4KSTACKS, so doesn't seem worthwhile to me to do
this just for XFS.

cheers.

-- 
Nathan
