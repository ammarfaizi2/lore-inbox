Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261269AbVAaRJw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261269AbVAaRJw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 12:09:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261267AbVAaRJc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 12:09:32 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:31621 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261269AbVAaRHH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 12:07:07 -0500
Date: Mon, 31 Jan 2005 17:06:29 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Nix <nix@esperi.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10: SPARC64 mapped figure goes unsignedly negative...
In-Reply-To: <87d5vlwp8k.fsf@amaterasu.srvr.nix>
Message-ID: <Pine.LNX.4.61.0501311642400.6072@goblin.wat.veritas.com>
References: <87sm4izw3u.fsf@amaterasu.srvr.nix> 
    <Pine.LNX.4.61.0501311256580.5368@goblin.wat.veritas.com> 
    <87sm4hwr81.fsf@amaterasu.srvr.nix> 
    <Pine.LNX.4.61.0501311545200.5933@goblin.wat.veritas.com> 
    <87d5vlwp8k.fsf@amaterasu.srvr.nix>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jan 2005, Nix wrote:
> 
> Odd: this machine seems to be using swap, albeit not very much (and I've
> got the swap priorities upside down, as well; whoops, that's probably
> been harming performance for, well, years):
> 
> Filename				Type		Size	Used	Priority
> /dev/sda2                               partition	523016	0	1
> /dev/sda4                               partition	511232	57648	2
> /dev/sdb2                               partition	523016	0	1
> 
> Is the problem that the higher-priority kicking out to swap which should
> happen when memory is tight, won't?

I had thought that it was any kicking out to swap - apart from kicking
tmpfs/shmem pages to swap, which should happen independently of Mapped.

If you're not using tmpfs or shmem, then I'm surprised by that figure.
There was 88 kB out to swap in your original /proc/meminfo, which we
may suppose was before Mapped went negative; but above shows more since.

> I'll build rmap.c with GCC-3.3 later tonight (if I can find a copy on my
> old backups), compare the generated code, and see if anything leaps out
> at me.

Worth doing, thank you.  Rene has sent us the GCC-3.4 output,
but I've not spotted anything the matter with it yet.

Hugh
