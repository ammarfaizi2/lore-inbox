Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750717AbWGFUFL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750717AbWGFUFL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 16:05:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750735AbWGFUFL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 16:05:11 -0400
Received: from sccrmhc14.comcast.net ([204.127.200.84]:6904 "EHLO
	sccrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S1750717AbWGFUFK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 16:05:10 -0400
Date: Thu, 6 Jul 2006 16:02:30 -0400
From: Tom Vier <tmv@comcast.net>
To: Valerie Henson <val_henson@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Helge Hafting <helgehaf@aitel.hist.no>,
       Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
       "Theodore Ts'o" <tytso@mit.edu>, Andrew Morton <akpm@osdl.org>
Subject: Re: Blatant layering violations (was Re: ext4 features)
Message-ID: <20060706200230.GC27533@zero>
Reply-To: Tom Vier <tmv@comcast.net>
References: <20060701163301.GB24570@cip.informatik.uni-erlangen.de> <20060701170729.GB8763@irc.pl> <20060701174716.GC24570@cip.informatik.uni-erlangen.de> <20060701181702.GC8763@irc.pl> <20060703202219.GA9707@aitel.hist.no> <20060703205523.GA17122@irc.pl> <20060706003638.GL5231@goober>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060706003638.GL5231@goober>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 05, 2006 at 05:36:39PM -0700, Valerie Henson wrote:
> On Mon, Jul 03, 2006 at 10:55:23PM +0200, Tomasz Torcz wrote:
> > 
> >   ZFS was already called ,,blatant layering violation''. ;)

It buys you some preformance. Someone here already mentioned variable stripe
sizes. ZFS doesn't just add a checksum sector after each block (something
i've been planning to write an md module for, for a couple years). It writes
the checksum at the end of the tree member, inode, dirent, whatever. So
there's no read-modify-write when you write < 1 checksum block size.

One thing i noticed about zfs that surprised me: it's using indirect blocks,
from what i saw.

-- 
Tom Vier <tmv@comcast.net>
DSA Key ID 0x15741ECE
