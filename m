Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261369AbSJQKUm>; Thu, 17 Oct 2002 06:20:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261370AbSJQKUm>; Thu, 17 Oct 2002 06:20:42 -0400
Received: from kweetal.tue.nl ([131.155.2.7]:59406 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id <S261369AbSJQKUl>;
	Thu, 17 Oct 2002 06:20:41 -0400
Date: Thu, 17 Oct 2002 12:26:14 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: James Finnie <jf1@imerge.co.uk>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'andre@linux-ide.org'" <andre@linux-ide.org>
Subject: Re: [PATCH]:  Sanity checking for drives that claim to be LBA-48, but aren't!
Message-ID: <20021017102614.GA24939@win.tue.nl>
References: <C0D45ABB3F45D5118BBC00508BC292DB9D4264@imgserv04>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C0D45ABB3F45D5118BBC00508BC292DB9D4264@imgserv04>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2002 at 10:02:00AM +0100, James Finnie wrote:

> Upon investigation of this with Seagate, it turns out that the firmware
> version in question is for CE (consumer electronics) use.  They have used
> bit 10 of word 86 (0x56) of the IDENTIFY DEVICE information to indicate some
> feature in their "AV streaming data transfer set".  This breaks ATA-7, which
> says this bit indicates that the drive understands LBA-48 commands.  
> 
> The kernel sees this bit set, tries to use LBA-48 commands, and the drive
> errors, complaining that it doesn't understand!  Meaning this drive is
> unusable with the >=2.4.19 kernels.  I think at least one other person has
> reported something very similar, IIRC with a very old Maxtor IDE drive.

Could you post the identify data for your disks? (cat /proc/ide/*/identify)

Andries
