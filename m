Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264306AbUEYQCM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264306AbUEYQCM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 12:02:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264939AbUEYQCM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 12:02:12 -0400
Received: from ipcop.bitmover.com ([192.132.92.15]:37341 "EHLO
	work.bitmover.com") by vger.kernel.org with ESMTP id S264306AbUEYQCL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 12:02:11 -0400
Date: Tue, 25 May 2004 09:02:00 -0700
From: Andy Isaacson <adi@bitmover.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Christian <evil@g-house.de>, linux-kernel@vger.kernel.org,
       support@bitmover.com
Subject: Re: tarballs of patchsets?
Message-ID: <20040525160200.GA30213@bitmover.com>
References: <40B21F98.1080803@g-house.de> <20040524105552.311a990b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040524105552.311a990b.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 24, 2004 at 10:55:52AM -0700, Andrew Morton wrote:
> Christian <evil@g-house.de> wrote:
> > i am trying to chase some bug and i know, it must be somewhere
> > between 2.6.4 and 2.6.5.
> 
> The most practical way of doing this would be to download bitkeeper and do
> a binary search.
> 
>  1: Do `bk changes > foo'.
[snip]
>  2: Do
>  	bl clone -ql -r1.1734 ref-repo test-repo
[snip]
>  3: cd test-repo ; bk -r get
>  4: build, test, choose new revision, goto step 1.

FWIW, we're batting around the idea of automating this -- it would be
cool (and quite trivial) to have a "bk-findbug.sh" script that takes
 - a repo
 - "I know the bug wasn't present in 1.1562"
 - "the bug is present in 1.1699"
 - a shell fragment that exits 1 if the bug exists, 0 if the bug is squashed

and tells you which cset causes the bug to appear.

But, applying this to the kernel is more problematic; you have to
reboot, or run under vmware/UML/Xen/whatever.

-andy
