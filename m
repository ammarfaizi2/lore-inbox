Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932173AbWBSRuY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932173AbWBSRuY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 12:50:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932177AbWBSRuY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 12:50:24 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:54658 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S932173AbWBSRuY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 12:50:24 -0500
Subject: Re: 2.6.16-rc4: known regressions
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Adrian Bunk <bunk@stusta.de>
Cc: Robert Love <rml@novell.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       John Stultz <johnstul@us.ibm.com>, gregkh@suse.de
In-Reply-To: <20060219145442.GA4971@stusta.de>
References: <Pine.LNX.4.64.0602171438050.916@g5.osdl.org>
	 <20060217231444.GM4422@stusta.de>
	 <84144f020602190306o3149d51by82b8ccc6108af012@mail.gmail.com>
	 <20060219145442.GA4971@stusta.de>
Date: Sun, 19 Feb 2006 19:50:21 +0200
Message-Id: <1140371421.11225.2.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.4.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/18/06, Adrian Bunk <bunk@stusta.de> wrote:
> > > Subject    : gnome-volume-manager broken on powerpc since 2.6.16-rc1
> > > References : http://bugzilla.kernel.org/show_bug.cgi?id=6021
> > > Submitter  : John Stultz <johnstul@us.ibm.com>
> > > Status     : still present in -git two days ago

On Sun, Feb 19, 2006 at 01:06:45PM +0200, Pekka Enberg wrote:
> > This is not ppc only. I have the exact same problem on Gentoo
> > Linux/x86. No ipod events on 2.6.16-rc1, whereas 2.6.15 works fine.
> > Haven't had the time to investigate further yet, sorry.

On Sun, 2006-02-19 at 15:54 +0100, Adrian Bunk wrote:
> Thanks for this information.
> 
> Robert, can you look at this problem?

I am doing git bisect now. Will post complete results when I have them.
Here's current git bisect log if that's any help:

penberg ~/devel/kernel/2.6-git 2 git bisect log
git-bisect start
# bad: [f3bcf72eb85aba88a7bd0a6116dd0b5418590dbe] Linux v2.6.16-rc1
git-bisect bad f3bcf72eb85aba88a7bd0a6116dd0b5418590dbe
# good: [dab47a31f42a23d2b374e1cd7d0b797e8e08b23d] Linux v2.6.15
git-bisect good dab47a31f42a23d2b374e1cd7d0b797e8e08b23d
# bad: [64ca9004b819ab87648dbfc78f3ef49ee491343e] Make vm86 support optional
git-bisect bad 64ca9004b819ab87648dbfc78f3ef49ee491343e
# bad: [0a75c23a009ff65f651532cecc16675d05f4de37] Merge with http://kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
git-bisect bad 0a75c23a009ff65f651532cecc16675d05f4de37
# bad: [d779188d2baf436e67fe8816fca2ef53d246900f] Merge branch 'upstream-linus' of master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/netdev-2.6
git-bisect bad d779188d2baf436e67fe8816fca2ef53d246900f

			Pekka

