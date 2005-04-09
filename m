Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261302AbVDIHrb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261302AbVDIHrb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Apr 2005 03:47:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261308AbVDIHrb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Apr 2005 03:47:31 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:21196 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S261302AbVDIHr3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Apr 2005 03:47:29 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Willy Tarreau <willy@w.ods.org>
Date: Sat, 9 Apr 2005 17:47:08 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16983.34940.197017.568255@cse.unsw.edu.au>
Cc: Chris Wedgwood <cw@f00f.org>, Linus Torvalds <torvalds@osdl.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Matthias-Christian Ott <matthias.christian@tiscali.de>,
       Andrea Arcangeli <andrea@suse.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel SCM saga..
In-Reply-To: message from Willy Tarreau on Saturday April 9
References: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org>
	<20050408041341.GA8720@taniwha.stupidest.org>
	<Pine.LNX.4.58.0504072127250.28951@ppc970.osdl.org>
	<20050408071428.GB3957@opteron.random>
	<Pine.LNX.4.58.0504080724550.28951@ppc970.osdl.org>
	<4256AE0D.201@tiscali.de>
	<Pine.LNX.4.58.0504081010540.28951@ppc970.osdl.org>
	<4256C0F8.6030008@pobox.com>
	<Pine.LNX.4.58.0504081114220.28951@ppc970.osdl.org>
	<20050408185608.GA5638@taniwha.stupidest.org>
	<20050409073726.GC7858@alpha.home.local>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday April 9, willy@w.ods.org wrote:
> 
> I've just checked, it takes 5.7s to compare 2.4.29{,-hf3} over NFS (13300
> files each) and 1.3s once the trees are cached locally. This is without
> comparing file contents, just meta-data. And it takes 19.33s to compare
> the file's md5 sums once the trees are cached. I don't know if there are
> ways to avoid some NFS operations when everything is cached.
> 
> Anyway, the system does not seem much efficient on hard links, it caches
> the files twice :-(

I suspect you'll be wanting to add a "no_subtree_check" export option
on your NFS server...

NeilBrown
