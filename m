Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264373AbTLKHIm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 02:08:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264376AbTLKHIm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 02:08:42 -0500
Received: from mail.kroah.org ([65.200.24.183]:63941 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264373AbTLKHIf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 02:08:35 -0500
Date: Wed, 10 Dec 2003 22:49:19 -0800
From: Greg KH <greg@kroah.com>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: very large FAT16 partition not readable on 2.6.0-test11
Message-ID: <20031211064918.GD2529@kroah.com>
References: <20031209230333.GA1507@kroah.com> <20031210093446.GB10321@win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031210093446.GB10321@win.tue.nl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 10, 2003 at 10:34:46AM +0100, Andries Brouwer wrote:
> On Tue, Dec 09, 2003 at 03:03:33PM -0800, Greg KH wrote:
> 
> > I just bought a new USB/Firewire external drive.  It comes pre-formatted
> > as FAT16 (or so shows fdisk) as one big 80Gb partition.  Unfortunately,
> > Linux can't seem to mount this partition, and I get the following dmesg
> > output when trying to mount the partition:
> > 	FAT: bogus number of reserved sectors
> > 	VFS: Can't find a valid FAT filesystem on dev sdb1.
> > 
> > Now before I blow it away and put a sane filesystem on this disk, I
> > saved off the MBR and the initial portion of the partitions if anyone
> > wants to poke around and take a look at it.  I'll keep the filesystem
> > as-is for a few days if anyone wants me to get any more data from it.
> 
> Good.
> 
> * fat16_sdb1: this is all zeros. No filesystem at all, which explains
>   why it won't mount.

Ok, you're right.  It can't mount on a Windows box either.  Seems to
need to be formatted for any os that uses it.  So I've just put ext3 on
it and it runs just fine for me.

Sorry for the disruption, and thanks for looking into it.

greg k-h
