Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751205AbWH1Stq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751205AbWH1Stq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 14:49:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751331AbWH1Stq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 14:49:46 -0400
Received: from smtp.osdl.org ([65.172.181.4]:18832 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751205AbWH1Stp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 14:49:45 -0400
Date: Mon, 28 Aug 2006 11:49:39 -0700
From: Andrew Morton <akpm@osdl.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: "Miles Lane" <miles.lane@gmail.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.18-rc4-mm3 -- intel8x0 audio busted
Message-Id: <20060828114939.90341479.akpm@osdl.org>
In-Reply-To: <s5hac5o7v47.wl%tiwai@suse.de>
References: <a44ae5cd0608262355q51279259lc6480f229e520fd5@mail.gmail.com>
	<s5hac5o7v47.wl%tiwai@suse.de>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Aug 2006 17:11:52 +0200
Takashi Iwai <tiwai@suse.de> wrote:

> At Sat, 26 Aug 2006 23:55:32 -0700,
> Miles Lane wrote:
> > 
> > I haven't had working audio in 2.6.18-rc4-mm series (1,2,3).
> > I haven't been able to track down the cause yet.  The modules
> > all load, and there seems to be the expected enties in /proc,
> > but my sound preferences panel shows no available audio card.
> (snip)
> > Aug 26 23:16:56 localhost kernel: warning: process `alsactl' used the
> > obsolete sysctl system call
> > Aug 26 23:16:56 localhost kernel: warning: process `ls' used the
> > obsolete sysctl system call
> > Aug 26 23:16:56 localhost kernel: warning: process `alsactl' used the
> > obsolete sysctl system call
> > Aug 26 23:16:56 localhost kernel: warning: process `amixer' used the
> > obsolete sysctl system call
> > Aug 26 23:16:56 localhost kernel: warning: process `amixer' used the
> > obsolete sysctl system call
> 
> Are these messages relavant?  Even "ls" fails there...
> 

No, they're just a little warning we put in there to find out how
removeable sys_sysctl() is.  (Answer: not very.  I'll drop that patch).

It isn't relevant to this problem.
