Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263636AbTL2Pc7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 10:32:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263637AbTL2Pc7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 10:32:59 -0500
Received: from www.jubileegroup.co.uk ([212.22.195.7]:6026 "EHLO
	www2.jubileegroup.co.uk") by vger.kernel.org with ESMTP
	id S263636AbTL2Pc6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 10:32:58 -0500
Date: Mon, 29 Dec 2003 15:32:54 +0000 (GMT)
From: Ged Haywood <ged@www2.jubileegroup.co.uk>
To: linux-kernel@vger.kernel.org
Subject: Re: All filesystems hang under long periods of heavy load (read and
 write) on a filesystem
In-Reply-To: <Pine.LNX.4.21.0312231544250.20325-100000@www2.jubileegroup.co.uk>
Message-ID: <Pine.LNX.4.21.0312291516140.10965-100000@www2.jubileegroup.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello again all,

On Tue, 23 Dec 2003, Ged Haywood wrote:
[snip,snip]
> On Tue, 04 Nov 2003 Randy Dunlap wrote:
> > 
> > Can you try a recent kernel, like 2.4.23-pre8 or -pre9?
> 
> Copying large files from the smaller IDE drive to the larger trashed
> the filesystem on the partition being written to.

It seems that this boils down to using PIO mode, after enabling DMA I am
able to write 1.7G files with no trouble - of course it's early days yet,
the fault might not be fixed, it might just be less obvious...

Enabling DMA hadn't been top priority until I spoke to the 'hdparm'
maintainer at Debian.  The driver for the CMD Technology Inc CMD680 is
cunningly hidden under "Silicon Image chipset support" in the 2.4.23
config menus but was fairly easy to find once I started digging.  :)

Apparently the problem might still be present in 2.6.0 - see for example

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/must-fix/should-fix-7.txt

Anyway I'm thinking I'll put together an identical machine in the next
few weeks so I'll be able to reproduce the fault at will.  Would anyone
be interested in playing with it?

73,
Ged.

PS: Not subscribed, please CC me if you're interested.

PPS: Keeping the same subject line, but maybe this deserves a new one?

