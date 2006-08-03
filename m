Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932441AbWHCJfU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932441AbWHCJfU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 05:35:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932442AbWHCJfT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 05:35:19 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:18331 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S932441AbWHCJfT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 05:35:19 -0400
Date: Thu, 3 Aug 2006 11:32:13 +0200
To: Wil Reichert <wil.reichert@gmail.com>
Cc: Krzysztof Halasa <khc@pm.waw.pl>, Kyle Moffett <mrmacman_g4@mac.com>,
       Ian Stirling <ian.stirling@mauve.plus.com>,
       David Masover <ninja@slaphack.com>,
       David Lang <dlang@digitalinsight.com>,
       Nate Diller <nate.diller@gmail.com>,
       Adrian Ulrich <reiser4@blinkenlights.ch>,
       "Horst H. von Brand" <vonbrand@inf.utfsm.cl>, ipso@snappymail.ca,
       lkml@lpbproductions.com, Jeff Garzik <jeff@garzik.org>,
       "Theodore Ts'o" <tytso@mit.edu>,
       LKML Kernel <linux-kernel@vger.kernel.org>, reiserfs-list@namesys.com
Subject: Re: Solaris ZFS on Linux
Message-ID: <20060803093213.GA12071@aitel.hist.no>
References: <Pine.LNX.4.63.0607311651410.14674@qynat.qvtvafvgr.pbz> <5c49b0ed0607311705t1eb8fc6bs9a68a43059bfa91a@mail.gmail.com> <20060801010215.GA24946@merlin.emma.line.org> <44CEAEF4.9070100@slaphack.com> <Pine.LNX.4.63.0607312114500.15179@qynat.qvtvafvgr.pbz> <44CED95C.10709@slaphack.com> <44CFE8D9.9090606@mauve.plus.com> <0DA0B214-50BC-4E20-A520-B7AB121BB38B@mac.com> <m3ejvzqkjf.fsf@defiant.localdomain> <7a329d910608021920h6c1bb625q5336115cfd253adf@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a329d910608021920h6c1bb625q5336115cfd253adf@mail.gmail.com>
User-Agent: Mutt/1.5.12-2006-07-14
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 02, 2006 at 07:20:25PM -0700, Wil Reichert wrote:
> On 8/2/06, Krzysztof Halasa <khc@pm.waw.pl> wrote:
> >Kyle Moffett <mrmacman_g4@mac.com> writes:
> >
> >> IMHO the best alternative for a situation like that is a storage
> >> controller with a battery-backed cache and a hunk of flash NVRAM for
> >> when the power shuts off (just in case you run out of battery), as
> >> well as a separate 1GB battery-backed PCI ramdisk for an external
> >> journal device (likewise equipped with flash NVRAM).  It doesn't take
> >> much power at all to write a gig of stuff to a small flash chip
> >> (Think about your digital camera which runs off a couple AA's), so
> >> with a fair-sized on-board battery pack you could easily transfer its
> >> data to NVRAM and still have power left to back up data in RAM for 12
> >> hours or so.  That way bootup is fast (no reading 1GB of data from
> >> NVRAM) but there's no risk of data loss.
> >
> >Not sure - reading flash is fast, but writing is quite slow.
> >A digital camera can consume a set of 2 or 4 2500 mAh AA cells
> >for a fraction of 1 GB (of course, only a part of power goes
> >to flash).
> 
> Seeks are fast, throughput is terrible, power is minimal:
> 
> http://techreport.com/reviews/2006q3/supertalent-flashide/index.x?pg=1
> 
That particular flash drive had terrible througput.

But there are other alternatives.  I use a kingston 4GB 
compactflash card as a disk, and it reads 22MB/s, according to
specs and tests with hdparm.  And it writes 16MB/s.  

Much better than the sorry thing in that test, about the same
read speed as their worst platter-based harddisk.  And of course it still have
the nice seek times of non-rotating media. :-)

Helge Hafting

