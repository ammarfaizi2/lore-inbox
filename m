Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261407AbULVSVK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261407AbULVSVK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 13:21:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261954AbULVSVK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 13:21:10 -0500
Received: from [213.146.154.40] ([213.146.154.40]:35767 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261407AbULVSVE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 13:21:04 -0500
Date: Wed, 22 Dec 2004 18:21:03 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: linux-kernel@vger.kernel.org, debian-kernel@lists.debian.org
Subject: Re: Problem with XFS and/or VM deadlock in 2.6.8
Message-ID: <20041222182103.GA14586@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Lennart Sorensen <lsorense@csclub.uwaterloo.ca>,
	linux-kernel@vger.kernel.org, debian-kernel@lists.debian.org
References: <20041222141600.GA26253@csclub.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041222141600.GA26253@csclub.uwaterloo.ca>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2004 at 09:16:00AM -0500, Lennart Sorensen wrote:
> I have been having trouble with the filesystem apparently locking up on
> a P4 2.8GHz HT machine (1GB ram, dual 120G SATA in raid1 with LVM on
> top).
> 
> It locks up when I try and delete a lot of small files at once.
> Yesterday I tried to go delete a build dir for gcc-3.3 and while waiting
> for that 1.1GB to be deleted, went to delete a few other source dirs.
> When it got down to about 38M left for gcc-3.3 it stopped getting any
> further and top just showed rm in state D.  A few other rm's eventually
> hit that state too.
> 
> When I went to reboot the machine to get it back to working normally, I
> noticed the console had a bunch of messages from XFS and the VM.  So I
> saved the messages in the hopes someone can figure something out to make
> this go away.
> 
> Kernel version: 2.6.8-1-686-smp v2.6.8-10 (Debian sarge/sid build).

All this should be fixed in 2.6.10-rc3.  The XFS code in Debian's 2.6.8
is very much out of data and has various problems, but 2.6.8 is already
really old and the various required core code changes make it hard to
backport the XFS fixes.
