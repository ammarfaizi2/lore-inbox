Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261224AbUBYKUB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 05:20:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261237AbUBYKT5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 05:19:57 -0500
Received: from kweetal.tue.nl ([131.155.3.6]:59409 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S261235AbUBYKTt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 05:19:49 -0500
Date: Wed, 25 Feb 2004 11:19:44 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Matthew Wilcox <willy@debian.org>
Cc: "Steven J. Hill" <sjhill@realitydiluted.com>,
       Jeremy Higdon <jeremy@sgi.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] 2.6.2, Partition support for SCSI CDROM...
Message-ID: <20040225101944.GB3832@pclin040.win.tue.nl>
References: <40396134.6030906@realitydiluted.com> <20040222190047.01f6f024.akpm@osdl.org> <40396E8F.4050307@realitydiluted.com> <20040224061130.GC503530@sgi.com> <403B8108.6080606@realitydiluted.com> <20040224170906.GQ25779@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040224170906.GQ25779@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
X-Spam-DCC: neonova: kweetal.tue.nl 1127; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 24, 2004 at 05:09:06PM +0000, Matthew Wilcox wrote:
> On Tue, Feb 24, 2004 at 11:51:20AM -0500, Steven J. Hill wrote:

> > + *    sr0 - first CDROM, whole disk
> > + *    sr1 - first CDROM, first partition
> > + *
> > + *    [...]
> > + *
> > + *    sr16 - first CDROM, sixteenth partition
> > + *    sr17 - second CDROM, whole disk
> > + *    sr18 - second CDROM, first partition
> 
> Umm... no.  I suspect you mean:
> 
> sr15 - first CDROM, fifteenth partition
> sr16 - second CDROM, whole disk
> sr17 - second CDROM, first partition
> 
> But what a bad idea for device names.  Why not
> 
> sr0 whole disc
> sr0a ... sr0o partitions
> sr1, sr1a ... sr1o
> 
> It's probably too late to be consistent with discs and call them
> sra, sra1, ... sra15
> srb, srb1, ... srb15

It is standard convention to use numerical suffixes to refer
to partitions, with a 'p' separator in case the full device
has a name ending in a digit.

So: sr0p1, ..., sr0p15, sr1p1, ...

Andries
