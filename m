Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268760AbUIXPWi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268760AbUIXPWi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 11:22:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268834AbUIXPUY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 11:20:24 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:15759 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268836AbUIXPS3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 11:18:29 -0400
Date: Fri, 24 Sep 2004 16:18:28 +0100
From: Matthew Wilcox <matthew@wil.cx>
To: David Wysochanski <davidw@netapp.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: reiserfs and SCSI oops seen in 2.6.9-rc2 with local SCSI disk IO
Message-ID: <20040924151828.GC16153@parcelfarce.linux.theplanet.co.uk>
References: <4154372C.7070506@netapp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4154372C.7070506@netapp.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 24, 2004 at 11:03:08AM -0400, David Wysochanski wrote:
> I can reproduce this pretty easily with local disk.
> 
> Here's some details about my setup (attached is the
> full kernel config):
> - dell 2650 (dual xeon, hyperthreading disabled)
> - 1 local SCSI disk (root volume)
> - 2 local SCSI disks (data), each with 10 partitions
> of 100MB each, 6 of them reiserfs filesystems, 3 of them
> ext3, and 3 of them ext2 (total of 20 unique filesystems)
> - one instance of test program running on each of the
> 20 filesystems

I don't think this is a SCSI problem.  Your backtrace doesn't include
anything in the SCSI subsystem (this doesn't _prove_ anything, but does
suggest you should look elsewhere first).  You also didn't mention what
SCSI controller you were using.  If you can reproduce the oops without
using reiserfs at all, that would suggest the problem doesn't lie in
reiserfs, but that's where I'd blame first ;-)

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
