Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261640AbULTVVZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261640AbULTVVZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 16:21:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261647AbULTVVZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 16:21:25 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:11650 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261640AbULTVVW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 16:21:22 -0500
Subject: Re: [2.6 patch] ieee1394_core.c: remove unneeded EXPORT_SYMBOL's
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ben Collins <bcollins@debian.org>
Cc: Arne Caspari <arnem@informatik.uni-bremen.de>,
       Adrian Bunk <bunk@stusta.de>, linux1394-devel@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041220154638.GE457@phunnypharm.org>
References: <20041220015320.GO21288@stusta.de>
	 <41C694E0.8010609@informatik.uni-bremen.de>
	 <20041220143901.GD457@phunnypharm.org>
	 <1103555716.29968.27.camel@localhost.localdomain>
	 <20041220154638.GE457@phunnypharm.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1103573716.31512.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 20 Dec 2004 20:15:17 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2004-12-20 at 15:46, Ben Collins wrote:
> > You might as well remove the ifdef if you do that since vendors will
> > have to guess what the right answer is an will probably uniformly say
> > "Y". At that point its basically a non-option. Far better to submit the
> > driver
> 
> You are missing the point though. Lots of these are part of our API, and

I think you missed my point. Any vendor faced with that Config option
will say Y so almost every tree will always have it - so why ask as
opposed to keeping the status quo.

> into the kernel mainline. But that API is needed, none-the-less, to expose
> the internals of the system.
> 
> I'd hate to think that our "license" worries outweigh the small hacker
> community for some projects.

Sure but if Adrian was trying to just tidy licensing issues he'd submit
a switch to EXPORT_SYMBOL_GPL. (Admittedly for anything as closely tied
as the innards of the ieee1394 layer its probably implied anyway).

There are two conflicting goals here - to have clean complete API's and
to stamp out the large number of unused, historic and at times bogus
exports. If these API's are needed and used then they should stay just
as some others elsewhere in the kernel have.

Think of it as a case of the office cleaner having not realised the pile
of paper on the floor was important, thats all.

As to the video stuff - merging that is a parallel but unrelated
question and it seems it would be benefical to all involved.

Alan

