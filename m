Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263778AbTLJRkW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 12:40:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263784AbTLJRkW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 12:40:22 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:59131 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S263778AbTLJRkU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 12:40:20 -0500
Subject: Re: 2.4.23 + Preempt, JFS Corruption.
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Joshua Schmidlkofer <joshua@imr-net.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1071005675.32237.97.camel@bubbles.imr-net.com>
References: <1071005675.32237.97.camel@bubbles.imr-net.com>
Content-Type: text/plain
Message-Id: <1071078012.2277.50.camel@shaggy.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 10 Dec 2003 11:40:12 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-12-09 at 15:34, Joshua Schmidlkofer wrote:
> Howdy,
> 
>    We are migrating from ext3 to jfs and had a weird error.  We have a
> dual pentium III 1.4 ghz system.  We have 4GB of ram, and a Mylex
> AcceleRAID 170 [DAC960] controller. Intel pro/100 nics, nothing else too
> special.  The motherboard chipset is ServerWorks.  We added a 40GB ide
> drive to the onboard controller.  It has jfs on it, and we are using
> this for the migration.  We have been backing up to it for a few days,
> and it went read-only on us.  
> 
>   I have dtree page corrupt errors, but no hardware errors.  jfs fsck
> errors out as well.

jfs_fsck reports the errors, but is running read-only.  Did you run it
with "-n"?  In read-write mode, it should "fix" the problem (by removing
the corrupt directory and placing its contents in lost+found).

I've seen a few scattered reports of corrupted directories lately, so
there may be a race in the JFS code that I haven't found yet.  I'd be
interested if anyone has found a reproducible way of causing any JFS
corruption.

Thanks,
Shaggy
-- 
David Kleikamp
IBM Linux Technology Center

