Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265168AbUAJOFm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 09:05:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265169AbUAJOFm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 09:05:42 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:19472 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S265168AbUAJOFl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 09:05:41 -0500
Date: Sat, 10 Jan 2004 15:05:27 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Maciej Zenczykowski <maze@cela.pl>
Cc: Jesper Juhl <juhl-lkml@dif.dk>, Valdis.Kletnieks@vt.edu,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] invalid ELF binaries can execute - better sanity checking
Message-ID: <20040110140527.GE545@alpha.home.local>
References: <Pine.LNX.4.56.0401090437060.11276@jju_lnx.backbone.dif.dk> <Pine.LNX.4.44.0401092105070.1739-100000@gaia.cela.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0401092105070.1739-100000@gaia.cela.pl>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 09, 2004 at 09:20:53PM +0100, Maciej Zenczykowski wrote:
> I have a 933 byte less and a 305 byte strings command on my initrd
> (taken from some floppy distribution) which report "ERROR: Corrupted
> section header size" via 'file *' and there is probably many many
> more out there.

Then upgrade to file-4.07 which fixes this bad identification. I was very
annoyed by this problem because I too sometimes generate rather tiny
executables, and my build scripts automatically mark them as executables
when 'file' tells me they are ELF executables. When I discovered it, it
was because the victim was init...

Cheers,
Willy

