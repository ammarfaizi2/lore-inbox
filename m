Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266219AbUGTVAb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266219AbUGTVAb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 17:00:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266274AbUGTVAb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 17:00:31 -0400
Received: from pimout3-ext.prodigy.net ([207.115.63.102]:1484 "EHLO
	pimout3-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S266219AbUGTVAa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 17:00:30 -0400
Date: Tue, 20 Jul 2004 13:58:29 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: "Jeffrey E. Hundstad" <jeffrey.hundstad@mnsu.edu>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Steve Lord <lord@xfs.org>, linux-xfs@oss.sgi.com,
       xfs-masters@oss.sgi.com, nathans@sgi.com,
       Cahya Wirawan <cwirawan@email.archlab.tuwien.ac.at>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] let 4KSTACKS depend on EXPERIMENTAL and XFS on 4KSTACKS=n
Message-ID: <20040720205829.GB3217@taniwha.stupidest.org>
References: <20040720114418.GH21918@email.archlab.tuwien.ac.at> <40FD0A61.1040503@xfs.org> <40FD2E99.20707@mnsu.edu> <20040720195012.GN14733@fs.tum.de> <20040720204238.GA3051@taniwha.stupidest.org> <20040720205030.GO14733@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040720205030.GO14733@fs.tum.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 20, 2004 at 10:50:31PM +0200, Adrian Bunk wrote:

> 2.6 is a stable kernel series used in production environments.

so is 2.4.x and problems i mentioned can occur there too but are
harder to hit

> The correct solution is to fix XFS (and other problems with 4kb
> stacks if they occur), and my patch is only a short-term workaround.

it's not really a workaround, it just makes the problems harder to hit

a real fix is going to be hard, it's partly the fact there are
insanely long complicated paths and partly the fact for ia32 gcc
spills register space badly and bloats functions (afaik amd64 uses
significantly less stack in some functions)

> 4KSTACKS=n is simply the better tested case, and 4KSTACKS=y uncovers
> some issues you might not want to see in production environments.

neither address the real problem though


  --cw
