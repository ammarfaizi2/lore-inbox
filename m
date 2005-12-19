Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964795AbVLSQHV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964795AbVLSQHV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 11:07:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964796AbVLSQHV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 11:07:21 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:27356 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S964795AbVLSQHU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 11:07:20 -0500
Date: Mon, 19 Dec 2005 16:07:14 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Linus Torvalds <torvalds@osdl.org>, ralf@linux-mips.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mips: namespace pollution: dump_regs() -> elf_dump_regs()
Message-ID: <20051219160714.GI27946@ftp.linux.org.uk>
References: <20051216224047.GE27946@ftp.linux.org.uk> <Pine.LNX.4.64N.0512191159440.23348@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64N.0512191159440.23348@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 19, 2005 at 12:07:09PM +0000, Maciej W. Rozycki wrote:
> On Fri, 16 Dec 2005, Al Viro wrote:
> 
> > dump_regs() is used by a bunch of drivers for their internal stuff;
> > renamed mips instance (one that is seen in system-wide headers)
> > to elf_dump_regs()
> 
>  I guess drivers should be fixed not to use generic names in the first 
> place -> s/dump_regs/frobnicator_dump_regs/, etc.

No.  If nothing else, it's far less work to keep the headers reasonably
clean than to slap prefices on every damn static-in-file function
out there.  Leads to more readable code in drivers, too...
