Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262303AbTLJJe4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 04:34:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262323AbTLJJe4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 04:34:56 -0500
Received: from kweetal.tue.nl ([131.155.3.6]:59652 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S262303AbTLJJes (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 04:34:48 -0500
Date: Wed, 10 Dec 2003 10:34:46 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: very large FAT16 partition not readable on 2.6.0-test11
Message-ID: <20031210093446.GB10321@win.tue.nl>
References: <20031209230333.GA1507@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031209230333.GA1507@kroah.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 09, 2003 at 03:03:33PM -0800, Greg KH wrote:

> I just bought a new USB/Firewire external drive.  It comes pre-formatted
> as FAT16 (or so shows fdisk) as one big 80Gb partition.  Unfortunately,
> Linux can't seem to mount this partition, and I get the following dmesg
> output when trying to mount the partition:
> 	FAT: bogus number of reserved sectors
> 	VFS: Can't find a valid FAT filesystem on dev sdb1.
> 
> Now before I blow it away and put a sane filesystem on this disk, I
> saved off the MBR and the initial portion of the partitions if anyone
> wants to poke around and take a look at it.  I'll keep the filesystem
> as-is for a few days if anyone wants me to get any more data from it.

Good.

* fat16_sdb1: this is all zeros. No filesystem at all, which explains
  why it won't mount.
* fat16_mbr: nothing wrong here

   Device Boot    Start       End   #sectors  Id  System
fat16_mbr1            63 156360644  156360582   6  FAT16
fat16_mbr2             0         -          0   0  Empty
fat16_mbr3             0         -          0   0  Empty
fat16_mbr4             0         -          0   0  Empty

* fat16_sdb:
There is a little bit of data here - don't know what it is.

Andries

