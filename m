Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267464AbUG2VrF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267464AbUG2VrF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 17:47:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265256AbUG2VrE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 17:47:04 -0400
Received: from pimout1-ext.prodigy.net ([207.115.63.77]:65469 "EHLO
	pimout1-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S267466AbUG2VqX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 17:46:23 -0400
Date: Thu, 29 Jul 2004 14:44:12 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Arjan van de Ven <arjanv@redhat.com>, Nathan Scott <nathans@sgi.com>,
       "Jeffrey E. Hundstad" <jeffrey.hundstad@mnsu.edu>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Steve Lord <lord@xfs.org>, linux-xfs@oss.sgi.com,
       xfs-masters@oss.sgi.com,
       Cahya Wirawan <cwirawan@email.archlab.tuwien.ac.at>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] let 4KSTACKS depend on EXPERIMENTAL and XFS on 4KSTACKS=n
Message-ID: <20040729214412.GA22041@taniwha.stupidest.org>
References: <20040720114418.GH21918@email.archlab.tuwien.ac.at> <40FD0A61.1040503@xfs.org> <40FD2E99.20707@mnsu.edu> <20040720195012.GN14733@fs.tum.de> <20040729060900.GA1946@frodo> <20040729114219.GN2349@fs.tum.de> <1091101612.2792.8.camel@laptop.fenrus.com> <20040729211137.GC23589@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040729211137.GC23589@fs.tum.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 29, 2004 at 11:11:37PM +0200, Adrian Bunk wrote:

> There are reports of breakages with 4kb stacks in 2.6, but AFAIK no
> similar reports for 2.4 .

2.4.x uses the stack(s) differently than 2.6.x so it will usually be
harder (but not impossible) to break and less easy to detect.

I believe what Arjan is saying that that 2.4.x effectively really only
has 4K of safely usable stack anyhow (we have some on-stack allocated
data and interrupts use the same stack).

Also, FWIW I do think there were been reports of problems in 2.4.x
that looked like they might be stack-size related (things dying
horribly after an interrupt for example).


  --cw
