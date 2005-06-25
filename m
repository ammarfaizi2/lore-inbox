Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261375AbVFYWhY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261375AbVFYWhY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Jun 2005 18:37:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261378AbVFYWhY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Jun 2005 18:37:24 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:20372 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261375AbVFYWhS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Jun 2005 18:37:18 -0400
Date: Sun, 26 Jun 2005 00:37:15 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Christoph Lameter <christoph@lameter.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, raybry@engr.sgi.com,
       torvalds@osdl.org
Subject: Re: [RFC] Fix SMP brokenness for PF_FREEZE and make freezing usable for other purposes
Message-ID: <20050625223715.GA11438@atrey.karlin.mff.cuni.cz>
References: <Pine.LNX.4.62.0506241316370.30503@graphe.net> <20050625025122.GC22393@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.62.0506242127040.3433@graphe.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0506242127040.3433@graphe.net>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
> > > I only know that this boots correctly since I have no system that can do 
> > > suspend. But Ray needs an effective means of process suspension for 
> > > his process migration patches.
> > 
> > Any i386 or x86-64 machine can do suspend... It should be easy to get
> > some notebook... [What kind of hardware are you working on normally?]
> 
> Umm... Sorry to be so negative but that has never worked for me on lots of 
> laptops. Usually something with ACPI or some driver I guess... After 
> awhile I gave up trying.

You should be able to do acpi=off if it gives you a problem. Going
with minimal drivers help, too...

> > Previous code had important property: try_to_freeze was optimized away
> > in !CONFIG_PM case. Please keep that.
> 
> Obviously that will not work if we use try_to_freeze for 
> non-power-management purposes. The code from kernel/power/process.c may 
> have to be merged into some other kernel file. kernel/sched.c?

You want to use it for process migration, right? Not everyone wants
either software or process migration... We may want to keep overhead
low for embedded systems...

								Pavel 

-- 
Boycott Kodak -- for their patent abuse against Java.
