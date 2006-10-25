Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750888AbWJ1Ewh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750888AbWJ1Ewh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 00:52:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751007AbWJ1Ewh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 00:52:37 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:5389 "EHLO spitz.ucw.cz")
	by vger.kernel.org with ESMTP id S1750888AbWJ1Ewg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 00:52:36 -0400
Date: Wed, 25 Oct 2006 16:51:17 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: rjw@sisk.pl, linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: swsusp initialized after SATA (was Re: swsusp APIC oopsen (was Re: swsusp ooms))
Message-ID: <20061025165117.GD5675@ucw.cz>
References: <200610132231.08643.rjw@sisk.pl> <20061013140000.329e8854.akpm@osdl.org> <200610132307.47162.rjw@sisk.pl> <20061014002504.1ab10ee9.akpm@osdl.org> <20061014004046.670ddd76.akpm@osdl.org> <20061014082237.GA3818@elf.ucw.cz> <20061014083227.GA3868@elf.ucw.cz> <20061014015109.0ff2c52f.akpm@osdl.org> <20061025104318.GA1743@elf.ucw.cz> <20061025084613.4776ef76.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061025084613.4776ef76.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > Sorry, I meant:
> > > > 
> > > > "sata is initialized *after* swsusp => bad".
> > > 
> > > Which patch made this change, and why?
> > 
> > CONFIG_PCI_MULTITHREAD_PROBE is the setting responsible, and IIRC
> > that's Greg's code.
> > 
> > Now... what is the recommended way to wait for hard disks to become
> > online?
> 
> The multithreaded probing is breaking (or at least altering) the initcall
> ordering guarantees.  We should wait for all the probing kernel threads to
> terminate after processing each initcall level.  

Can I read that as 'problem is bigger than swsusp, so someone else
(not Pavel :-) will solve it'?
							Pavel
-- 
Thanks for all the (sleeping) penguins.
