Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270951AbTGPQwa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 12:52:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270952AbTGPQwa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 12:52:30 -0400
Received: from ip67-95-245-82.z245-95-67.customer.algx.net ([67.95.245.82]:54023
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S270951AbTGPQw3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 12:52:29 -0400
Date: Wed, 16 Jul 2003 10:07:20 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Peter Chubb <peter@chubb.wattle.id.au>
Cc: Andries Brouwer <aebr@win.tue.nl>, Jeff Garzik <jgarzik@pobox.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Dave Jones <davej@codemonkey.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5 'what to expect'
Message-ID: <20030716170720.GC2681@matchmail.com>
Mail-Followup-To: Peter Chubb <peter@chubb.wattle.id.au>,
	Andries Brouwer <aebr@win.tue.nl>, Jeff Garzik <jgarzik@pobox.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Dave Jones <davej@codemonkey.org.uk>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030711155613.GC2210@gtf.org> <20030711203850.GB20970@win.tue.nl> <20030715000331.GB904@matchmail.com> <20030715170804.GA1089@win.tue.nl> <16148.53643.475710.301248@wombat.chubb.wattle.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16148.53643.475710.301248@wombat.chubb.wattle.id.au>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 16, 2003 at 02:16:11PM +1000, Peter Chubb wrote:
> >>>>> "Andries" == Andries Brouwer <aebr@win.tue.nl> writes:
> 
> Andries> On Mon, Jul 14, 2003 at 05:03:31PM -0700, Mike Fedyk wrote:
> >> So, will the DOS partition make it up to 2TB?  If so, then we won't
> >> have a problem until we have larger than 2TB drives
> 
> Andries> Yes, DOS partition table works up to 2^32 sectors, and with
> Andries> 2^9-byte sectors that is 2 TiB.
> 
> Andries> People are encountering that limit already. We need something
> Andries> better, either use some existing scheme, or invent something.
> 
> We had this discussion before, back when I first submitted the large
> block device patches.  The consensus then was to use EFI, or LDM.
> 
> Unless the BIOS supports a partitioning scheme, you're not
> going to be able to boot anyway, or at least not without doing
> something clever.

The bios shouldn't even know about partition tables.  It just loads the code
in the MBR, and the boot loader deals with the rest from there.

How else would BSD be able to work with their non-DOS slices anyway?
