Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161024AbWBTQcz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161024AbWBTQcz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 11:32:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161021AbWBTQcq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 11:32:46 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:1165 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1161017AbWBTQci (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 11:32:38 -0500
Date: Mon, 20 Feb 2006 14:08:38 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Matthias Hensler <matthias@wspse.de>
Cc: Nigel Cunningham <nigel@suspend2.net>, Sebastian Kgler <sebas@kde.org>,
       kernel list <linux-kernel@vger.kernel.org>, rjw@sisk.pl
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Message-ID: <20060220130838.GC17627@elf.ucw.cz>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <20060211104130.GA28282@kobayashi-maru.wspse.de> <20060218142610.GT3490@openzaurus.ucw.cz> <200602200709.17955.nigel@suspend2.net> <20060219212952.GI15311@elf.ucw.cz> <20060220094300.GC19293@kobayashi-maru.wspse.de> <20060220103616.GC16042@elf.ucw.cz> <20060220105016.GA22552@kobayashi-maru.wspse.de> <20060220105406.GE16042@elf.ucw.cz> <20060220111724.GB22552@kobayashi-maru.wspse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060220111724.GB22552@kobayashi-maru.wspse.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Po 20-02-06 12:17:24, Matthias Hensler wrote:
> Hi.
> 
> On Mon, Feb 20, 2006 at 11:54:06AM +0100, Pavel Machek wrote:
> > On Po 20-02-06 11:50:16, Matthias Hensler wrote:
> > > OK, could you point me to the ugly thinks. I see message passing
> > > between the userspace application and the kernel, for which I think
> > > that netlink is a good choice.
> > 
> > See my comments in "suspend2 review" thread.
> 
> Yes, I read it. Nigel already replied and pointed out that a lot of
> things were already fixed and will now be. So the effort to make the
> patch acceptable is there.

Yep, Nigel fixes typo every time I show him one. That only shows how
old his code is, and how little review it got.

That's not making patch acceptable. His patch still duplicates lots of
kernel code, and puts code into kernelspace that can be done userspace
as well.

If you want to merge some code in kernelspace, you should do it in
small pieces, and should understand what existing code does. Nigel
does not care what existing code does. If swsusp contained problem 2
years ago, but mainline fixed it, Nigel still includes his
workarounds. (See his bitmap stuff). That's not the way to go.
									Pavel
-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
