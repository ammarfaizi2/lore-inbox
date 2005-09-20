Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965127AbVITVRs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965127AbVITVRs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 17:17:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965132AbVITVRs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 17:17:48 -0400
Received: from thunk.org ([69.25.196.29]:28358 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S965127AbVITVRr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 17:17:47 -0400
Date: Tue, 20 Sep 2005 17:17:13 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Valdis.Kletnieks@vt.edu
Cc: Roman I Khimov <rik@osrc.info>, reiserfs-list@namesys.com,
       Pavel Machek <pavel@suse.cz>, Hans Reiser <reiser@namesys.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, thenewme91@gmail.com,
       Christoph Hellwig <hch@infradead.org>,
       Denis Vlasenko <vda@ilport.com.ua>, chriswhite@gentoo.org,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: I request inclusion of reiser4 in the mainline kernel
Message-ID: <20050920211713.GB6179@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>, Valdis.Kletnieks@vt.edu,
	Roman I Khimov <rik@osrc.info>, reiserfs-list@namesys.com,
	Pavel Machek <pavel@suse.cz>, Hans Reiser <reiser@namesys.com>,
	Horst von Brand <vonbrand@inf.utfsm.cl>, thenewme91@gmail.com,
	Christoph Hellwig <hch@infradead.org>,
	Denis Vlasenko <vda@ilport.com.ua>, chriswhite@gentoo.org,
	LKML <linux-kernel@vger.kernel.org>
References: <200509182004.j8IK4JNx012764@inti.inf.utfsm.cl> <432E5024.20709@namesys.com> <20050920075133.GB4074@elf.ucw.cz> <200509202328.28501.rik@osrc.info> <200509202015.j8KKFfjd025051@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509202015.j8KKFfjd025051@turing-police.cc.vt.edu>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2005 at 04:15:41PM -0400, Valdis.Kletnieks@vt.edu wrote:
> On Tue, 20 Sep 2005 23:28:12 +0400, Roman I Khimov said:
> > --nextPart1692600.LIfSYN1P7A
> 
> > Maybe I'm doing something wrong here, but ext2 have failed on second check
> > of first pass with
> > 
> > Second check...
> > e2fsck 1.34 (25-Jul-2003)
> > Pass 1: Checking inodes, blocks, and sizes
> > Pass 2: Checking directory structure
> 
> > fsck.damaged: ***** FILE SYSTEM WAS MODIFIED *****
> > fsck.damaged: 1345/25064 files (1.7% non-contiguous), 94063/100000 blocks
> > fsck lied about its success (result = 1)

>From the fsck man page:

       The exit code returned by fsck is the sum of the following conditions:
            0    - No errors
            1    - File system errors corrected
            2    - System should be rebooted
            4    - File system errors left uncorrected
            8    - Operational error
            16   - Usage or syntax error
            32   - Fsck canceled by user request
            128  - Shared library error

An exit code of 1 means that filesystem errors were corrected
(successfully).  

This is a convention that has been around for a long time (since at
least BSD 4.x).

						- Ted
