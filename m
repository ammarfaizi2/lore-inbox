Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131300AbRDFGCb>; Fri, 6 Apr 2001 02:02:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131304AbRDFGCV>; Fri, 6 Apr 2001 02:02:21 -0400
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:3333
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S131300AbRDFGCJ>; Fri, 6 Apr 2001 02:02:09 -0400
Date: Thu, 5 Apr 2001 23:00:09 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Willy Tarreau <wtarreau@free.fr>
cc: "Robert A. Morris" <ramorris@dilithium.net>, linux-kernel@vger.kernel.org
Subject: Re: 2.2.19 + ide 2.2.19 03252001 patch problem
In-Reply-To: <986536241.3acd59318b222@imp.free.fr>
Message-ID: <Pine.LNX.4.10.10104052257130.2280-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Apr 2001, Willy Tarreau wrote:

> Quoting "Robert A. Morris" <ramorris@dilithium.net>:
> [snip]
> > Apr  5 18:15:14 ryoko kernel: hdb: task_no_data_intr: status=0x51 {
> > DriveReady SeekComplete Error }
> > Apr  5 18:15:14 ryoko kernel: hdb: task_no_data_intr: error=0x04 {
> > DriveStatusError }
> > Apr  5 18:15:14 ryoko kernel: hdb: Write Cache FAILED Flushing!

Oh well forgot to parse bits for older drives..........drat!

> [snip]
> > This did NOT happen with 2.2.18 and the corresponding 
> > ide.2.2.18.1209.patch.  It does NOT seem to happen on
> > /dev/hda or /dev/hdc, which is lucky, since /dev/hdb
> > is unused.  I'm using lilo.conf to specify idebus=33.
> [snip] 
> > The controller is a VIA 82C686A (Asus K7V mainboard).

This is a problem the old via-code did "82C686A" fine but knew nothing
about "82C686B" and the new code does not do well with "82C686A" but good
with "82C686B".

> > hda: WDC WD307AA, 29333MB w/2048kB Cache, CHS=3739/255/63, UDMA(66)
> > hdb: WDC AC28400R, 8063MB w/512kB Cache, CHS=1027/255/63, (U)DMA

Why are we mixing drives this class?

> > hdc: WDC WD307AA-00BAA0, 29333MB w/2048kB Cache, CHS=59598/16/63,
> > UDMA(66)
> 
> same problem observed here on same motherboard. The hard disk is a WDC AC23200L
> configured as hda. I have tested several ide/kernel combinations and all I can
> say is that 2.2.18 and 2.2.19 behave the same, but it worked till
> ide.2.2.18.1221 included, and the bug appeared since ide.2.2.18.02122001.
> I tried with and without vojtech's via patches (3.2, 4.2 and 4.3), but this
> didn't change anything (to be honest, some combinations were obviously not made
> to live together, and I had so many problems fitting all patches in one kernel
> that it sometimes even didn't boot).
> 
> I can also say that this problem didn't show up on other chipsets (ali and
> intel) with the same kernel+ide patch.
> 
> finally, I made my kernel with ide.2.2.18.1221 and all seems to be OK (one week
> now). The diffs between the 2 versions were too important and I have not
> investigated further into this, but I'm ready to make some tests if needed.
> 
> Regards,
> Willy
> 
> PS: BTW Andre, could you please name your patches ide-2.2.19-YYYYMMDD so that a
>     directory listing show the chronological order ?
> 

Andre Hedrick
Linux ATA Development
ASL Kernel Development
-----------------------------------------------------------------------------
ASL, Inc.                                     Toll free: 1-877-ASL-3535
1757 Houret Court                             Fax: 1-408-941-2071
Milpitas, CA 95035                            Web: www.aslab.com

