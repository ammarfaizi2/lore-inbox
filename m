Return-Path: <linux-kernel-owner+w=401wt.eu-S1750696AbXAKPPM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750696AbXAKPPM (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 10:15:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750707AbXAKPPL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 10:15:11 -0500
Received: from dtp.xs4all.nl ([80.126.206.180]:36472 "HELO abra2.bitwizard.nl"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1750696AbXAKPPK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 10:15:10 -0500
Date: Thu, 11 Jan 2007 16:15:08 +0100
From: Erik Mouw <erik@harddisk-recovery.com>
To: Jacky Malcles <Jacky.Malcles@bull.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: can't cleanup /proc/swaps without rebooting ?
Message-ID: <20070111151508.GR13675@harddisk-recovery.com>
References: <45A650D2.90901@bull.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45A650D2.90901@bull.net>
Organization: Harddisk-recovery.com
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 11, 2007 at 03:59:30PM +0100, Jacky Malcles wrote:
> is there a way, other than rebooting, to clean up /proc/swaps ?
> 
> I'm in this situation (due to testing errors),
> # cat /proc/swaps
> Filename                                Type            Size    Used    
> Priority
> /dev/sdc1                               partition       2040064 0       -1
> /tmp/swaH4mvTI/swapfilenext\040(deleted) file           48960   0       -31
> /tmp/swa5TlBva/swapfilenext\040(deleted) file           49088   0       -118
> #
> # swapon -s
> Filename                                Type            Size    Used    
> Priority
> /dev/sdc1                               partition       2040064 0       -1
> /tmp/swaH4mvTI/swapfilenext\040(deleted) file           48960   0       -31
> /tmp/swa5TlBva/swapfilenext\040(deleted) file           49088   0       -118
> #

"swapoff /dev/sdc1" or "swapoff /tmp/swa5TlBva/swapfilenext". Don't
know if the latter works when the file is unlinked, just try.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
