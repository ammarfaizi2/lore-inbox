Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262251AbUCAGIj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 01:08:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262254AbUCAGIj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 01:08:39 -0500
Received: from pfepc.post.tele.dk ([195.41.46.237]:15885 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S262251AbUCAGIh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 01:08:37 -0500
Date: Mon, 1 Mar 2004 07:08:59 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: Is the 2.6 dependency information complete? Doesn't look so...
Message-ID: <20040301060859.GA2129@mars.ravnborg.org>
Mail-Followup-To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>
References: <20040229235150.GA6327@merlin.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040229235150.GA6327@merlin.emma.line.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 01, 2004 at 12:51:50AM +0100, Matthias Andree wrote:
> Hi,
> 
> I've just seen, after a BK pull:
> 
>   CC      fs/nfsd/nfsctl.o
> fs/nfsd/nfsctl.c:28:30: linux/nfsd_idmap.h: no such file or directory
> 
> This is a hint the dependency information isn't complete, otherwise, GNU
> make would've "get"^Wgot the include file.
> 
> Will the kernel rebuild dependent files when includes change when this
> information is missing? If so, how?

kbuild scans for dependencies and build the output file in one go.
Therefore from a make perspective it will not see the new dependency of
nfsd_idmap.h when starting to compile nfsctl.c.

Dependencies are first OK after first kernel compile.
So if you tried twice the 'bk get' functionality should be OK.

	Sam
