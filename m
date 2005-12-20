Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750981AbVLTMQL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750981AbVLTMQL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 07:16:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750982AbVLTMQL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 07:16:11 -0500
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:6163 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP
	id S1750973AbVLTMQK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 07:16:10 -0500
Date: Tue, 20 Dec 2005 12:16:04 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Linus Torvalds <torvalds@osdl.org>, ralf@linux-mips.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mips: namespace pollution: dump_regs() -> elf_dump_regs()
In-Reply-To: <20051219160714.GI27946@ftp.linux.org.uk>
Message-ID: <Pine.LNX.4.64N.0512201205130.25567@blysk.ds.pg.gda.pl>
References: <20051216224047.GE27946@ftp.linux.org.uk>
 <Pine.LNX.4.64N.0512191159440.23348@blysk.ds.pg.gda.pl>
 <20051219160714.GI27946@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Dec 2005, Al Viro wrote:

> >  I guess drivers should be fixed not to use generic names in the first 
> > place -> s/dump_regs/frobnicator_dump_regs/, etc.
> 
> No.  If nothing else, it's far less work to keep the headers reasonably
> clean than to slap prefices on every damn static-in-file function

 That's the duty of the respective maintainers.  You don't expect one to 
have a private printk() (or whatever -- pick your favourite) function in a 
driver and demand the global one to be renamed so that their own one keeps 
working.

> out there.  Leads to more readable code in drivers, too...

 Well, that's just a reason to keep namespace prefixes short...

  Maciej
