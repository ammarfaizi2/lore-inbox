Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262360AbUKZWg2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262360AbUKZWg2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 17:36:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262298AbUKZWdY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 17:33:24 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:27829 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S263999AbUKZV4Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 16:56:25 -0500
Subject: Re: Suspend 2 merge: 48/51: Swapwriter
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041125235527.GH2909@elf.ucw.cz>
References: <1101292194.5805.180.camel@desktop.cunninghams>
	 <1101300479.5805.389.camel@desktop.cunninghams>
	 <20041125235527.GH2909@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1101427554.27250.172.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Fri, 26 Nov 2004 11:05:54 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Fri, 2004-11-26 at 10:55, Pavel Machek wrote:
> Hi!
> 
> > This is the swapwriter. It is forms the glue between the highlevel I/O
> > routines in io.c and the blockwriter routines in block_io.c. It is
> > responsible for allocating storage, translating the requests for pages
> > within pagesets into devices and blocks and the like. It is abstracted
> > from the block writer because the plan is that we'll eventually have a
> > generic file writer (ie not using swapspace, but a simple file,
> > possibly
> 
> This file alone is bigger than whole swsusp1. That strongly suggests
> you have too many layers of abstraction in there. Planning for future
> is nice, but not at this cost.

Not necessarily too many layers of abstraction. It includes swapfile
support and there's a bit in there for readahead (plus the debugging you
mentioned).

Regards,

Nigel
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

You see, at just the right time, when we were still powerless, Christ
died for the ungodly.		-- Romans 5:6

