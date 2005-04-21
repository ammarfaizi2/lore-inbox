Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261553AbVDURS2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261553AbVDURS2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 13:18:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261555AbVDURS2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 13:18:28 -0400
Received: from waste.org ([216.27.176.166]:24524 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261553AbVDURSY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 13:18:24 -0400
Date: Thu, 21 Apr 2005 10:18:24 -0700
From: Matt Mackall <mpm@selenic.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Mercurial distributed SCM v0.2
Message-ID: <20050421171824.GK21897@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is my continuing attempt to make an SCM suitable for kernel
hacking. It supports a distribution model similar to BK and Monotone
but is orders of magnitude simpler than both (about 1k lines of code).

 http://selenic.com/mercurial/

New in this version: 

- much improved command line tool
- installation instructions
- commit log editing
- experimental network pull support

Some example usage:

Setting up a Mercurial project:

 $ cd linux/
 $ hg init         # creates .hg
 $ hg status       # show differences between repo and working dir
 $ hg addremove    # add all unknown files and remove all missing files
 $ hg commit       # commit all changes, edit changelog entry

Mercurial commands:

 $ hg history      # show changesets
 $ hg log Makefile # show commits per file
 $ hg checkout     # check out the tip revision
 $ hg checkout <hash> # check out a specified changeset
 $ hg add foo      # add a new file for the next commit
 $ hg remove bar   # mark a file as removed

Branching and merging:

 $ cd ..
 $ cp -al linux linux-work   # create a new hardlink branch
 $ cd linux-work
 $ <make changes>
 $ hg commit
 $ cd ../linux
 $ hg merge ../linux-work    # pull changesets from linux-work

Network support (highly experimental):

 # export your .hg directory as a directory on your webserver
 foo$ ln -s .hg ~/public_html/hg-linux 

 # merge changes from a remote machine
 bar$ hg merge http://foo/~user/hg-linux

 This is just a proof of concept of grabbing byte ranges, and is not
 expected to perform well yet.

-- 
Mathematics is the supreme nostalgia of our time.
