Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267234AbUG1Ple@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267234AbUG1Ple (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 11:41:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267205AbUG1Ple
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 11:41:34 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:48762 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S267235AbUG1PlB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 11:41:01 -0400
Date: Wed, 28 Jul 2004 19:42:13 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Olaf Hering <olh@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] fix zlib debug in ppc boot header
Message-ID: <20040728174213.GA7226@mars.ravnborg.org>
Mail-Followup-To: Tom Rini <trini@kernel.crashing.org>,
	Olaf Hering <olh@suse.de>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.linuxppc.org
References: <20040728112222.GA7670@suse.de> <20040728152938.GM10891@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040728152938.GM10891@smtp.west.cox.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2004 at 08:29:40AM -0700, Tom Rini wrote:
> On Wed, Jul 28, 2004 at 01:22:22PM +0200, Olaf Hering wrote:
> 
> > The ppc bootloader code will not compile with zlib debug enabled.
> > printf was not defined. Tested with vmlinux.coff
> > This patch was sent out earlier. Appearently it is not possible
> > to use the generic zlib copy in linux/lib
> > 
> > Signed-off-by: Olaf Hering <olh@suse.de>
> 
> Again, I do not want to see this.  First, have you run into an occasion
> where this was needed and helpful?  Second, I would much rather see
> someone just rip out zlib.c and replace it with lib/zlib_deflate than to
> try and modify the code again.

It should be possible just to include the zlib_deflate.o file from lib/.
At least oprofile plays suchs ugly tricks.

	Sam
