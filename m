Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262373AbTLJMtr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 07:49:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262765AbTLJMtr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 07:49:47 -0500
Received: from users.linvision.com ([62.58.92.114]:22488 "HELO bitwizard.nl")
	by vger.kernel.org with SMTP id S262373AbTLJMtq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 07:49:46 -0500
Date: Wed, 10 Dec 2003 13:49:44 +0100
From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: very large FAT16 partition not readable on 2.6.0-test11
Message-ID: <20031210124944.GA25182@bitwizard.nl>
References: <20031209230333.GA1507@kroah.com> <20031210093446.GB10321@win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031210093446.GB10321@win.tue.nl>
User-Agent: Mutt/1.3.28i
Organization: BitWizard.nl
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

May I make a programming style suggestion? When you find a parameter
out-of-range, don't just print that it's out of range, but print the
actual value as well. This message would have become:

	FAT: Number of reserved sectors (0) out of range. 

Even better would be to print the range as well:

	FAT: Number of reserved sectors (0) out of range (1..16). 

(I just made the number up, I haven't looked in the code what the
valid range actually is...).


		Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
**** "Linux is like a wigwam -  no windows, no gates, apache inside!" ****
