Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263711AbUDYXRO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263711AbUDYXRO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Apr 2004 19:17:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263713AbUDYXRO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Apr 2004 19:17:14 -0400
Received: from mail1.mail.iol.ie ([193.120.142.151]:46547 "EHLO
	mail1.mail.iol.ie") by vger.kernel.org with ESMTP id S263711AbUDYXRM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Apr 2004 19:17:12 -0400
Date: Mon, 26 Apr 2004 00:17:09 +0100
From: Kenn Humborg <kenn@linux.ie>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Platform device matching
Message-ID: <20040425231709.GA29153@excalibur.research.wombat.ie>
References: <20040425220511.GA20808@excalibur.research.wombat.ie> <20040426000050.F13748@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040426000050.F13748@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 26, 2004 at 12:00:50AM +0100, Russell King wrote:
> On Sun, Apr 25, 2004 at 11:05:11PM +0100, Kenn Humborg wrote:
> > I'm looking at the code for binding platform devices with drivers.  
> > However, platform_match() doesn't seem to agree with its kerneldoc
> > comment:
> 
> The code is correct as stands.  The documentation is behind times.  All
> platform devices are "<name><instance-number>" so it's correct that the
> "floppy" driver matches "floppy0" and "floppy1" etc.

Forgive me if I am being dense, but I still don't see how that works.  

The current code:

   return (strncmp(pdev->name, drv->name, BUS_ID_SIZE) == 0);

will only return 1 if pdev->name and drv->name are _identical_ for the 
first 20 bytes.  Which "floppy" and "floppy0" are not.

Could it be that all current platform devices are initially named
as "<name>" and the instance number is only appended after matching
has been done?

Later,
Kenn


