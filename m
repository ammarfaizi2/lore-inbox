Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272015AbRH2Qpu>; Wed, 29 Aug 2001 12:45:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272014AbRH2Qpl>; Wed, 29 Aug 2001 12:45:41 -0400
Received: from archive.osdlab.org ([65.201.151.11]:17388 "EHLO fire.osdlab.org")
	by vger.kernel.org with ESMTP id <S272010AbRH2Qp2>;
	Wed, 29 Aug 2001 12:45:28 -0400
Message-ID: <3B8D1ABF.4ED398DA@osdlab.org>
Date: Wed, 29 Aug 2001 09:39:27 -0700
From: "Randy.Dunlap" <rddunlap@osdlab.org>
Organization: OSDL
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-20mdk i686)
X-Accept-Language: en
MIME-Version: 1.0
To: habanero@us.ibm.com
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: Journal FS Comparison on IOzone (was Netbench)
In-Reply-To: <3B8A6122.3C784F2D@us.ibm.com> <3B8A9070.AD43D0E7@osdlab.org> <200108271929.OAA23048@popmail.austin.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrew Theurer wrote:
> 
> On Monday 27 August 2001 01:24 pm, Randy.Dunlap wrote:
> > Hi,
> >
> > I am doing some similar FS comparisons, but using IOzone
> > (www.iozone.org) instead of Netbench.
> >
> > Some preliminary (mostly raw) data are available at:
> > http://www.osdlab.org/reports/journal_fs/
> > (updated today).
> >
> > I am using a Linux 2.4.7 on a 4-way VA Linux system.
> > It has 4 GB of RAM, but I have limited it to 256 MB in
> > accordance with IOzone run rules.
> >
> > However, I suspect that this causes IOzone to measure disk
> > subsystem or PCI bus performance more than it does FS performance.
> > Any comments on this?
> 
> Randy,
> 
> You are definitly exceeding what the kernel will cache and writing to disk on
> some tests.  I guess it depends on what is more important to you.  I think
> both are valid things to test, and you may want to try not limiting memory to
> get just FS performace in memory for large files.  However, writing to disk
> is important, especially for things like bounce-buffer.  Did you have himem
> support in your kernel?  If so, did you have a bounce-buffer elimination
> patch as well?

Hi-

Sorry about the delay in responding.

I'm interested in filesystem performance.  I'm not trying to
document IDE vs. SCSI vs. FC performance/price tradeoffs, benefits,
etc.

> Does the storage system/controller have a disk cache?  What size?

Good questions, but I'm having trouble finding answers for them.
(hence the delay in responding)

The FC host controller is a QLogic 2200.  It is attached to an
IBM FAStT controller/drive array -- one controller with 10
attached drives.  I've been looking at the IBM FAStT OS console
interface, but I can't see much cache info there.
There is one item:  cache/processor sizes: 88/40 MB

> Also, does IOzone default to num procs=num cpus?  I didn't see any options in
> your cmdline for num_procs.

No, IOzone doesn't default to num_processes = num_cpus.
That's a command-line option that I didn't use, although I expect
to do some testing with that option also.

Thanks for your comments.

~Randy
