Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263809AbTEFPUn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 11:20:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263810AbTEFPUm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 11:20:42 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:35981 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S263809AbTEFPUW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 11:20:22 -0400
Date: Tue, 6 May 2003 17:32:52 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Marcus Meissner <meissner@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Only use MSDOS-Partitions by default on X86
Message-ID: <20030506153252.GA13830@wohnheim.fh-wedel.de>
References: <20030505210811.GC7049@wohnheim.fh-wedel.de.suse.lists.linux.kernel> <1052218090.28792.15.camel@dhcp22.swansea.linux.org.uk.suse.lists.linux.kernel> <20030506120939.GB15261@wohnheim.fh-wedel.de.suse.lists.linux.kernel> <20030506122844.95332D872@Hermes.suse.de> <20030506124212.GE15261@wohnheim.fh-wedel.de> <20030506150318.C21775@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030506150318.C21775@flint.arm.linux.org.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 May 2003 15:03:18 +0100, Russell King wrote:
> On Tue, May 06, 2003 at 02:42:12PM +0200, Jörn Engel wrote:
> > On Tue, 6 May 2003 14:28:44 +0200, Marcus Meissner wrote:
> > > 
> > > Every platform that supports USB will be able to read USB Storage
> > > Devices which almost everytime have FAT filesystems with MSDOS partitions.
> > > 
> > > So short of S/390 you get like every platform.
> > 
> > And short of most embedded systems.
> 
> CF cards - these have MSDOS partition tables on.  CF cards get used on
> embedded systems.
> 
> Therefore, it follows that if you have an embedded system with a CF socket,
> you'll probably want the MSDOS partitioning enabled.

Maybe I was just thinking the wrong way. Given that my systems don't
use IDE, SCSI, a floppy or anything emulating one of them, like USB
storage or CF. I don't want MSDOS partitioning, but in fact, I don't
want any of the disk-centric code at all, fs/partitions is just a part
of that.

Then the real fix would be to have (no disk stuff) => (some magic) =>
(no MSDOS partitions,...).

My proposition for (some magic) would be to add an option for having
disks (or floppies, emulating stuff, yadda, yadda...) and have some
things like partitioning depend on that option. I better sharpen my
claymore to cut through all that code then.

Jörn

-- 
Fancy algorithms are buggier than simple ones, and they're much harder
to implement. Use simple algorithms as well as simple data structures.
-- Rob Pike
