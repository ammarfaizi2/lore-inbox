Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261476AbVB0T2H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261476AbVB0T2H (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 14:28:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261477AbVB0T2G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 14:28:06 -0500
Received: from mx1.redhat.com ([66.187.233.31]:26002 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261476AbVB0T2C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 14:28:02 -0500
Date: Sun, 27 Feb 2005 14:27:55 -0500
From: Dave Jones <davej@redhat.com>
To: Parag Warudkar <kernel-stuff@comcast.net>
Cc: Jean-Marc Valin <Jean-Marc.Valin@usherbrooke.ca>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: ext3 bug
Message-ID: <20050227192755.GA844@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Parag Warudkar <kernel-stuff@comcast.net>,
	Jean-Marc Valin <Jean-Marc.Valin@usherbrooke.ca>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <1109487896.8360.16.camel@localhost> <200502271406.30690.kernel-stuff@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200502271406.30690.kernel-stuff@comcast.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 27, 2005 at 02:06:30PM -0500, Parag Warudkar wrote:
 > On Sunday 27 February 2005 02:04 am, Jean-Marc Valin wrote:
 > > Hi,
 > >
 > > Looks like I ran into an ext3 bug (or at least the log says so). I got a
 > > bunch of messages like:
 > > ext3_free_blocks_sb: aborting transaction: Journal has aborted in
 > > __ext3_journal_get_undo_access<2>EXT3-fs error (device sda2) in
 > > ext3_free_blocks_sb: Journal has aborted
 > > EXT3-fs error (device sda2): ext3_free_blocks: Freeing blocks in system
 > > zones -Block = 228, count = 1
 > >
 > > It happened while I was doing an "rm -rf" on a directory. The "rm" gave
 > > a segfault and now I can't unmount the filesystem: unmount says "device
 > > is busy", even though lsof reports nothing. The filesystem is on a USB
 > > hard disk. The actual dump is in attachment. I'm running Debian unstable
 > > with a custom 2.6.10 kernel on a 1.6 GHz Pentium-M.
 > >
 > > 	Jean-Marc
 > 
 > Please try stock kernel. 2.6.11-rc3 onwards should be fine. - I saw a similar 
 > problem while running 2.6.10 kernel from Fedora Core 3. It doesn't happen 
 > with stock kernels.

Which is very odd considering the only ext3 patches in the Fedora
kernel are in 2.6.11rc.

		Dave

