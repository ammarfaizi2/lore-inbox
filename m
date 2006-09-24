Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932073AbWIXWm3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932073AbWIXWm3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 18:42:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751643AbWIXWm3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 18:42:29 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:10940 "EHLO pasmtpB.tele.dk")
	by vger.kernel.org with ESMTP id S1751646AbWIXWmY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 18:42:24 -0400
Date: Mon, 25 Sep 2006 00:47:40 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, Kirill Korotaev <dev@openvz.org>,
       Andrey Mirkin <amirkin@sw.ru>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 18/28] kbuild: fail kernel compilation in case of unresolved module symbols
Message-ID: <20060924224740.GB28051@uranus.ravnborg.org>
References: <11591327051998-git-send-email-sam@ravnborg.org> <11591327051652-git-send-email-sam@ravnborg.org> <11591327053365-git-send-email-sam@ravnborg.org> <1159132705363-git-send-email-sam@ravnborg.org> <11591327063034-git-send-email-sam@ravnborg.org> <11591327061320-git-send-email-sam@ravnborg.org> <1159132706174-git-send-email-sam@ravnborg.org> <20060924222026.GS29920@ftp.linux.org.uk> <20060924223534.GA27984@uranus.ravnborg.org> <20060924223643.GT29920@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060924223643.GT29920@ftp.linux.org.uk>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 24, 2006 at 11:36:43PM +0100, Al Viro wrote:
> On Mon, Sep 25, 2006 at 12:35:34AM +0200, Sam Ravnborg wrote:
> > On what architectures do you see lots of these warnings - maybe fixable?
> > Otherwise I could do something like this:
> 
> Try allmodconfig someday...

My cross-compile setup severely broke due to me changing dev-machine.
Will restore it when I get my hand on a proper dev machine again - current
box consumes too much power for normal use (almost 300W) and is not much
quicker than my older amd64 box :-(

> 
> aviro@icy:/usr/src/cross-kernel/volatile/work$ grep -l WARNING.*undefined ../logs/*/X4c
> ../logs/alpha-SMP/X4c
> ../logs/alpha/X4c
> ../logs/arm/X4c
> ../logs/armv/X4c
> ../logs/chestnut/X4c
> ../logs/frv/X4c
> ../logs/ia64/X4c
> ../logs/m32r/X4c
> ../logs/m68k/X4c
> ../logs/ppc/X4c
> ../logs/ppc44x/X4c
> ../logs/ppc64/X4c
> ../logs/s390/X4c
> ../logs/s390x/X4c
> ../logs/sparc32/X4c
> ../logs/sparc64/X4c
> ../logs/sun3/X4c
> ../logs/sun4/X4c
> ../logs/uml-i386/X4c
> 
> That's out of 25 targets.  The only variants that do _NOT_ trigger are
> amd64, amd64-UP, i386 and uml-amd64.

How many of these ougth to be fixed then?
> 
> I more or less agree with rationale behind making that default, but I'd
> very much appreciate a way to override that.  For now I've just made the
> -w line unconditional, but the fewer infrastructure patches I've to carry...
OK. Will include it in next round of kbuild updates.

	Sam
