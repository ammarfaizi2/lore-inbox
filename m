Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262971AbTJJPx0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 11:53:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262973AbTJJPx0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 11:53:26 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:54155 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S262971AbTJJPxY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 11:53:24 -0400
Date: Fri, 10 Oct 2003 16:53:22 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Misc NFSv4 (was Re: statfs() / statvfs() syscall ballsup...)
Message-ID: <20031010155322.GH28795@mail.shareable.org>
References: <Pine.LNX.4.44.0310091525200.20936-100000@home.osdl.org> <3F85ED01.8020207@redhat.com> <20031010002248.GE7665@parcelfarce.linux.theplanet.co.uk> <20031010044909.GB26379@mail.shareable.org> <16262.17185.757790.524584@charged.uio.no> <20031010123732.GA28224@mail.shareable.org> <16262.47147.943477.24070@charged.uio.no> <20031010143553.GA28795@mail.shareable.org> <16262.53512.249701.158271@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16262.53512.249701.158271@charged.uio.no>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:
> I can't tell as of yet whether or not the model chosen will include
> all the features of dnotify (for instance recall in case the
> attributes change on a subfile is a subject of hot debate), but
> certainly some of us are pushing for something like this.

Different types of delegation, depending on what the client asked for,
could be offered:

Cacheing readdir() and stat() on the directory requires delegation
without subfile recall; if there's a dnotify on the client, it
requires delegation with recall.

An uber-cool capability would be notification of sub-files to any
depth.  You can't imagine how tedious it has been watching a makefile
take 5 minutes _just_ to run the "find" command on a source tree to
find newer files than the last successful make.  (It was a big tree).
That was the optimised makefile.  Without the "find" command, make's
own dependency logic took 20 minutes to do the same thing.

With any depth notifications, that would be eliminated to roughly zero
time, and just running the few compile commands that are needed.

-- Jamie
