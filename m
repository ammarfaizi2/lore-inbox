Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263830AbTK2RDS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Nov 2003 12:03:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263821AbTK2RCq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Nov 2003 12:02:46 -0500
Received: from smtp8.wanadoo.fr ([193.252.22.23]:46752 "EHLO
	mwinf0803.wanadoo.fr") by vger.kernel.org with ESMTP
	id S263801AbTK2RBG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Nov 2003 12:01:06 -0500
Date: Sat, 29 Nov 2003 18:01:03 +0100
To: John Bradford <john@grabjohn.com>
Cc: Andries Brouwer <aebr@win.tue.nl>, Szakacsits Szabolcs <szaka@sienet.hu>,
       Apurva Mehta <apurva@gmx.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       bug-parted@gnu.org
Subject: Re: Disk Geometries reported incorrectly on 2.6.0-testX
Message-ID: <20031129170103.GA6092@iliana>
References: <20031128045854.GA1353@home.woodlands> <20031128142452.GA4737@win.tue.nl> <20031129022221.GA516@gnu.org> <Pine.LNX.4.58.0311290550190.21441@ua178d119.elisa.omakaista.fi> <20031129123451.GA5372@win.tue.nl> <200311291350.hATDo0CY001142@81-2-122-30.bradfords.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <200311291350.hATDo0CY001142@81-2-122-30.bradfords.org.uk>
User-Agent: Mutt/1.5.4i
From: Sven Luther <sven.luther@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 29, 2003 at 01:50:00PM +0000, John Bradford wrote:
> > Let me continue to stress: geometry does not exist.
> > Consequently, it cannot change.
> > fdisk does not set any geometry, it writes a partition table.
> > 
> > Start and size of each partition are given twice: in absolute sector
> > units (LBA) and in CHS units. The former uses 32 bits, and with 512-byte
> > sectors this works up to 2TB. People are starting to hit that boundary now.
> > The latter uses 24 bits, which works up to 8GB. Modern systems no longer
> > use it (but the details are complicated).
> 
> Why don't we take the opporunity to make all CHS code configurable out
> of the kernel, and define a new, more compact, partition table format
> which used LBA exclusively, and allowed more than four partitions in
> the main partition table?

The only problem is that your BIOS will probably not be able to boot
from it, so unless you use some kind of free bios implementation or even
some kind of free OF or something such, you will never be able to boot
from these drives.

For non booting drives, nothing stops you from using alternate partition
tables, the Mac OS on as well as the Amiga partition tables seems nice
to me (maybe others too, but i mostly know these two of the alternative
partition tables) as these are simply linked list of partition entries,
you can have as many as you want (limit to 128 partitions for amiga
partition in the libparted implementation i made for example).

Friendly,

Sven Luther
