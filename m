Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261465AbVB0TGe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261465AbVB0TGe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 14:06:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261470AbVB0TGe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 14:06:34 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:39152 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261465AbVB0TGc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 14:06:32 -0500
From: Parag Warudkar <kernel-stuff@comcast.net>
To: Jean-Marc Valin <Jean-Marc.Valin@usherbrooke.ca>
Subject: Re: ext3 bug
Date: Sun, 27 Feb 2005 14:06:30 -0500
User-Agent: KMail/1.7.92
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
References: <1109487896.8360.16.camel@localhost>
In-Reply-To: <1109487896.8360.16.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502271406.30690.kernel-stuff@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 27 February 2005 02:04 am, Jean-Marc Valin wrote:
> Hi,
>
> Looks like I ran into an ext3 bug (or at least the log says so). I got a
> bunch of messages like:
> ext3_free_blocks_sb: aborting transaction: Journal has aborted in
> __ext3_journal_get_undo_access<2>EXT3-fs error (device sda2) in
> ext3_free_blocks_sb: Journal has aborted
> EXT3-fs error (device sda2): ext3_free_blocks: Freeing blocks in system
> zones -Block = 228, count = 1
>
> It happened while I was doing an "rm -rf" on a directory. The "rm" gave
> a segfault and now I can't unmount the filesystem: unmount says "device
> is busy", even though lsof reports nothing. The filesystem is on a USB
> hard disk. The actual dump is in attachment. I'm running Debian unstable
> with a custom 2.6.10 kernel on a 1.6 GHz Pentium-M.
>
> 	Jean-Marc

Please try stock kernel. 2.6.11-rc3 onwards should be fine. - I saw a similar 
problem while running 2.6.10 kernel from Fedora Core 3. It doesn't happen 
with stock kernels.

Parag
